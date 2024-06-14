import 'package:dieter/Tracking/Exercises.dart';
import 'package:flutter/material.dart';
import '__over__weight_state_container.dart';

class Over_Weight extends StatefulWidget {
  const Over_Weight({super.key});

  @override
  State<Over_Weight> createState() => _Over_WeightState();
}

class _Over_WeightState extends State<Over_Weight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Over Weight Suggestions'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/Overweight.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                    ), // Push the containers down initially
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            height: 300,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.sports_gymnastics_sharp,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Do',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Exercises',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Properly',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Exercises()),
                                      );
                                    },
                                    child: Text(
                                      'Click Here',
                                      style: TextStyle(color: Colors.indigo),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            height: 300,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.food_bank_outlined),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Foods',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'BrownieStencil-8O8MJ')),
                                Text('To',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'BrownieStencil-8O8MJ')),
                                Text('Eat',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'BrownieStencil-8O8MJ')),
                                SizedBox(
                                    height:
                                        20), // Adds space between text and circles
                                Ink(
                                  decoration: ShapeDecoration(
                                      color: Colors.lightGreenAccent,
                                      shape: OvalBorder()),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Veg',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        10), // Adds space between the two circles
                                Ink(
                                  decoration: ShapeDecoration(
                                    color: Colors.redAccent,
                                    shape: OvalBorder(),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Non Veg',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            height: 300,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.sports_gymnastics_sharp,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'To',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Calculate',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Your',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Daily',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Nutrients',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Click Here',
                                      style: TextStyle(color: Colors.indigo),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}