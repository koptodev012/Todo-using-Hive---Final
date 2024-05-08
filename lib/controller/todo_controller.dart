import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_using_hive_database/model/todo_model.dart';

class TodoController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController detalController = TextEditingController();

  late Box userData;
  late int whichButton;
  late int dataIndex;

  @override
  void onInit() {
    userData = Hive.box("UserData");
    super.onInit();
  }

  // Add Todo
  void addTodo() {
    final todo =
        TodoModel(title: titleController.text, detail: detalController.text);
    userData.add(todo);
    titleController.clear();
    detalController.clear();
    print("Added...");
  }

  // Delete Todo
  void deleteTodo(index) {
    userData.deleteAt(index);
    print("Deleted...");
  }

  // Update Todo
  void updateTodo(index) {
    final todo =
        TodoModel(title: titleController.text, detail: detalController.text);
    userData.putAt(index, todo);
    titleController.clear();
    detalController.clear();
    print("Updated...");
  }
}
