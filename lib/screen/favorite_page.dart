import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/search_page.dart';
import 'package:song_finder/screen/song_page.dart';

import 'account_page.dart';
import 'home_page.dart';

class FavoritePage extends StatefulWidget{
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  final Api api = Api();

  late List<dynamic> _favoriteSong = [];
  late List<dynamic> _playList = [];

  final TextEditingController _textController = TextEditingController();


  Future<void> fetchFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('USER_ID');
    final data = await api.fetchFavorite(userId!);

    setState(() {
      _favoriteSong = data;
    });
  }

  Future<void> fetchPlayList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('USER_ID');
    final data = await api.fetchPlayList(userId!);

    setState(() {
      _playList = data;
    });
  }

  Future<void> addPlayList(String playListName) async {
    await api.addPlayList(playListName);
    await fetchPlayList();
  }

  Future<void> deletePlayList(int playListId, String playListName) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text.rich(
            TextSpan(
              text: 'Bạn có chắc muốn xoá danh sách phát ',
              children: [
                TextSpan(
                  text: playListName,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: ' không?',
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Huỷ')
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await api.deletePlayList(playListId);
                await fetchPlayList();
              },
              child: const Text('Xoá'),
            )
          ],
        )
    );

  }

  void createPlayList() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Danh sách phát"),
          content: SizedBox(
            child: TextField(
              controller: _textController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Tên danh sách phát',
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
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Huỷ')
            ),
            ElevatedButton(
                onPressed: () async {
                  final playListName = _textController.text.trim();
                  if(playListName.isNotEmpty){
                    addPlayList(playListName);
                    Navigator.pop(context);
                    _textController.clear();
                  }
                },
                child: const Text('Tạo'),
            )
          ],
        )
    );
  }

  @override
  void initState() {
    super.initState();
    fetchFavorite();
    fetchPlayList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                  'Yêu thích',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: _favoriteSong.length,
                                itemBuilder: (BuildContext context, int index){
                                  var song = _favoriteSong[index];
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
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.65,
                                                  child: Text(
                                                    song['songName'],
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.65,
                                                  child: Text(
                                                    song['singer']['singerName'],
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        color: Colors.blueGrey
                                                    ),
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
                      ),
                    )
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                  'Danh sách phát',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              IconButton(
                                  onPressed: () => {
                                    createPlayList(),
                                  },
                                  icon: const Icon(Icons.add)
                              )
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: _playList.length,
                                itemBuilder: (BuildContext context, int index){
                                  var playlist = _playList[index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => {},
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
                                                  image: NetworkImage(playlist['user']['image']),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                playlist['playlistName'],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                             IconButton(
                                                 onPressed: () async {
                                                     await deletePlayList(playlist['playlistId'], playlist['playlistName']);

                                                 },
                                                 icon: const Icon(Icons.delete)
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
                      ),
                    )
                ),
              ],
            ),
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
                          icon: const Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                          )
                      ),
                      const Text(
                          'Yêu thích',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                      )
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
                          icon: const Icon(Icons.account_circle_outlined)
                      ),
                      const Text('Tôi')
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