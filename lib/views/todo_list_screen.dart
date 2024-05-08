import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_using_hive_database/common/color.dart';
import 'package:todo_app_using_hive_database/controller/todo_controller.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
// ---------------------
    TodoController todoController = Get.put(TodoController());

    void dialogBox() {
      Get.defaultDialog(
          backgroundColor: Colors.white,
          textConfirm: todoController.whichButton == 0 ? "ADD" : "UPDATE",
          buttonColor: appbarbg,
          title: todoController.whichButton == 0 ? "Add Task" : "Update Task",
          onConfirm: () {
            if (todoController.whichButton == 0) {
              todoController.addTodo();
              Get.back();
            } else {
              todoController.updateTodo(todoController.dataIndex);
              Get.back();
            }
          },
          content: Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12, top: 8, bottom: 8),
            child: Column(
              children: [
                TextFormField(
                  controller: todoController.titleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                TextFormField(
                  controller: todoController.detalController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Detail",
                  ),
                )
              ],
            ),
          ));
    }
// =========================

    return Scaffold(
        backgroundColor: screenbg,
        appBar: AppBar(
          title: Text(
            "T O D O",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          backgroundColor: appbarbg,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: appbarbg,
          onPressed: () {
            todoController.whichButton = 0;
            todoController.titleController.clear();
            todoController.detalController.clear();

            dialogBox();
          },
          child: Icon(
            Icons.add,
            color: screenbg,
            size: 30,
          ),
        ),
        body: ValueListenableBuilder(
            // Fetch Data
            valueListenable: todoController.userData.listenable(),
            builder: (context, Box data, _) {
              return data.isEmpty
                  ? Center(
                      child: Image.asset(
                        "assets/images/sunset.png",
                        height: 200,
                        width: 200,
                        color: Color.fromARGB(255, 161, 159, 159),
                      ),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var tempData = data.getAt(index);
                        var count = index + 1;
                        return Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5),
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                tempData.title,
                                style: TextStyle(fontSize: 18, color: appbarbg),
                              ),
                              subtitle: Text(
                                tempData.detail,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        todoController.whichButton = 1;
                                        todoController.titleController.text =
                                            tempData.title;
                                        todoController.detalController.text =
                                            tempData.detail;

                                        todoController.dataIndex = index;

                                        dialogBox();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: appbarbg,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        todoController.deleteTodo(index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: appbarbg,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                    color: appbarbg, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    count.toString(),
                                    style: TextStyle(
                                        fontSize: 18, color: screenbg),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
            }));
  }
}
