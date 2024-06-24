import 'package:flutter/material.dart';

import '../Recipe/Dishes.dart';
import '../Tracking/Exercises.dart';
import '../fapi/food_view.dart';

class Fit_Bmi extends StatefulWidget {
  const Fit_Bmi({super.key});

  @override
  State<Fit_Bmi> createState() => _Fit_BmiState();
}

class _Fit_BmiState extends State<Fit_Bmi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YOU ARE FIT'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/fit.png',
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
                                  'Don\'t',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'lose',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'BrownieStencil-8O8MJ'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Fitness',
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
                                      'Follow Here',
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
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VegetarianDishes()));
                                    },
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
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FoodView()));
                                    },
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
