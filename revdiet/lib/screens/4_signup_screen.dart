import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/1_custom_text_field.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/services/0_general_app_service.dart';
import 'package:revdiet/services/2_database_service.dart';

class SignUpScreen extends StatefulWidget {
  final Function()? onTap;

  const SignUpScreen({required this.onTap, super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  //username
  final usernameController = TextEditingController();
  //email
  final emailController = TextEditingController();
  //password
  final passwordController = TextEditingController();
  //passwordConfirmation
  final passwordConfirmationController = TextEditingController();

  //physicalGoal
  static List<String> physicalGoalList = <String>[
    'Gain weight',
    'Maintain weight',
    'Lose weight'
  ];
  String physicalGoalValue = physicalGoalList.first;
  //activityLevel
  static List<String> activityLevelList = <String>[
    'Not very active',
    'Slightly active',
    'Active',
    'Very Active'
  ];
  String activityLevelValue = activityLevelList.first;
  //gender
  static List<String> genderList = <String>[
    'Male',
    'Female',
  ];
  String genderValue = genderList.first;
  //birthdate
  DateTime birthDateValue = DateTime(2022, 12, 24);
  // height
  final heightController = TextEditingController();
  // weight;
  final weightController = TextEditingController();
  // residenceCountry
  final residenceCountryController = TextEditingController();

  void _createAccount() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (allFieldsAreFilled() & allValuesAreValid()) {
        if (passwordController.text == passwordConfirmationController.text) {
          //insert into authbase
          final userAuth =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          //insert into users collection
          final userModel = UserModel(
            idUser: userAuth.user!.uid,
            email: emailController.text,
            gender: genderValue.toUpperCase(),
            birthYear: birthDateValue.year,
            weight: double.parse(weightController.text),
            height: int.parse(heightController.text),
            activityLevel: activityLevelValue,
            physicalGoal: physicalGoalValue,
          );

          //insert into collection dtUsers
          DatabaseService.insertUserInDtUsersByIdAndModel(userAuth.user!.uid, userModel);
          
          // ignore: use_build_context_synchronously
          GeneralAppService.showMessage(
              'User created successfully!', Colors.green, context);

        } else {
          GeneralAppService.showMessage(
              'Passwords do not match!', Colors.red, context);
        }
      } else {
        GeneralAppService.showMessage(
            'Complete required fields!', Colors.red, context);
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
    }
  }

  bool allFieldsAreFilled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        weightController.text.isNotEmpty;
  }

  bool allValuesAreValid() {
    return true;
  }

  Future<DateTime?> _pickDate() {
    return showDatePicker(
      context: context,
      initialDate: birthDateValue,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text('Welcome to RevDiet',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 10),
                const Text('Create an account',
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                const SizedBox(height: 50),

                //physicalGoal
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'What is your goal?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: Colors.grey,
                    alignment: Alignment.center,
                    value: physicalGoalValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 15,
                    underline: Container(
                      height: 1,
                      color: Color.fromARGB(255, 66, 204, 137),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String? value) {
                      setState(() {
                        physicalGoalValue = value!;
                      });
                    },
                    items: physicalGoalList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //activityLevel
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'What is activity level?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: Colors.grey,
                    alignment: Alignment.center,
                    value: activityLevelValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 15,
                    underline: Container(
                      height: 1,
                      color: Color.fromARGB(255, 66, 204, 137),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (String? value) {
                      setState(() {
                        activityLevelValue = value!;
                      });
                    },
                    items: activityLevelList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  //gender
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Select your gender',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              dropdownColor: Colors.grey,
                              alignment: Alignment.center,
                              value: genderValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 15,
                              underline: Container(
                                height: 1,
                                color: Color.fromARGB(255, 66, 204, 137),
                              ),
                              style: const TextStyle(color: Colors.white),
                              onChanged: (String? value) {
                                setState(() {
                                  genderValue = value!;
                                });
                              },
                              items: genderList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //age
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Select your birthdate',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: MaterialButton(
                              child: Text(
                                '${birthDateValue.year.toString()} - ${birthDateValue.month.toString()} - ${birthDateValue.day.toString()}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                final date = await _pickDate();
                                if (date == null) return; //pressed cancel
                                setState(() {
                                  birthDateValue = date;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    //height
                    Expanded(
                      child: CustomTextField(
                        controller: heightController,
                        hintText: 'Height',
                        obscuredText: false,
                        icon: Icons.height,
                        inputType: TextInputType.number,
                      ),
                    ),
                    //weight
                    Expanded(
                      child: CustomTextField(
                        controller: weightController,
                        hintText: 'Weight',
                        obscuredText: false,
                        icon: Icons.scale,
                        inputType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // //desiredWeight
                // Row(
                //   children: [
                //     //residenceCountry
                //     Expanded(
                //       child: CustomTextField(
                //         controller: residenceCountryController,
                //         hintText: 'Residence Country',
                //         obscuredText: false,
                //         icon: Icons.location_city,
                //         inputType: TextInputType.text,
                //       ),
                //     ),
                //   ],
                // ),

                // const SizedBox(height: 20),

                //username textfield
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[900],
                  ),
                  child: Column(
                    children: [
                      // const SizedBox(height: 20),

                      // CustomTextField(
                      //   controller: usernameController,
                      //   hintText: 'Username',
                      //   obscuredText: false,
                      //   icon: Icons.person,
                      //   inputType: TextInputType.text,
                      // ),

                      const SizedBox(height: 20),

                      //email textfield
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscuredText: false,
                        icon: Icons.mail,
                        inputType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 20),

                      //password textfield
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscuredText: true,
                        icon: Icons.lock,
                        inputType: TextInputType.text,
                      ),

                      const SizedBox(height: 20),

                      //password confiramtion textfield
                      CustomTextField(
                        controller: passwordConfirmationController,
                        hintText: 'Password confirmation',
                        obscuredText: true,
                        icon: Icons.lock,
                        inputType: TextInputType.text,
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                //sign in button
                CustomButton(
                  onTap: _createAccount,
                  buttonText: 'Create account',
                ),

                const SizedBox(height: 30),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
