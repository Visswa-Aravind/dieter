import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dieter/Tracking/Exercises.dart';
import 'package:dieter/Login_Signup/Data_Viewing.dart';
import 'package:dieter/Tracking/bmi_track.dart';
import 'package:dieter/fapi/food_view.dart';
import 'package:dieter/fapi/grocery_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Pages_Drawer extends StatelessWidget {
  final User? user;
  final Future<void> Function() onSignOut;

  const Pages_Drawer({
    super.key,
    required this.user,
    required this.onSignOut,
  });

  Future<String> _fetchUserName() async {
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('Personals')
          .doc(user!.uid)
          .get();
      return doc.data()?['name'] ?? 'User Name';
    }
    return 'User Name';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 6.0,
      child: Column(
        children: [
          FutureBuilder<String>(
            future: _fetchUserName(),
            builder: (context, snapshot) {
              String userName = snapshot.data ?? 'Loading...';

              return UserAccountsDrawerHeader(
                accountName: Text(userName),
                accountEmail: Text(user?.email ?? 'User email'),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    user?.email?.substring(0, 1) ?? '',
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Profile Setup'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataViewing(),
                ),
              );
            },
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.sports_gymnastics),
            title: Text('BMI and Suggestions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BmiTracking(),
                ),
              );
            },
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.food_bank_outlined),
            title: Text('Meal Logging'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodView(),
                ),
              );
            },
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.track_changes_rounded),
            title: Text('Nutrient Tracking'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeSuggestionsScreen(),
                ),
              );
            },
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.fastfood_outlined),
            title: Text('Custom Food Entry'),
            onTap: () {},
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.psychology_rounded),
            title: Text('Progress'),
            onTap: () {},
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.alarm_add),
            title: Text('Reminders'),
            onTap: () {},
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.run_circle_outlined),
            title: Text('Workout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Exercises(),
                ),
              );
            },
          ),
          Divider(height: 0.5),
          ElevatedButton(onPressed: onSignOut, child: Text('Signout')),
        ],
      ),
    );
  }
}
