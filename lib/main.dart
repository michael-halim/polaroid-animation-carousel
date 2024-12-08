import 'package:flutter/material.dart';
import 'package:polaroid/components/my_polaroid_carousel.dart';
import 'package:polaroid/components/polaroid_photo.dart';
import 'dart:math' show pi;
import 'package:polaroid_carousel/polaroid_carousel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late int duration = 0;

  // void addDuration() {
  //   setState(() {
  //     duration = 500;
  //   });
  //
  //   Future.delayed(Duration(milliseconds: 1500), () {
  //     setState(() {
  //       duration = 0; // Revert duration back to 0 after 500ms
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      PolaroidPhoto(
        image: Image.asset(
          'assets/images/20230814_174024.jpg',
          fit: BoxFit.cover,
          height: 240,
          width: 180,

        ),
        caption: 'Sample 1',
        rotation: pi / 8,
      ),
      PolaroidPhoto(
        image: Image.asset(
          'assets/images/20230814_174024.jpg',
          fit: BoxFit.cover,
          height: 240,
          width: 180,
        ),
        caption: 'Sample 2',
        rotation: pi / 40,
      ),
      PolaroidPhoto(
        image: Image.asset(
          'assets/images/20230814_174024.jpg',
          fit: BoxFit.cover,
          height: 240,
          width: 180,
        ),
        caption: 'Sample 3',
        rotation: pi / 15,
      ),
      PolaroidPhoto(
        image: Image.asset(
          'assets/images/20230814_174024.jpg',
          fit: BoxFit.cover,
          height: 240,
          width: 180,
        ),
        caption: 'Sample 4',
        rotation: -pi / 15,
      ),
      PolaroidPhoto(
        image: Image.asset(
          'assets/images/20230814_174024.jpg',
          fit: BoxFit.cover,
          height: 240,
          width: 180,
        ),
        caption: 'Sample 5',
        rotation: -pi / 8,
      ),
      PolaroidPhoto(
        image: Image.asset(
          'assets/images/20230814_174024.jpg',
          fit: BoxFit.cover,
          height: 240,
          width: 180,
        ),
        caption: 'Sample 6',
        rotation: -pi / 40,
      ),
    ];

    return Scaffold(
      body: Center(
        child: MyPolaroidCarousel(
          // Add a unique key based on duration
          translateFactor: 150,
          children: list,
          duration: Duration(
            milliseconds: 200,
          ),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
