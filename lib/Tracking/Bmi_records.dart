import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BmiRecordsPage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI & Waist-Hip Ratio Records'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Personals')
            .doc(user?.uid)
            .collection('Tracker')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No records found.'));
          }

          final records = snapshot.data!.docs;

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index].data() as Map<String, dynamic>;
              final bmi = record.containsKey('bmi')
                  ? record['bmi'].toStringAsFixed(2)
                  : 'N/A';
              final waistHipRatio = record.containsKey('waistHipRatio')
                  ? record['waistHipRatio'].toStringAsFixed(2)
                  : 'N/A';
              final weight = record.containsKey('weight')
                  ? record['weight'].toString()
                  : 'N/A';
              final height = record.containsKey('height')
                  ? record['height'].toString()
                  : 'N/A';
              final waist = record.containsKey('waist')
                  ? record['waist'].toString()
                  : 'N/A';
              final hip =
                  record.containsKey('hip') ? record['hip'].toString() : 'N/A';
              final timestamp = record.containsKey('timestamp')
                  ? (record['timestamp'] as Timestamp).toDate().toString()
                  : 'N/A';

              return ListTile(
                title: Text('Recorded on: $timestamp'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BMI: $bmi'),
                    Text('Weight: $weight kg'),
                    Text('Height: $height cm'),
                    Text('Waist-Hip Ratio: $waistHipRatio'),
                    Text('Waist: $waist cm'),
                    Text('Hip: $hip cm'),
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
