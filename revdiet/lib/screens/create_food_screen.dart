import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/components/3_custom_tile_input_food.dart';

class CreateFoodScreen extends StatelessWidget {
  CreateFoodScreen({super.key});

  final descriptionController = TextEditingController();
  final caloriesController = TextEditingController();
  final carbsController = TextEditingController();
  final proteinsController = TextEditingController();
  final fatsController = TextEditingController();
  final gramsPerServingController = TextEditingController();

  //create and add food
  void _saveFood() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 204, 137),
        title: const Center(child: Text('Create food')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
