import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarmad_apis/services/auth.dart';
import 'package:sarmad_apis/views/get_all_task.dart';

import '../provider/user_token_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthServices().loginUser(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((val)async{
                      userProvider.setToken(val.token.toString());
                      await AuthServices().getProfile(val.token.toString())
                      .then((value){
                        isLoading = false;
                        setState(() {});
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(value.user!.name.toString()),
                            content: Text(value.user!.email.toString()),
                          actions: [TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                          }, child: Text("Okay"))],);
                        }, );
                      });
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));

              }
        }, child: Text("Login")),

      ],),
    );
  }
}
