import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/home_page.dart';
import 'package:song_finder/screen/info_page.dart';
import 'package:song_finder/screen/search_page.dart';
import 'package:song_finder/screen/sign_in.dart';
import 'package:song_finder/screen/song_page.dart';

import 'favorite_page.dart';

class AccountPage extends StatefulWidget{
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final Api api = Api();

  late dynamic _user = {};
  late List<dynamic> _historySongs = [];

  Future<void> fetchUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('USER_ID');

    final data = await api.fetchUser(userId!);

    setState(() {
      _user = data;
    });
  }

  Future<void> fetchHistory() async {
    final data = await api.fetchHistory();

    setState(() {
      _historySongs = data;
    });
  }

  Future<void> logout() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Bạn có muốn đăng xuất tài khoản?'),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Huỷ')
            ),
            ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignIn(),
                      )
                  );
                },
                child: const Text('Huỷ'),
            )
          ],
        )
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child:
            _user != {} && _historySongs != []
            ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Hồ sơ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Info(),
                                      )
                                  )
                                },
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: DecorationImage(
                                      image: NetworkImage(_user['image'] ?? 'https://www.gmund.com/shop/media/catalog/product/cache/57287fcdeda6cd7f4b6d0a051b2db908/g/m/gmund_papier_lakepaper_extra_white_matt_flat_f179.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                _user['userName'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              )
                            ],

                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green
                                ),
                                child: const Text('Đăng xuất', style: TextStyle(color: Colors.white),),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Lịch sử nghe',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: _historySongs.length,
                                itemBuilder: (BuildContext context, int index){
                                  var song = _historySongs[index];
                                  var songId = song['songId'];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SongPage(songId: songId),
                                              )
                                          )
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.grey),
                                                image: DecorationImage(
                                                  image: NetworkImage(song['image']),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  song['songName'],
                                                  style: const TextStyle(
                                                      fontSize: 20
                                                  ),
                                                ),
                                                Text(
                                                  song['singer']['singerName'],
                                                  style: const TextStyle(
                                                      color: Colors.blueGrey
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10)
                                    ],
                                  );
                                }
                            ),
                          )


                        ],
                      )
                  )
                ],
              ),
            )
            : const Expanded(child: CircularProgressIndicator()),
          ),
          bottomNavigationBar: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            )
                          },
                          icon: const Icon(
                            Icons.home,

                          )
                      ),
                      const Text(
                        'Trang chủ',
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SearchPage()),
                            )
                          },
                          icon: const Icon(Icons.search)
                      ),
                      const Text('Tìm kiếm')
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FavoritePage()),
                            )
                          },
                          icon: const Icon(Icons.favorite)
                      ),
                      const Text('Yêu thích')
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AccountPage()),
                            )
                          },
                          icon: const Icon(
                              Icons.account_circle_outlined,
                            color: Colors.blue,
                          )
                      ),
                      const Text(
                          'Tôi',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}