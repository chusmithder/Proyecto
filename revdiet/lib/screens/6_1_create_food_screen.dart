import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/components/3_custom_tile_input_food.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/models/4_user_food_model.dart';

class CreateFoodScreen extends StatefulWidget {
  CreateFoodScreen({super.key});

  @override
  State<CreateFoodScreen> createState() => _CreateFoodScreenState();
}

class _CreateFoodScreenState extends State<CreateFoodScreen> {
  final descriptionController = TextEditingController();
  final caloriesController = TextEditingController();
  final carbsController = TextEditingController();
  final proteinsController = TextEditingController();
  final fatsController = TextEditingController();
  final gramsPerServingController = TextEditingController();

  //create and add food
  Future<void> _saveFood() async {
    try {
      if (_allFieldsCompleted() && _checkFieldsType()) {
        //obtener id usuario actual FireAuth
        String uid = FirebaseAuth.instance.currentUser!.uid;

        //insertar en dtUsersFood
        UserFoodModel food = UserFoodModel(
            idUser: uid,
            description: descriptionController.text,
            calories: int.parse(caloriesController.text),
            carbs: double.parse(carbsController.text),
            proteins: double.parse(proteinsController.text),
            fats: double.parse(fatsController.text),
            gramsPerServing: double.parse(gramsPerServingController.text));
        
        await FirebaseFirestore.instance
            .collection('dtUsersFood')
            .add(food.toJson());

        //obtener lista de comidas con id del usario
        List<String> listUserIdsFood = <String>[];

        QuerySnapshot<Map<String, dynamic>> queryUserFood =
            await FirebaseFirestore.instance.collection('dtUsersFood').where('idUser', isEqualTo: uid).get();
        for (var doc in queryUserFood.docs) {
          //insertar id de la comida
          listUserIdsFood.add(doc.id);
        }
        //cambiar propiedad del usuario
        final userRef = await FirebaseFirestore.instance.collection('dtUsers').doc(uid).get();
        UserModel user = UserModel.fromJson(userRef.data() as Map<String, dynamic>);
        user.idsUserFood = listUserIdsFood;

        //actualizar idsUserFood de usuario en la bd
        await FirebaseFirestore.instance.collection('dtUsers').doc(uid).set(user.toJson());

      } else {
        showErrorMessage(_allFieldsCompleted()
            ? 'The types of the fields are not the correct'
            : 'Fill all the fields');
      }
    } catch (e) {
      showErrorMessage(e.toString());
    }
  }

  //check all fields are complete
  bool _allFieldsCompleted() {
    return descriptionController.text.isNotEmpty &&
        caloriesController.text.isNotEmpty &&
        carbsController.text.isNotEmpty &&
        proteinsController.text.isNotEmpty &&
        fatsController.text.isNotEmpty &&
        gramsPerServingController.text.isNotEmpty;
  }

  bool _checkFieldsType() {
    return true;
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text('Create food',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 66, 204, 137))),
              const SizedBox(height: 30),
              CustomTileInputFood(
                controller: descriptionController,
                rightText: 'Description',
                inputType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              CustomTileInputFood(
                controller: caloriesController,
                rightText: 'Calories (kcal)',
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              CustomTileInputFood(
                controller: carbsController,
                rightText: 'Carbs (g)',
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              CustomTileInputFood(
                controller: proteinsController,
                rightText: 'Proteins (g)',
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              CustomTileInputFood(
                controller: fatsController,
                rightText: 'Fats (g)',
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              CustomTileInputFood(
                controller: gramsPerServingController,
                rightText: 'Grams per serving (g)',
                inputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        // width: 100,
        child: CustomButton(
          onTap: _saveFood,
          buttonText: 'Add food',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
