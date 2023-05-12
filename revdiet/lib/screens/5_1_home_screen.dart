import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/1_custom_text_field.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/enums/activity_levels.dart';
import 'package:revdiet/enums/genders_enum.dart';
import 'package:revdiet/enums/physical_goals_enum.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/screens/6_0_food_screen.dart';
import 'package:revdiet/services/0_general_app_service.dart';
import 'package:revdiet/services/1_logical_service.dart';
import 'package:revdiet/services/2_database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  //usuario actual
  late UserModel user;

  //macronutrientes a completar
  late int caloriesToComplete = 0;
  late int carbsToComplete = 0;
  late int proteinsToComplete = 0;
  late int fatsToComplete = 0;

  //calorias completadas
  late final int completedCalories;
  late final int completedCarbs;
  late final int completedProteins;
  late final int completedFats;

  Future<void> _loadUser() async {
    try {
      String userId = await DatabaseService.getCurrentUserId();
      UserModel currentUser = await DatabaseService.getUserById(userId);
      setState(() {
        user = currentUser;
      });
    } on Exception catch (e) {
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
    }
  }

  Future<void> _loadMacronutriensToComplete() async {
    Genders gender;
    user.gender.toUpperCase() == 'MALE'
        ? gender = Genders.male
        : gender = Genders.female;
    //actvity
    ActivityLevels activityLevel = ActivityLevels.VeryActive;
    switch (user.activityLevel) {
      case 'Not very active':
        activityLevel = ActivityLevels.NotVeryActive;
        break;
      case 'Slightly active':
        activityLevel = ActivityLevels.SlightlyActive;
        break;
      case 'Active':
        activityLevel = ActivityLevels.Active;
        break;
    }

    PhysicalGoals physicalGoal = PhysicalGoals.Gain;
    switch (user.physicalGoal) {
      case 'Lose weight':
        physicalGoal = PhysicalGoals.Lose;
        break;
      case 'Maintain weight':
        physicalGoal = PhysicalGoals.Maintain;
        break;
    }

    var listCalsMacros = LogicalService.calculateCaloriesCarbsProteinsFats(
      gender: gender,
      weight: user.weight,
      height: user.height,
      age: DateTime.now().year - user.birthYear,
      activityLevel: activityLevel,
      physicalGoal: physicalGoal,
    );
    //cargarlos en las variables
    setState(() {
      caloriesToComplete = listCalsMacros[0];
      carbsToComplete = listCalsMacros[1];
      proteinsToComplete = listCalsMacros[2];
      fatsToComplete = listCalsMacros[3];
    });
    
  }

  Future<void> _loadCompletedMacronutriens() async {
    //reiniciarlos cada dia
    //obtener el valor
    //persistencia de datos
    setState(() {
      completedCalories = 0;
      completedCarbs = 0;
      completedProteins = 0;
      completedFats = 0;
    });
  }

  Future<void> _loadInitialData() async {
    await _loadUser();
    await _loadMacronutriensToComplete();
    await _loadCompletedMacronutriens();
  }

  @override
  void initState() {
    _loadInitialData();
    super.initState();
  }

  Future<void> _goToFoodScreen() async {
    //await
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FoodScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              _titleWidget(),
              const SizedBox(height: 25),
              _macrosTileWidget(),
              const SizedBox(height: 30),
              CustomButton(
                onTap: _goToFoodScreen,
                buttonText: 'Add food',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return GestureDetector(
      child: const Text('RevDiet',
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 66, 204, 137))),
    );
  }

  Widget _macrosTileWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 94, 94, 94),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Calories',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  completedCalories.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 66, 204, 137),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                const Text(
                  '/',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Text(
                  caloriesToComplete.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 10,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 66, 204, 137),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  height: 10,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            macrosWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget macrosWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          carbsWidget('Carbs', completedCarbs, carbsToComplete),
          const SizedBox(width: 15),
          carbsWidget('Proteins', completedProteins, proteinsToComplete),
          const SizedBox(width: 15),
          carbsWidget('Fats', completedFats, fatsToComplete),
        ],
      ),
    );
  }

  Widget carbsWidget(
      String macroName, int completedMacros, int macrosToComplet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 51, 51, 51),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            macroName,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                completedMacros.toString(),
                style: const TextStyle(
                    color: Color.fromARGB(255, 66, 204, 137),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
              const Text(
                '/',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
              Text(
                '${macrosToComplet.toString()} g',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}