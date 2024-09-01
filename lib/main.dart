import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:wearable_rotary/wearable_rotary.dart' as wearable_rotary;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wearable Round Screen Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wearable Round Screen Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _subscribeToRotaryEvents();
  }

  void _subscribeToRotaryEvents() {
    wearable_rotary.rotaryEvents.listen((wearable_rotary.RotaryEvent event) {
      if (event.direction == wearable_rotary.RotaryDirection.clockwise) {
        _incrementCounter();
      } else {
        _decrementCounter();
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WatchShape(
        builder: (context, shape, child) {
          bool isRound = shape == WearShape.round;
          return AmbientMode(
            builder: (context, mode, child) {
              bool isAmbient = mode == WearMode.ambient;
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // Circular background for the round screen
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isAmbient
                            ? Colors.grey.shade800
                            : Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    // Content positioned for a round screen
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Rotations:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$_counter',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: isRound ? 20 : 10,
                      child: FloatingActionButton(
                        onPressed: _incrementCounter,
                        tooltip: 'Increment',
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}