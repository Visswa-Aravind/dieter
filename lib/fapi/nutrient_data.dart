import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth.dart';
import 'package:intl/intl.dart'; // For formatting the timestamp

class SavedDataPage extends StatelessWidget {
  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd – kk:mm')
        .format(dateTime); // Format the date and time
  }

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
                final document = snapshot.data!.docs[index];
                final data = document.data() as Map<String, dynamic>;
                final timestamp = data['timestamp'] as Timestamp?;
                final formattedTimestamp =
                    timestamp != null ? _formatTimestamp(timestamp) : 'No date';

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
                      Text(
                          'Date: $formattedTimestamp'), // Display formatted date and time
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Personals')
                          .doc(Auth().currentUser?.uid)
                          .collection('Mealtracker')
                          .doc(document
                              .id) // Corrected the way to access the document ID
                          .delete();
                    },
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
