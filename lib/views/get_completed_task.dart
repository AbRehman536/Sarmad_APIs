import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarmad_apis/models/task.dart';
import 'package:sarmad_apis/models/taskListing.dart';
import 'package:sarmad_apis/services/task.dart';

import '../provider/user_token_provider.dart';

class GetCompletedTask extends StatelessWidget {
  const GetCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text("Get Completed Task"),
      ),
      body: FutureProvider.value(
          value: TaskServices().getCompletedTask(userProvider.getToken().toString()),
          initialData: [TaskListingModel()],
       builder: (context, child){
            TaskListingModel taskListingModel = context.watch<TaskListingModel>();
            return taskListingModel.tasks == null
              ? Center(child: CircularProgressIndicator(),):
             ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskListingModel.tasks![index].description.toString()),
              );
            },);
       },
      ),
    );
  }
}
