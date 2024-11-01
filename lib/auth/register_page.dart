import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:movie_apps/auth/login_page.dart';
import 'package:toastification/toastification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String routeName = "/register-page";
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final dio = Dio();

  bool isiLoading = false;

  TextEditingController usernamControler = TextEditingController();
  TextEditingController fullNamecontroler = TextEditingController();
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController phonecontroler = TextEditingController();
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
                  const Text("registrasi Akun",
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
                    controller: fullNamecontroler,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: emailcontroler,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: phonecontroler,
                    decoration: const InputDecoration(
                      labelText: "Nomor Telpon",
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
                          onPressed: () {
                            if (usernamControler.text.isEmpty) {
                              toastification.show(
                                  context: context,
                                  title:
                                      const Text("Username Tidak Boleh Kosong"),
                                  type: ToastificationType.error,
                                  style: ToastificationStyle.fillColored);
                            }else if (usernamControler.text.isEmpty) {
                              toastification.show(
                                  context: context,
                                  title:
                                      const Text("Full_name Tidak Boleh Kosong"),
                                  type: ToastificationType.error,
                                  style: ToastificationStyle.fillColored);
                                  }else if (usernamControler.text.isEmpty) {
                              toastification.show(
                                  context: context,
                                  title:
                                      const Text("email Tidak Boleh Kosong"),
                                  type: ToastificationType.error,
                                  style: ToastificationStyle.fillColored);
                                  }else if (usernamControler.text.isEmpty) {
                              toastification.show(
                                  context: context,
                                  title:
                                      const Text(" no_telp Tidak Boleh Kosong"),
                                  type: ToastificationType.error,
                                  style: ToastificationStyle.fillColored);
                                  }else if (usernamControler.text.isEmpty) {
                              toastification.show(
                                  context: context,
                                  title:
                                      const Text("password Tidak Boleh Kosong"),
                                  type: ToastificationType.error,
                                  style: ToastificationStyle.fillColored);
                            } else
                              (registeresponse());
                          },
                          child: const Text(
                            "register",
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
                          Navigator.pushNamed(context, LoginPage.routeName);
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

  void registeresponse() async {
    try {
      setState(() {
        isiLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      Response response;
      response = await dio.post(register, data: {
        "username": usernamControler.text,
        "full_name": fullNamecontroler.text,
        "email": emailcontroler.text,
        "no_telp": phonecontroler.text,
        "password": passwordControler.text,
      });
      if (response.data['status'] == true) {
        toastification.show(
            title: Text(response.data['msg']),
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored);
      } else {
        toastification.show(
          title: Text("Terjadi kesalahan pada server"),
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored);
          Navigator.pushNamed(context, LoginPage.routeName);
        
      }
    } catch (e) {
    } finally {
      setState(() {
        isiLoading = false;
      });
    }
  }
}
