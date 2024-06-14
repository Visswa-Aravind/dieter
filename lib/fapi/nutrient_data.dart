import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth.dart';

class SavedDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Personals')
            .doc(Auth().currentUser?.uid)
            .collection('Mealtracker')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No saved data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['recipeName'] ?? 'Unknown Recipe'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Calories: ${data['calories']}'),
                      Text('Protein: ${data['protein']} g'),
                      Text('Fat: ${data['fat']} g'),
                      Text('Carbs: ${data['carbs']} g'),
                      Text('Fiber: ${data['fiber']} g'),
                      Text('Sugar: ${data['sugar']} g'),
                      Text('Sodium: ${data['sodium']} g'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
