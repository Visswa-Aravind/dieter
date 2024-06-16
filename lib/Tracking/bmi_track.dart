import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dieter/bmi_types/fit.dart';
import 'package:dieter/bmi_types/obese.dart';
import 'package:dieter/bmi_types/over_weight.dart';
import 'package:dieter/bmi_types/under_weight.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import 'Bmi_records.dart';

class BmiTracking extends StatefulWidget {
  const BmiTracking({super.key});

  @override
  State<BmiTracking> createState() => _BmiTrackingState();
}

class _BmiTrackingState extends State<BmiTracking> {
  final User? user = Auth().currentUser;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  double? _bmi;
  double? _waistHipRatio;
  bool _isBmiCalculation = true;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    super.dispose();
  }

  void calculateAndStoreBMI() {
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      // Calculate BMI
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
      });

      // Store in Firestore
      CollectionReference cf = FirebaseFirestore.instance.collection('Tracker');

      cf.add({
        'uid': user?.uid,
        'email': user?.email,
        'weight': weight,
        'height': height,
        'bmi': _bmi,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show BMI result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('BMI: ${_bmi!.toStringAsFixed(2)}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid height and weight')),
      );
    }
  }

  void calculateAndStoreWaistHipRatio() {
    double waist = double.tryParse(_waistController.text) ?? 0.0;
    double hip = double.tryParse(_hipController.text) ?? 0.0;

    if (waist > 0 && hip > 0) {
      // Calculate Waist-Hip Ratio
      setState(() {
        _waistHipRatio = waist / hip;
      });

      // Store in Firestore
      CollectionReference cf = FirebaseFirestore.instance.collection('Tracker');
      cf.add({
        'uid': user?.uid,
        'email': user?.email,
        'waist': waist,
        'hip': hip,
        'waistHipRatio': _waistHipRatio,
        //'bmi': _bmi,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show Waist-Hip Ratio result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Waist-Hip Ratio: ${_waistHipRatio!.toStringAsFixed(2)}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please enter valid waist and hip measurements')),
      );
    }
  }

  DecorationImage bmilevelImage() {
    if (_bmi == null) {
      return DecorationImage(
          image: AssetImage('assets/images/default.png'), fit: BoxFit.cover);
    } else if (_bmi! < 18.5) {
      return DecorationImage(
          image: AssetImage('assets/images/underWeightsample.png'),
          fit: BoxFit.cover);
    } else if (_bmi! < 24.9) {
      return DecorationImage(
          image: AssetImage('assets/images/Fitsample.png'), fit: BoxFit.cover);
    } else if (_bmi! < 29.9) {
      return DecorationImage(
          image: AssetImage('assets/images/overWeightsample.png'),
          fit: BoxFit.cover);
    } else {
      return DecorationImage(
          image: AssetImage('assets/images/Obesesample.png'),
          fit: BoxFit.cover);
    }
  }

  Future<void> pager() {
    if (_bmi! < 18.5) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Under_Weight(),
        ),
      );
    } else if (_bmi! < 24.9) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Fit_Bmi(),
        ),
      );
    } else if (_bmi! < 29.9) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Over_Weight(),
        ),
      );
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Obese(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(220, 194, 244, 229),
      appBar: AppBar(
        title: Text('BMI Calculation'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BmiRecordsPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isBmiCalculation = !_isBmiCalculation;
                      });
                    },
                    child: Text(
                      !_isBmiCalculation
                          ? 'Click here for BMI Calculation'
                          : 'Click here for Waist and Hip ratio Calculation',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(10, 119, 52, 248),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: <Widget>[
                        if (_isBmiCalculation)
                          Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: _heightController,
                                    decoration: InputDecoration(
                                      labelText: 'Height (cm)',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _weightController,
                                    decoration: InputDecoration(
                                      labelText: 'Weight (kg)',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: _waistController,
                                    decoration: InputDecoration(
                                      labelText: 'Waist (cm)',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: TextFormField(
                                    controller: _hipController,
                                    decoration: InputDecoration(
                                      labelText: 'Hip (cm)',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70,
                          ),
                          onPressed: _isBmiCalculation
                              ? calculateAndStoreBMI
                              : calculateAndStoreWaistHipRatio,
                          child: Text(
                            _isBmiCalculation
                                ? 'Calculate BMI'
                                : 'Calculate Waist-Hip Ratio',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        if (_bmi != null && _isBmiCalculation) ...[
                          Text(
                            'Your BMI is ${_bmi!.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2.0),
                              borderRadius: BorderRadius.circular(20),
                              image: bmilevelImage(),
                            ),
                          ),
                        ] else if (_waistHipRatio != null &&
                            !_isBmiCalculation) ...[
                          Text(
                            'Your Waist-Hip Ratio is ${_waistHipRatio!.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                        if (_isBmiCalculation)
                          TextButton(
                              onPressed: () {
                                pager();
                              },
                              child: Text('For Suggestions !!! Click Here')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
