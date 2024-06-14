import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '__personal_data_state_text_form_field.dart';
import 'login_register_page.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({Key? key});
  @override
  State<PersonalData> createState() => _PersonalDataState();
}

List<String> options = ['Male', 'Female', 'Others'];

class _PersonalDataState extends State<PersonalData> {
  final User? user = Auth().currentUser;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  late TextEditingController ActivityLevelController;
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void navigateToLoginPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  String currentoption = options[0];
  double _currentSlidervalue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PersonalDataStateTextFormField(
                  type: false,
                  appear: TextInputType.name,
                  controller: nameController,
                  title: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                PersonalDataStateTextFormField(
                  type: true,
                  appear: TextInputType.emailAddress,
                  controller: _emailController,
                  title: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                PersonalDataStateTextFormField(
                  type: false,
                  appear: TextInputType.number,
                  controller: ageController,
                  title: 'Age',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                PersonalDataStateTextFormField(
                  type: false,
                  appear: TextInputType.number,
                  controller: weightController,
                  title: 'Weight',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                PersonalDataStateTextFormField(
                  type: false,
                  appear: TextInputType.number,
                  controller: heightController,
                  title: 'Height',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text('Rate about your Activity level 1 is low & 10 is high '),
                Text('(Your Level : ${_currentSlidervalue.round()})'),
                Slider(
                    value: _currentSlidervalue,
                    max: 10,
                    divisions: 10,
                    label: _currentSlidervalue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSlidervalue = value;
                      });
                    }),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Gender: '),
                    Radio<String>(
                        value: options[0],
                        groupValue: currentoption,
                        onChanged: (value) {
                          setState(() {
                            currentoption = value!;
                          });
                        }),
                    Text('Male'),
                    Radio<String>(
                        value: options[1],
                        groupValue: currentoption,
                        onChanged: (value) {
                          setState(() {
                            currentoption = value!;
                          });
                        }),
                    Text('Female'),
                    Radio<String>(
                        value: options[2],
                        groupValue: currentoption,
                        onChanged: (value) {
                          setState(() {
                            currentoption = value!;
                          });
                        }),
                    Text('Others'),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      CollectionReference cf =
                          FirebaseFirestore.instance.collection('Personals');
                      cf.add({
                        'uid': user?.uid,
                        'name': nameController.text,
                        'age': ageController.text,
                        'weight': weightController.text,
                        'email': _emailController.text,
                        'height': heightController.text,
                        'Activity Level': _currentSlidervalue,
                        'Gender': currentoption,
                      });
                      navigateToLoginPage(); // Navigate to LoginPage after form submission
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
