import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_apps/admin/home_admin.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:movie_apps/auth/register_page.dart';
import 'package:movie_apps/users/home_users.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String routeName = "/login-page";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();
  bool isiLoading = false;
  TextEditingController usernamControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/login.png",
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Login Akun",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: usernamControler,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: passwordControler,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  isiLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text('Belum Punya Akun'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.routeName);
                        },
                        child: const Text('Daftar disini'),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  void loginResponse() async {
    try {
      setState(() {
        isiLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      Response response;
      response = await dio.post(login, data: {
        "username": usernamControler.text,
        "password": passwordControler.text,
      });
      if (response.data['status'] == true) {
        toastification.show(
            context: context,
            title: Text(response.data['msg']),
            type: ToastificationType.success,
            autoCloseDuration: Duration(seconds: 3),
            style: ToastificationStyle.fillColored);
        print(response.data['data']);
        var users = response.data['data'];
        if (users['role'] == 1) {
          Navigator.pushNamed(context, HomeAdmin.routeName);
        } else if(users['role'] == 2) {
          Navigator.pushNamed(context,HomeUsers.routeName);
        }
        
    
      } else {
        toastification.show(
            title: Text("Terjadi kesalahan pada server"),
            type: ToastificationType.error,
            style: ToastificationStyle.fillColored);
      }
    } catch (e) {
    } finally {}
  }
}
