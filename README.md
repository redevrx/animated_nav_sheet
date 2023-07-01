<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Install Package
```
animated_nav_sheet: 1.0.0
```

## Animation
```dart
  final _navController = NavController();
///animation forward
  _navController.forward();
  
///animation reverse
_navController.reverse();
```

## Preview
<img src="https://github.com/redevrx/chat_gpt_sdk/blob/main/assets/example/Screenshot_1684672351.png?raw=true" width="350" height="760">
<img src="https://github.com/redevrx/chat_gpt_sdk/blob/main/assets/example/Screenshot_1684672512.png?raw=true" width="350" height="760">
<img src="https://github.com/redevrx/chat_gpt_sdk/blob/main/assets/example/Screenshot_1684672715.png?raw=true" width="350" height="760">



## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
class AnimatedNavbarScreen extends StatefulWidget {
  const AnimatedNavbarScreen({super.key});

  @override
  State<AnimatedNavbarScreen> createState() => _AnimatedNavbarScreenState();
}

class _AnimatedNavbarScreenState extends State<AnimatedNavbarScreen> {
  final _navController = NavController();

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimationNavSheet(
        color: Colors.primaries[3 % Colors.primaries.length],
        maxHeight: size.height * .5,
        navWidget: GestureDetector(
          onTap: () {
            _navController.forward();
          },
          child: buildContainerMin(),
        ),
        expendedWidget: GestureDetector(
          onTap: () {},
          child: buildContainerMax(),
        ),
        navController: _navController,
        child: Center(
          child: Text(
            "Example Animation Nav Sheet",
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildContainerMax() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _navController.reverse();
              },
              child: const Text('Open sheet')),
          ElevatedButton(onPressed: () {}, child: const Text('Open sheet')),
          ElevatedButton(onPressed: () {}, child: const Text('Open sheet')),
        ],
      ),
    );
  }

  Row buildContainerMin() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.home_max,
          color: Colors.white,
        ),
        Icon(
          Icons.people_alt_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.settings,
          color: Colors.white,
        )
      ],
    );
  }
}
```

# animated_nav_sheet
