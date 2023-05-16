import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/components/3_custom_tile_input_food.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/models/4_user_weights_model.dart';
import 'package:revdiet/services/0_general_app_service.dart';
import 'package:revdiet/services/2_database_service.dart';

class RegisterWeightScreen extends StatefulWidget {
  const RegisterWeightScreen({super.key});

  @override
  State<RegisterWeightScreen> createState() => _RegisterWeightScreenState();
}

class _RegisterWeightScreenState extends State<RegisterWeightScreen> {
  final weightController = TextEditingController();

  Future<void> _saveWeight() async {
    if (weightController.text.isNotEmpty) {
      String userId = DatabaseService.getCurrentUserId();

      //insertar en dtUsersWeights
      UserWeightsModel weightModel = _createWeightFromFields(userId);
        await DatabaseService.insertWeightInDtUsersWeights(weightModel);

      //obtener lista de pesos del usuario
      List<String> listUserIdsWeight =
            await DatabaseService.getListIdsWeightsByUserIdFomDtUsersWeights(userId);

      //cambiar propiedad idsUserWeights sdel usuario
        UserModel user = await DatabaseService.getUserById(userId);
        user.idsUserWeights = listUserIdsWeight;

      //actualizar usuario en la bd
        await DatabaseService.updateUserByUserIdAndModel(userId, user);

        _restartFieldValues();
        // ignore: use_build_context_synchronously
        GeneralAppService.showMessage(
            'Weight registered successfully!', Colors.green, context);
      
    } else {
      String errorMessage = weightController.text.isNotEmpty
            ? 'The type of the field must be a number'
            : 'Fill the field';
        GeneralAppService.showMessage(errorMessage, Colors.red, context);
    }
  }

  UserWeightsModel _createWeightFromFields(String uid) {
    UserWeightsModel weight = UserWeightsModel(
        idUser: uid,
        date: Timestamp.now(),
        weight: double.parse(weightController.text));
    return weight;
  }

  void _restartFieldValues() {
    weightController.text = '';
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
              const Text('Register new weight',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 66, 204, 137))),
              const SizedBox(height: 30),
              CustomTileInputFood(
                controller: weightController,
                rightText: 'Weight',
                inputType: TextInputType.text,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        // width: 100,
        child: CustomButton(
          onTap: _saveWeight,
          buttonText: 'Register new weight',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
