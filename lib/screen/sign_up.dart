import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/home_page.dart';
import 'package:song_finder/screen/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final Api api = Api();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late List<dynamic> _allUser = [];

  Future<void> fetchAllUser() async {
    final data = await api.fetchAllUser();

    setState(() {
      _allUser = data;
    });
  }

  int getUserId (String searchEmail){
    final int userId = _allUser.firstWhere(
          (user) => user['email'] == searchEmail,
      orElse: () => null,
    )?['userId'] ?? -1;

    return userId;
  }

  Future<void> singUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if(name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      dialog('Bạn cần nhập các thông tin cần thiết');
    }
    else if(password != confirmPassword) {
      dialog('Xác nhận mật khẩu không chính xác');
    }
    else{
      try{
        await api.singUp(name, email, password);

        await fetchAllUser();

        final int userId = getUserId(email);
        print(userId);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("USER_ID", userId);


        showDialog(
            context: context,
            builder: (content) => AlertDialog(
              title: const Text("Thông báo"),
              content: const Text("Đăng ký thành công"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()
                          )
                      );
                    },
                    child: const Text("Đăng nhập")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()
                          )
                      );
                    },
                    child: const Text("OK")
                )
              ],
        )
        );
      } catch (e) {
        dialog('Lỗi server');
      }
    }
  }

  void dialog(String textContent){
    showDialog(
        context: context,
        builder: (content) => AlertDialog(
          title: const Text("Thông báo"),
          content: Text(textContent),
        )
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset('lib/assets/full_logo.png'),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Đăng ký',
                        selectionColor: Colors.white,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Tên',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
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
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _passwordController,
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
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Xác nhân mật khẩu',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () async {
                            await singUp();
                          },
                          child: const Text(
                            'Đăng ký',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Đã có tài khoản, "),
                          GestureDetector(
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                  color: Colors.yellow
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignIn()),
                              )
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
