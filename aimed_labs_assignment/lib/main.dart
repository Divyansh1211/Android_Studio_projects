import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double desiredWidthPercentage = 0.9;
            double actualWidth = constraints.maxWidth * desiredWidthPercentage;

            return SafeArea(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Container(
                    color: Colors.red.shade300,
                    width: actualWidth,
                    height: 100.0,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 30,
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            color: Colors.grey.shade400,
                            width: actualWidth * 0.4,
                            height: 100.0,
                          ),
                        ),
                        Positioned(
                          top: 30,
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            color: Colors.green.shade300,
                            width: actualWidth * 0.8,
                            height: 100.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    color: Colors.red.shade300,
                    width: actualWidth,
                    height: 100.0,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 1,
                          left: 0,
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            color: Colors.grey.shade400,
                            width: actualWidth * 0.4,
                            height: 100.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20.0),
                          color: Colors.green.shade300,
                          width: actualWidth * 0.8,
                          height: 100.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
