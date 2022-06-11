import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_reminder/model/user_model.dart';
import 'package:student_reminder/util/routes.dart';
import 'package:student_reminder/widget/custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  AuthController({required this.sharedPreferences});

  bool _isChecked = false;
  bool _isLoading = false;
  XFile? _file;

  bool get isChecked => _isChecked;
  bool get isLoading => _isLoading;
  XFile? get file => _file;

  void toggleCheck() {
    _isChecked = !_isChecked;
    update();
  }

  Future<void> registerUser(String email, String password, String name, String gender) async {
    _isLoading = true;
    update();
    try {
      UserCredential _userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password,
      );
      UserModel _user = UserModel(name: name, uid: _userCredential.user!.uid, gender: gender, email: email);
      debugPrint(('Body:=====> ${_user.toJson(true)}'));
      saveUserData(_user);
      FirebaseFirestore.instance.collection('user').doc(_userCredential.user!.uid).set(_user.toJson(true));
      Get.offAllNamed(Routes.getInitialRoute());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showCustomSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showCustomSnackBar('The account already exists for that email.');
      }else {
        showCustomSnackBar(e.toString());
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  Future<void> loginUser(String email, String password) async {
    _isLoading = true;
    update();
    try {
      UserCredential _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password,
      );
      DocumentSnapshot _doc = await FirebaseFirestore.instance.collection('user').doc(_userCredential.user!.uid).get();
      UserModel _user = UserModel.fromJson(_doc.data() as Map<String, dynamic>, true);
      debugPrint(('Data:=====> ${_user.toJson(true)}'));
      saveUserData(_user);
      Get.offAllNamed(Routes.getInitialRoute());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showCustomSnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showCustomSnackBar('Wrong password provided for that user.');
      }else {
        showCustomSnackBar(e.toString());
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  Future<void> resetPassword(String email) async {
    _isLoading = true;
    update();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.back();
      showCustomSnackBar('Password reset email sent to $email', isError: false);
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(e.message.toString());
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  Future<void> logoutUser() async {
    _isLoading = true;
    update();
    await FirebaseAuth.instance.signOut();
    _isLoading = false;
    update();
  }

  Future<void> updateUserProfile(UserModel user) async {
    _isLoading = true;
    update();
    try {
      User? _currentUser = FirebaseAuth.instance.currentUser;
      saveUserData(user);
      debugPrint(('Body:=====> ${user.toJson(true)}'));
      await FirebaseFirestore.instance.collection('user').doc(_currentUser!.uid).update(user.toJsonForUpdate());
    }catch(e) {
      showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  Future<void> updateProfileImage() async {
    _file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_file != null) {
      try {
        UploadTask _task = FirebaseStorage.instance.ref().child('user').child(_file!.name).putFile(File(_file!.path));
        TaskSnapshot _snapshot = await _task.whenComplete(() {});
        String _url = await _snapshot.ref.getDownloadURL();
        updateUserProfile(UserModel(image: _url));
      }catch(e) {
        showCustomSnackBar(e.toString());
      }
    }
  }

  void saveUserData(UserModel? user) {
    if(user != null) {
      sharedPreferences.setString('user', jsonEncode(user.toJsonForShared(getUserData())));
    }else {
      if(sharedPreferences.containsKey('user')) {
        sharedPreferences.remove('user');
      }
    }
  }

  UserModel? getUserData() {
    UserModel? _user;
    try{
      if(sharedPreferences.containsKey('user')) {
        String _data = sharedPreferences.getString('user') ?? '';
        _user = UserModel.fromJson(jsonDecode(_data), false);
      }
    // ignore: empty_catches
    }catch(e) {}
    return _user;
  }

  Future<bool> addTodo(TodoModel todo) async {
    _isLoading = true;
    update();
    DocumentSnapshot _doc = await FirebaseFirestore.instance.collection('user').doc(getUserData()!.uid).get();
    Map<String, dynamic> _data = _doc.data() as Map<String, dynamic>;
    UserModel _user = UserModel.fromJson(_data, true);
    bool _isSuccess = false;
    if(_user.todoList == null || _user.todoList!.isEmpty) {
      _user.todoList = [];
      _user.todoList!.add(todo);
      updateUserProfile(_user);
      await FirebaseFirestore.instance.collection('user').doc(getUserData()!.uid).update({'todo': []});
      await FirebaseFirestore.instance.collection('user').doc(getUserData()!.uid)
          .update({'todo': FieldValue.arrayUnion([todo.toJson(true)])});
      showCustomSnackBar('Weight updated successfully', isError: false);
      _isSuccess = true;
    }else {
      _user.todoList!.add(todo);
      updateUserProfile(_user);
      await FirebaseFirestore.instance.collection('user').doc(getUserData()!.uid)
          .update({'todo': FieldValue.arrayUnion([todo.toJson(true)])});
      showCustomSnackBar('Todo added successfully', isError: false);
      _isSuccess = true;
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  Future<void> updateTodo(int index, TodoModel? todo, bool isUpdate) async {
    DocumentSnapshot _doc = await FirebaseFirestore.instance.collection('user').doc(getUserData()!.uid).get();
    Map<String, dynamic> _data = _doc.data() as Map<String, dynamic>;
    UserModel _user = UserModel.fromJson(_data, true);
    _user.todoList!.removeAt(index);
    if(isUpdate) {
      _user.todoList!.insert(index, todo!);
    }
    List<Map<String, dynamic>> _todos = [];
    for(TodoModel todoModel in _user.todoList!) {
      _todos.add(todoModel.toJson(true));
    }
    updateUserProfile(_user);
    await FirebaseFirestore.instance.collection('user').doc(getUserData()!.uid).update({'todo': _todos});
    showCustomSnackBar(isUpdate ? 'Todo updated successfully' : 'Todo deleted successfully', isError: false);
  }

}