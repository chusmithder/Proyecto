import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/models/4_user_food_model.dart';

class DatabaseService {
  static String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
  
  static Future<UserModel> getUserById(String userId) async {
    final docRef = FirebaseFirestore.instance.collection("dtUsers").doc(userId);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await docRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }

  static Future<void> updateUserByUserIdAndModel(String userId, UserModel user) async {
    await FirebaseFirestore.instance
            .collection('dtUsers')
            .doc(userId)
            .set(user.toJson());
  }

  static Future<List<String>> getListIdsFoodByUserId(String userId) async {
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

  static Future<void> insertFoodInDtUsersFood(UserFoodModel food) async {
    await FirebaseFirestore.instance
            .collection('dtUsersFood')
            .add(food.toJson());
  }
}
