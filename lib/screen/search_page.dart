import 'package:flutter/material.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/song_page.dart';

import 'account_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final Api api = Api();

  late List<dynamic> _allSong = [];
  late List<dynamic> _searchSong = [];

  Future<void> fetchSong() async {
    final data = await api.fetchSong();
    setState(() {
      _allSong = data;
      _searchSong = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSong();
  }

  void filterSongs(String query) {
    final results = _allSong
        .where((song) => song["songName"]
        .toLowerCase()
        .contains(query.toLowerCase())) // Lọc bài hát theo songName
        .toList();

    setState(() {
      _searchSong = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tìm kiếm',
                selectionColor: Colors.white,
                style: TextStyle(
                    fontSize: 24,
                ),
              ),
              TextField(
                onChanged: (query) {
                  filterSongs(query);
                },
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,

                  hintText: 'Tìm kiếm',
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

              Expanded(
                  flex: 1,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _searchSong.length,
                      itemBuilder: (BuildContext context, int index){
                        var song = _searchSong[index];
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
                  )
              )
            ],
          ),
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
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            )
                          },
                      icon: const Icon(
                        Icons.home,
                      )),
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
                              MaterialPageRoute(
                                  builder: (context) => const SearchPage()),
                            )
                          },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.green,
                      )),
                  const Text(
                    'Tìm kiếm',
                    style: TextStyle(
                      color: Colors.green,
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
                              MaterialPageRoute(
                                  builder: (context) => const FavoritePage()),
                            )
                          },
                      icon: const Icon(Icons.favorite)),
                  const Text('Yêu thích')
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AccountPage()),
                            )
                          },
                      icon: const Icon(Icons.account_circle_outlined)),
                  const Text('Tôi')
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
