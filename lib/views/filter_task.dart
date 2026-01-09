import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sarmad_apis/models/taskListing.dart';
import 'package:sarmad_apis/services/task.dart';

import '../provider/user_token_provider.dart';

class FilterTask extends StatefulWidget {
  const FilterTask({super.key});

  @override
  State<FilterTask> createState() => _FilterTaskState();
}

class _FilterTaskState extends State<FilterTask> {
  TaskListingModel? taskListingModel;
  DateTime? firstDate;
  DateTime? lastDate;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Task"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(onPressed: (){
                showDatePicker(
                    context: context,
                    firstDate: DateTime(1970), 
                    lastDate: DateTime.now())
                    .then((val){
                      setState(() {
                        firstDate = val;
                      });
                });
              }, child: Text("Select Start Date")),
              if(firstDate != null)
                Text(DateFormat.yMMMEd().format(firstDate!)),
              ElevatedButton(onPressed: (){
                showDatePicker(
                    context: context, 
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now())
                    .then((val){
                      setState(() {
                        lastDate = val;
                      });
                });
              }, child: Text("Select Last Date")),
              if(lastDate != null)
                Text(DateFormat.yMMMEd().format(lastDate!)),
              ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  taskListingModel = null;
                  setState(() {});
                  await TaskServices().filterTask(
                      token: userProvider.getToken().toString(),
                      startDate: firstDate.toString(),
                      endDate: lastDate.toString())
                  .then((val){
                    isLoading = false;
                    taskListingModel = val;
                    setState(() {});
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }, child: Text("Filter")),
              if(isLoading == true)
                Center(child: CircularProgressIndicator(),),
              if(taskListingModel == null)
                Center(child: Text("Select First and Last Date")),

                Expanded(
                  child: ListView.builder(
                    itemBuilder:
                        (BuildContext context, int index) {
                      return ListTile(
                        leading: Icon(Icons.task),
                        title: Text(
                            taskListingModel!.tasks![index].description.toString()),
                      );
                        },),
                )
            ],
          )
        ],
      ),
    );
  }
}
