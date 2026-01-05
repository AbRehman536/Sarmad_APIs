import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarmad_apis/services/auth.dart';

import '../provider/user_token_provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    var userProvider = Provider.of<UserProvider>(context);
    super.initState();
    nameController.text = userProvider.getUser()!.user!.name.toString();
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthServices().updateProfile(
                    token: userProvider.getToken().toString(),
                    name: nameController.text)
                    .then((value)async{
                      await AuthServices().getProfile(userProvider.getToken().toString())
                          .then((userData){
                            userProvider.setUser(userData);
                      }).then((val){
                        isLoading = false;
                        setState(() {});
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Okay"),
                          );
                        });
                      });
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));

              }
        }, child: Text("Update Profile"))
      ],),
    );
  }
}
