import 'package:flutter/cupertino.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/taskTile.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              taskTitle: taskData.tasks![index].name,
              isChecked: taskData.tasks![index].isDone,
              checkBoxCallBack: (checkBoxState) {
                taskData.updateTask(taskData.tasks![index]);
              },
            longPressCallBack: (){
              taskData.deleteTask(taskData.tasks![index]);
            },
            );
          },
          itemCount: taskData.tasks?.length,
        );
      },
    );
  }
}
