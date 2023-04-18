
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserModel {
  String? uid;
  final String email;
  final String? name;
  final Map<String, dynamic>? interests;


  UserModel({
    this.uid,
    required this.email,
    this.name,
    required this.interests,
  });

  tojson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'interests': interests,
    };
  }
}

class UserRepository extends GetxController {
  static UserRepository get to => Get.find();

  final _db = FirebaseFirestore.instance;


  createUser(UserModel user) async {
    await _db.collection('users').add(user.tojson()).whenComplete(() =>
        Get.snackbar('user created','Welcome to Vedas', snackPosition: SnackPosition.BOTTOM));


  }
}