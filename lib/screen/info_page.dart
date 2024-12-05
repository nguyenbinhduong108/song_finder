
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/account_page.dart';

class Info extends StatefulWidget{
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  final Api api = Api();
  late dynamic _user = {};

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> fetchUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('USER_ID');

    final data = await api.fetchUser(userId!);
    setState(() {
      _user = data;
    });
  }

  Future<void> updateUser() async {
    final name = _nameController.text.trim();
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if(name.isEmpty || oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty){
      dialog('Bạn cần nhập các thông tin cần thiết');
    }
    else if(oldPassword != _user['password']){
      dialog('Mật khẩu cũ không đúng');
    }
    else if(newPassword == oldPassword){
      dialog('Mật khẩu mới cần khác mật khẩu cũ');
    }
    else if(newPassword != confirmPassword) {
      dialog('Xác nhận mật khẩu không chính xác');
    }
    else{
      try{
        api.updateUser(name, newPassword, _user['role'], '');
        dialog('Cập nhật thành công');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AccountPage()
            ),
        );
      } catch (e) {
        dialog('Có lỗi trong quá trình cập nhật');
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
    fetchUser();
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
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AccountPage(),
                                )
                            )
                          },
                          icon: const Icon(
                              Icons.close,
                              size: 40,
                          )
                      ),
                      IconButton(
                          onPressed: () async {
                            await updateUser();
                          },
                          icon: const Icon(
                              Icons.check,
                              size: 40,
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {},
                        child: ClipOval(
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(_user['image'] ?? 'https://www.gmund.com/shop/media/catalog/product/cache/57287fcdeda6cd7f4b6d0a051b2db908/g/m/gmund_papier_lakepaper_extra_white_matt_flat_f179.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                        controller: _oldPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Mật khẩu cũ',
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
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Mật khẩu mới',
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
                          hintText: 'Xác nhận mật khẩu',
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}