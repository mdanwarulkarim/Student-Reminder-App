import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? name;
  String? image;
  String? gender;
  String? email;
  List<TodoModel>? todoList;

  UserModel(
      {this.uid,
        this.name,
        this.image,
        this.email,
        this.gender,
        this.todoList,
      });

  UserModel.fromJson(Map<String, dynamic> json, bool firebase) {
    uid = json['uid'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    gender = json['gender'];
    if (json['todo'] != null) {
      todoList = <TodoModel>[];
      json['todo'].forEach((v) {
        todoList!.add(TodoModel.fromJson(v, firebase));
      });
    }else {
      todoList = [];
    }
  }

  Map<String, dynamic> toJson(bool firebase) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['gender'] = gender;
    if (todoList != null) {
      data['todo'] = todoList!.map((v) => v.toJson(firebase)).toList();
    }else {
      data['todo'] = [];
    }
    return data;
  }

  Map<String, dynamic> toJsonForShared(UserModel? user) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(uid != null) {
      data['uid'] = uid;
    }else if(user != null) {
      data['uid'] = user.uid;
    }
    if(name != null) {
      data['name'] = name;
    }else if(user != null) {
      data['name'] = user.name;
    }
    if(image != null) {
      data['image'] = image;
    }else if(user != null) {
      data['image'] = user.image;
    }
    if(email != null) {
      data['email'] = email;
    }else if(user != null) {
      data['email'] = user.email;
    }
    if(gender != null) {
      data['gender'] = gender;
    }else if(user != null) {
      data['gender'] = user.gender;
    }
    if (todoList != null) {
      data['todo'] = todoList!.map((v) => v.toJson(false)).toList();
    }else {
      data['todo'] = [];
    }
    return data;
  }

  Map<String, dynamic> toJsonForUpdate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(uid != null) {
      data['uid'] = uid;
    }
    if(name != null) {
      data['name'] = name;
    }
    if(image != null) {
      data['image'] = image;
    }
    if(email != null) {
      data['email'] = email;
    }
    if(gender != null) {
      data['gender'] = gender;
    }
    return data;
  }
}

class TodoModel {
  String? title;
  String? details;
  DateTime? date;
  bool? isChecked;
  TodoModel({@required this.title, @required this.details, @required this.date, @required this.isChecked});

  TodoModel.fromJson(Map<String, dynamic> json, bool firebase) {
    title = json['title'];
    details = json['details'];
    isChecked = json['is_checked'];
    date = json['date'] != null ? firebase ? DateTime.parse(json['date'].toDate().toString())
        : DateTime.parse(json['date']) : null;
  }

  Map<String, dynamic> toJson(bool firebase) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['details'] = details;
    data['is_checked'] = isChecked;
    data['date'] = date != null ? firebase ? date : date!.toIso8601String() : null;
    return data;
  }
}
