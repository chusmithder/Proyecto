import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/models/3_food_model.dart';
import 'package:revdiet/models/4_user_food_model.dart';
import 'package:revdiet/models/4_user_weights_model.dart';

class DatabaseService {

  //FireAuth ---------------------------------------------------------------
  static String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  //DtUsers ---------------------------------------------------------------
  static Future<UserModel> getUserById(String userId) async {
    final docRef =
        await FirebaseFirestore.instance.collection("dtUsers").doc(userId);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await docRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel. fromJson(data);
  }

  static Future<void> updateUserByUserIdAndModel(
      String userId, UserModel user) async {
    await FirebaseFirestore.instance
        .collection('dtUsers')
        .doc(userId)
        .set(user.toJson());
  }

  static Future<void> insertUserInDtUsersByIdAndModel(
      String userId, UserModel user) async {
    FirebaseFirestore.instance
        .collection('dtUsers')
        .doc(userId)
        .set(user.toJson());
  }

  //dtUsersFood ---------------------------------------------------------------
  static Future<void> insertFoodInDtUsersFood(UserFoodModel food) async {
    await FirebaseFirestore.instance
        .collection('dtUsersFood')
        .add(food.toJson());
  }

  static Future<List<UserFoodModel>> getListUserFoodByUserIdFromDtUsersFood(
      String userId) async {
    var userFoodList = <UserFoodModel>[];
    QuerySnapshot<Map<String, dynamic>> queryUserFood =
        await FirebaseFirestore.instance
            .collection('dtUsersFood')
            .where('idUser', isEqualTo: userId)
            // .orderBy('description')
            .get();
    for (var doc in queryUserFood.docs) {
      //insertar id de la comida
      userFoodList.add(UserFoodModel.fromJson(doc.data()));
    }
    return userFoodList;
  }

  static Future<List<String>> getListIdsFoodByUserIdFomDtUsersFood(
      String userId) async {
    List<String> listUserIdsFood = <String>[];

    QuerySnapshot<Map<String, dynamic>> queryUserFood = await FirebaseFirestore
        .instance
        .collection('dtUsersFood')
        .where('idUser', isEqualTo: userId)
        .get();
    for (var doc in queryUserFood.docs) {
      listUserIdsFood.add(doc.id);
    }
    return listUserIdsFood;
  }

  //dtUsersWeights ---------------------------------------------------------------
  static Future<void> insertWeightInDtUsersWeights(
      UserWeightsModel userWeightsModel) async {
    await FirebaseFirestore.instance
        .collection('dtUsersWeights')
        .add(userWeightsModel.toJson());
  }

  static Future<List<UserWeightsModel>>
      getListUserWeightsByUserIdFromDtUsersWeights(String userId) async {
    var userWeightsList = <UserWeightsModel>[];
    QuerySnapshot<Map<String, dynamic>> queryUserFood =
        await FirebaseFirestore.instance
            .collection('dtUsersWeights')
            .where('idUser', isEqualTo: userId)
            .orderBy('date', descending: true)
            .get();
    for (var doc in queryUserFood.docs) {
      //insertar id de la comida
      userWeightsList.add(UserWeightsModel.fromJson(doc.data()));
    }
    return userWeightsList;
  }

  static Future<List<String>> getListIdsWeightsByUserIdFomDtUsersWeights(
      String userId) async {
    List<String> listUserIdsWeights = <String>[];

    QuerySnapshot<Map<String, dynamic>> queryUserWeights = await FirebaseFirestore
        .instance
        .collection('dtUsersWeights')
        .where('idUser', isEqualTo: userId)
        .get();
    for (var doc in queryUserWeights.docs) {
      listUserIdsWeights.add(doc.id);
    }
    return listUserIdsWeights;
  }

  //msFood ---------------------------------------------------------------
  static Future<List<FoodModel>> getListFoodFromMsFood() async {
    var foodList = <FoodModel>[];
    QuerySnapshot<Map<String, dynamic>> queryFood =
        await FirebaseFirestore.instance.collection('msFood').get();
    for (var doc in queryFood.docs) {
      foodList.add(FoodModel.fromJson(doc.data()));
    }
    return foodList;
  }

  static Future<void> insertFoodInMsFood(FoodModel food) async {
    await FirebaseFirestore.instance.collection('msFood').add(food.toJson());
  }

  // FoodModel food = FoodModel(
  //     // idFood: '',
  //     description: 'burger meat',
  //     calories: 209,
  //     carbs: 1.6,
  //     proteins: 17.0,
  //     fats: 15,
  //     gramsPerServing: 100,
  //   );

  //   await DatabaseService.insertFoodInMsFood(food);
}

