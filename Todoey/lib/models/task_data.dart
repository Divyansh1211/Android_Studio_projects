import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:todoey/models/Tasks.dart';

class TaskData extends ChangeNotifier{

  List <Task> _tasks = [];

  UnmodifiableListView<Task>? get tasks{
    return UnmodifiableListView(_tasks);
  }

  void addTask(String newTaskTitle){
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task){
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task){
    _tasks.remove(task);
    notifyListeners();
  }
}