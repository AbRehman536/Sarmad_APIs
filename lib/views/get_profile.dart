import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarmad_apis/views/update_profile.dart';

import '../provider/user_token_provider.dart';

class GetProfile extends StatefulWidget {
  const GetProfile({super.key});

  @override
  State<GetProfile> createState() => _GetProfileState();
}

class _GetProfileState extends State<GetProfile> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Profile"),
      ),
      body: Column(children: [
        Text("Name: ${userProvider.getUser()!.user!.name}"),
        Text("Email: ${userProvider.getUser()!.user!.email}"),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
        }, child: Text("Update Profile"))
      ],),
    );
  }
}
