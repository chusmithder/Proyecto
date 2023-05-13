import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/models/4_user_weights_model.dart';
import 'package:revdiet/screens/5_2_register_weight_screen.dart';
import 'package:revdiet/services/0_general_app_service.dart';
import 'package:revdiet/services/2_database_service.dart';

class ScaleScreen extends StatefulWidget {
  const ScaleScreen({super.key});

  @override
  State<ScaleScreen> createState() => _ScaleScreenState();
}

class _ScaleScreenState extends State<ScaleScreen> {
  final _userWeights = <UserWeightsModel>[];

  //cargar documentos de dtUsersWeights con id del usuario en _userWeights
  Future<void> _loadUserWeights() async {
    _userWeights.clear(); //borrar memoria
    try {
      String uid = await DatabaseService.getCurrentUserId();
      List<UserWeightsModel> weightsList =
          await DatabaseService.getListUserWeightsByUserIdFromDtUsersWeights(
              uid);
      setState(() {
        _userWeights.addAll(weightsList);
      });
    } catch (e) {
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
      print(e.toString());
    }
  }

  Future<void> _loadinitialData() async {
    await _loadUserWeights();
  }

  Future<void> _goToRegisterWeightScreen() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const RegisterWeightScreen(),
      ),
    );
    _loadinitialData();
  }

  @override
  void initState() {
    _loadinitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              _titleWidget(),
              const SizedBox(height: 30),
              _titleDescriptionWidget('Weight history'),
              const SizedBox(height: 15),
              _foodListWidget(_userWeights),
              const SizedBox(height: 15),
              CustomButton(
                  onTap: _goToRegisterWeightScreen,
                  buttonText: 'Register new weight')
            ],
          ),
        ),
      ),
    );
  }

  Widget _foodListWidget(List list) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 350,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 94, 94, 94),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final weight = list[index];
            return _itemTile(weight);
          },
        ),
      ),
    );
  }

  Widget _itemTile(UserWeightsModel weight) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 51, 51, 51),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        // leading: GestureDetector(
        //   onTap: () async {
        //     await _addFood(food);
        //   },
        //   child: const Icon(
        //     Icons.add,
        //     color: Color.fromARGB(255, 66, 204, 137),
        //   ),
        // ),
        title: Text(
          '${weight.weight.toString()} kg',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        subtitle: Text(
          DateTime.fromMillisecondsSinceEpoch(weight.date.seconds * 1000).toString(),
          style: const TextStyle(
            fontSize: 12.0,
            color: Color.fromARGB(255, 66, 204, 137),
          ),
        ),
      ),
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

  Widget _titleWidget() {
    return GestureDetector(
      child: const Text('RevDiet',
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 66, 204, 137))),
    );
  }
}
