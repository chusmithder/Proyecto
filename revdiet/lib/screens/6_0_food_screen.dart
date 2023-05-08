import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/models/3_food_model.dart';
import 'package:revdiet/screens/6_1_create_food_screen.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  //app food list
  final _appFood = <FoodModel>[
    FoodModel(
        description: 'bread',
        calories: 100,
        carbs: 10,
        proteins: 20,
        fats: 30,
        gramsPerServing: 100),
    FoodModel(
        description: 'apple',
        calories: 40,
        carbs: 10,
        proteins: 10,
        fats: 30,
        gramsPerServing: 50),
    FoodModel(
        description: 'apple',
        calories: 40,
        carbs: 10,
        proteins: 10,
        fats: 30,
        gramsPerServing: 50),
  ];

  //created food list
  final _createdFood = <FoodModel>[];

  //created food list
  Future<void> _createFood() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateFoodScreen(),
      ),
    );
  }

  void _addFood() {}

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
              _appFoodListWidget(_appFood),
              const SizedBox(height: 30),
              _titleDescriptionWidget('Select your created foods'),
              const SizedBox(height: 15),
              _appFoodListWidget(_createdFood),
              const SizedBox(height: 20),
              CustomButton(
                onTap: _createFood,
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

  Widget _appFoodListWidget(List list) {
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

  Widget _itemTile(FoodModel food) {
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
