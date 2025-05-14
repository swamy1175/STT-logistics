import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'dash_board.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.indigo,
                onPressed: () {
                  if(emailController.text.isEmpty){
                    Get.snackbar(
                      backgroundColor: Colors.red,
                        colorText: Colors.white,
                        'Email',
                        'enter email id',
                        snackPosition: SnackPosition.TOP
                    );
                  }else if(passwordController.text.isEmpty){
                    Get.snackbar(
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        'Password',
                        'enter password',
                        snackPosition: SnackPosition.TOP
                    );

                  }else{
                    Get.off(() => ShipmentPage());
                  }
                },
                child: Text('Login',style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}