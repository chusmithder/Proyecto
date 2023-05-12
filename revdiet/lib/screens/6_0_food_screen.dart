import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/models/3_food_model.dart';
import 'package:revdiet/models/4_user_food_model.dart';
import 'package:revdiet/screens/6_1_create_food_screen.dart';
import 'package:revdiet/services/0_general_app_service.dart';

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
    var foodToAdd = <FoodModel>[];
    try {
      QuerySnapshot<Map<String, dynamic>> queryFood =
          await FirebaseFirestore.instance.collection('msFood').get();
      for (var doc in queryFood.docs) {
        foodToAdd.add(FoodModel.fromJson(doc.data()));
      }
      setState(() {
        _appFood.addAll(foodToAdd);
      });
    } catch (e) {
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
    }
  }

  //cargar documentos de dtUserFood en _userFood
  Future<void> _loadUserFood() async {
    _userFood.clear(); //borrar memoria
    var foodToAdd = <UserFoodModel>[];
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot<Map<String, dynamic>> queryUserFood =
          await FirebaseFirestore.instance
              .collection('dtUsersFood')
              .where('idUser', isEqualTo: uid)
              .get();
      for (var doc in queryUserFood.docs) {
        //insertar id de la comida
        foodToAdd.add(UserFoodModel.fromJson(doc.data()));
      }
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
  void _addFood() {

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
              _titleDescriptionWidget('Select app foods'),
              const SizedBox(height: 15),
              _foodListWidget(_appFood),
              const SizedBox(height: 30),
              _titleDescriptionWidget('Select your created foods'),
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
          onTap: _addFood,
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
