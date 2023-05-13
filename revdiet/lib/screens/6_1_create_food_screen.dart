import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/components/3_custom_tile_input_food.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/models/4_user_food_model.dart';
import 'package:revdiet/services/0_general_app_service.dart';
import 'package:revdiet/services/2_database_service.dart';

class CreateFoodScreen extends StatefulWidget {
  const CreateFoodScreen({super.key});

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
        String userId = DatabaseService.getCurrentUserId();

        //insertar en dtUsersFood
        UserFoodModel food = _createFoodFromFields(userId);
        await DatabaseService.insertFoodInDtUsersFood(food);

        //obtener lista del usuario
        List<String> listUserIdsFood =
            await DatabaseService.getListIdsFoodByUserIdFomDtUsersFood(userId);

        //cambiar propiedad del usuario
        UserModel user = await DatabaseService.getUserById(userId);
        user.idsUserFood = listUserIdsFood;

        //actualizar idsUserFood de usuario en la bd
        await DatabaseService.updateUserByUserIdAndModel(userId, user);

        _restartFieldValues();
        // ignore: use_build_context_synchronously
        GeneralAppService.showMessage(
            'Food created successfully!', Colors.green, context);
      } else {
        String errorMessage = _allFieldsCompleted()
            ? 'The types of the fields are not the correct'
            : 'Fill all the fields';
        GeneralAppService.showMessage(errorMessage, Colors.red, context);
      }
    } catch (e) {
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
    }
  }

  UserFoodModel _createFoodFromFields(String uid) {
    UserFoodModel food = UserFoodModel(
        idUser: uid,
        description: descriptionController.text,
        calories: int.parse(caloriesController.text),
        carbs: double.parse(carbsController.text),
        proteins: double.parse(proteinsController.text),
        fats: double.parse(fatsController.text),
        gramsPerServing: double.parse(gramsPerServingController.text));
    return food;
  }

  void _restartFieldValues() {
    descriptionController.text = '';
    caloriesController.text = '';
    carbsController.text = '';
    proteinsController.text = '';
    fatsController.text = '';
    gramsPerServingController.text = '';
  }

  bool _allFieldsCompleted() {
    return descriptionController.text.isNotEmpty &&
        caloriesController.text.isNotEmpty &&
        carbsController.text.isNotEmpty &&
        proteinsController.text.isNotEmpty &&
        fatsController.text.isNotEmpty &&
        gramsPerServingController.text.isNotEmpty;
  }

  
  bool _checkFieldsType() {
    //TODO
    return true;
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
