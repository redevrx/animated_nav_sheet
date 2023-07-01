import 'package:animated_nav_sheet/animated_nav_sheet.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnimatedNavbarScreen(),
    );
  }
}

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
