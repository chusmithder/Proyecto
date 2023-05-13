import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/models/3_food_model.dart';
import 'package:revdiet/models/4_user_food_model.dart';
import 'package:revdiet/screens/6_1_create_food_screen.dart';
import 'package:revdiet/services/0_general_app_service.dart';
import 'package:revdiet/services/2_database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final _appFood = <FoodModel>[];

  final _userFood = <UserFoodModel>[];

  //cargar documentos de msFood en _addFood
  Future<void> _loadAppFood() async {
    _appFood.clear(); //borrar memoria
    try {
      List<FoodModel> foodToAdd =  await DatabaseService.getListFoodFromMsFood();
      setState(() {
        _appFood.addAll(foodToAdd);
      });
    } catch (e) {
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
    }
  }

  //cargar documentos de dtUserFood en _userFood
  Future<void> _loadUserFood() async {
    _userFood.clear(); //limpiar memoria
    try {
      String uid = DatabaseService.getCurrentUserId();
      List<UserFoodModel> foodToAdd = await DatabaseService.getListUserFoodByUserIdFromDtUsersFood(uid);
      setState(() {
        _userFood.addAll(foodToAdd);
      });
    } catch (e) {
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
    }
  }

  //ir a CreateFoodScreen
  Future<void> _goToCreateFoodScreen() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateFoodScreen(),
      ),
    );
    _loadinitialData();
  }

  //añadir a los macronutrientes consumidos los valores de la comida seleccionada
  Future<void> _addFood(dynamic food) async {
    try {
      int calories;
      double carbs;
      double proteins;
      double fats;
      if (food is FoodModel) {
        calories = food.calories;
        carbs = food.carbs;
        proteins = food.proteins;
        fats = food.fats;
      } else {
        calories = food.calories;
        carbs = food.carbs;
        proteins = food.proteins;
        fats = food.fats;
      }
      //cambiar los macronutrientes completados
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt('completedCalories',
          preferences.getInt('completedCalories')! + calories);
      preferences.setDouble(
          'completedCarbs', preferences.getDouble('completedCarbs')! + carbs);
      preferences.setDouble('completedProteins',
          preferences.getDouble('completedProteins')! + proteins);
      preferences.setDouble(
          'completedFats', preferences.getDouble('completedFats')! + fats);

      // ignore: use_build_context_synchronously
      GeneralAppService.showMessage('Successfully added!', Colors.green, context);
    } catch (e) {
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
    }
  }

  Future<void> _loadinitialData() async {
    await _loadAppFood();
    await _loadUserFood();
  }

  @override
  void initState() {
    _loadinitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              _titleWidget(),
              const SizedBox(height: 30),
              _titleDescriptionWidget('Select app food'),
              const SizedBox(height: 15),
              _foodListWidget(_appFood),
              const SizedBox(height: 30),
              _titleDescriptionWidget('Select your created food'),
              const SizedBox(height: 15),
              _foodListWidget(_userFood),
              const SizedBox(height: 20),
              CustomButton(
                onTap: _goToCreateFoodScreen,
                buttonText: 'Create custom food',
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

  Widget _titleDescriptionWidget(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _foodListWidget(List list) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 94, 94, 94),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final food = list[index];
            return _itemTile(food);
          },
        ),
      ),
    );
  }

  Widget _itemTile(dynamic food) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 51, 51, 51),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: () async {
            await _addFood(food);
          },
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 66, 204, 137),
          ),
        ),
        title: Text(
          food.description,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        subtitle: Text(
          '${food.calories} kcal - 1 portion (${food.gramsPerServing} g)',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
