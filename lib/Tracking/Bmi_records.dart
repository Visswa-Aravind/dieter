import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BmiRecordsPage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI and Waist-Hip Ratio Records'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Tracker')
            .where('email', isEqualTo: user?.email)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final records = snapshot.data!.docs;

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index].data() as Map<String, dynamic>;
              final height = record['height'];
              final weight = record['weight'];
              final bmi = record['bmi'];
              final waist = record['waist'];
              final hip = record['hip'];
              final waistHipRatio = record['waistHipRatio'];
              final timestamp = record['timestamp'] != null
                  ? (record['timestamp'] as Timestamp).toDate()
                  : DateTime.now();

              return ListTile(
                title: Text(
                    'Date: ${timestamp.toLocal().toString().split(' ')[0]}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Height: $height cm, Weight: $weight kg, BMI: ${bmi != null ? bmi.toStringAsFixed(2) : 'N/A'}'),
                    if (waist != null && hip != null && waistHipRatio != null)
                      Text(
                          'Waist: $waist cm, Hip: $hip cm, Waist-Hip Ratio: ${waistHipRatio.toStringAsFixed(2)}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('Tracker')
                        .doc(records[index].id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
