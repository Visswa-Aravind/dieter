import 'package:dieter/Login_Signup/pages__drawer.dart';
import 'package:dieter/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_register_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_circle_right),
            onPressed: () {
              signOut(context);
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user?.email ?? 'User email'),
          ],
        ),
      ),
      drawer: Pages_Drawer(
        user: user,
        onSignOut: () => signOut(context),
      ),
    );
  }
}
