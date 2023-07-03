import 'dart:async';
import 'dart:ui';
import 'package:animated_nav_sheet/src/nav_controller.dart';
import 'package:flutter/material.dart';

class AnimationNavSheet extends StatefulWidget {
  const AnimationNavSheet(
      {super.key,
      required this.maxHeight,
      this.minHeight = 60.0,
      required this.child,
      required this.navWidget,
      required this.expendedWidget,
      this.bottom = 40,
      this.color = Colors.indigoAccent,
      this.radius = 20.0,
      required this.navController,
      this.padding = const EdgeInsets.all(16.0),
      this.duration = const Duration(milliseconds: 700)});

  ///max height bottom sheet [maxHeight]
  final double maxHeight;
  ///min height for navigation bar [minHeight]
  final double minHeight;
  ///child [child]
  final Widget child;
  ///navigation bar item [navWidget]
  final Widget navWidget;
  ///expended child or bottom sheet child [expendedWidget]
  final Widget expendedWidget;
  ///margin bottom of navigation bar
  ///default value 40.0 [bool]
  final double bottom;
  ///nav sheet color [color]
  final Color color;
  ///nav sheet radius [radius]
  ///default value 20.0
  final double radius;
  ///nav sheet controller
  ///using play animation
  ///[navController]
  final NavController navController;
  ///sheet padding [padding]
  ///default value 16.0
  final EdgeInsetsGeometry? padding;
  ///animation duration
  ///default duration 700
  final Duration? duration;

  @override
  State<AnimationNavSheet> createState() => _AnimationNavSheetState();
}

class _AnimationNavSheetState extends State<AnimationNavSheet>
    with SingleTickerProviderStateMixin {
  ///animation controller
  late AnimationController _controller;

  ///current height for nav
  double _currentHeight = 0.0;

  ///Subscription for current height change
  StreamSubscription<bool>? _streamSubscription;

  @override
  void initState() {
    ///default current is min height
    ///using for navigation bar height
    _currentHeight = widget.minHeight;

    ///create animation controller
    _controller = AnimationController(vsync: this, duration: widget.duration);

    ///add animation controller to nav controller
    widget.navController.setAnimationController(_controller);

    ///update current height
    ///when using nav controller show sheet from navigation bar
    _streamSubscription = widget.navController.updateHeight.listen((_) {
      ///update height
      _currentHeight = widget.maxHeight;
    });
    super.initState();
  }

  @override
  void dispose() {
    ///close animation controller
    _controller.dispose();
    ///close nav controller
    widget.navController.dispose();
    ///close stream subscription
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ///content
        widget.child,
        StreamBuilder(
          initialData: false,
          stream: widget.navController.isExpended,
          builder: (context, expended) {
            return GestureDetector(
              onVerticalDragUpdate: (details) {
                final newHeight = _currentHeight - details.delta.dy;
                _controller.value = _currentHeight / widget.maxHeight;
                _currentHeight =
                    newHeight.clamp(widget.minHeight, widget.maxHeight);
              },
              onVerticalDragEnd: (details) {
                if (_currentHeight < widget.maxHeight / 2) {
                  _controller.reverse();
                  widget.navController.isExpendedChange(false);
                } else {
                  widget.navController.isExpendedChange(true);
                  _controller.forward(from: _currentHeight / widget.maxHeight);
                  _currentHeight = widget.maxHeight;
                }
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final value =
                      const ElasticInOutCurve(.7).transform(_controller.value);
                  return Stack(
                    children: [
                      Positioned(
                        height:
                            lerpDouble(widget.minHeight, _currentHeight, value),
                        width: lerpDouble(size.width * .5, size.width, value),
                        left: lerpDouble(
                            size.width / 2 - size.width * .5 / 2, 0, value),
                        bottom: lerpDouble(widget.bottom, 0.0, value),
                        child: Container(
                            padding: widget.padding,
                            decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(widget.radius),
                                    bottom: Radius.circular(
                                        (lerpDouble(widget.radius, 0.0, value))
                                            as double))),
                            child: expended.data == true
                                ? Opacity(
                                    opacity: _controller.value,
                                    child: widget.expendedWidget,
                                  )
                                : widget.navWidget),
                      )
                    ],
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
