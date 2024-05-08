import 'package:hive/hive.dart';
part 'todo_model.g.dart'; // Step 1

@HiveType(typeId: 1) // Step 2
class TodoModel extends HiveObject // Step 3 extends
{
  @HiveField(0) // Step 4
  String title;
  @HiveField(1) // Step 5
  String detail;
  TodoModel({
    required this.title,
    required this.detail,
  });
}

// Step 6: flutter packages pub run build_runner build  --> type in terminal & enter