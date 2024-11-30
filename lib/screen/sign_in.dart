import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/home_page.dart';
import 'package:song_finder/screen/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Api api = Api();

  late List<dynamic> _allUser = [];
  late dynamic _user = {};

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> fetchAllUser() async {
    final data = await api.fetchAllUser();
    setState(() {
      _allUser = data;
    });
  }

  Map<String, dynamic>? login(String email, String password) {
    for (var user in _allUser) {
      if (user['email'] == email && user['password'] == password) {
        return user;
      }
    }
    return null;
  }

  void handleLogin() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    Map<String, dynamic>? user = login(email, password);

    _user = user;

    if (user != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Đăng nhập thành công"),
          content: Text("Chào mừng ${user['userName']}!"),
          actions: [
            TextButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage()),
                )
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Đăng nhập thất bại"),
          content: const Text("Email hoặc mật khẩu không đúng."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Thử lại"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> saveUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("USER_ID", _user['userId']);
  }

  @override
  void initState() {
    super.initState();
    fetchAllUser();
  }

  @override
  void dispose() {
    _allUser = [];
    _user = {};
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset('lib/assets/full_logo.png'),
            ),
            Expanded(
              flex: 10,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Đăng nhập',
                      selectionColor: Colors.white,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextField(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Mật khẩu',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: const Text(
                            'Quên mật khẩu',
                          ),
                          onTap: () => {},
                        ),
                      ]
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () async => {
                          handleLogin(),
                          await saveUserId(),
                        },
                        child: const Text(
                            'Đăng nhập',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Chưa có tài khoản, "),
                        GestureDetector(
                          child: const Text(
                            'Đăng ký',
                            style: TextStyle(
                              color: Colors.yellow
                            ),
                          ),
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUp()),
                            )
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
