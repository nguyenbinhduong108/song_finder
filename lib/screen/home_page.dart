import 'package:flutter/material.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/account_page.dart';
import 'package:song_finder/screen/favorite_page.dart';
import 'package:song_finder/screen/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var api = Api();

  late List<dynamic> _song = [];
  late List<dynamic> _singer = [];
  late List<dynamic> _type = [];
  late List<dynamic> _album = [];

  Future<void> fetchSong() async {
    final data = await api.fetchSong();
    setState(() {
      _song = data;
    });
  }

  Future<void> fetchSinger() async {
    final data = await api.fetchSinger();
    setState(() {
      _singer = data;
    });
  }

  Future<void> fetchType() async {
    final data = await api.fetchType();
    setState(() {
      _type = data;
    });
  }

  Future<void> fetchAlbum() async {
    final data = await api.fetchAlbum();
    setState(() {
      _album = data;
    });
  }

  Future<void> fetchData() async{

  }

  @override
  void initState() {
    super.initState();
    fetchSong();
    fetchSinger();
    fetchType();
    fetchAlbum();
  }

  @override
  void dispose() {
    super.dispose();
    _song = [];
    _singer = [];
    _type = [];
    _album = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
          _song != [] && _singer != [] && _type != [] && _album != []
        ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // Bạnner
                Container(
                  height: 200,
                  color: Colors.blue,
                  child: const Center(child: Text('Nội dung 1')),
                ),

                // Bài hát yêu thích
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bài hát yêu thích'),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _song.length,
                            itemBuilder: (BuildContext context, int index) {
                              var song = _song[index];
                              return Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 150,
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
                                      Text(song['songName']),
                                    ],
                                  ),
                                  const SizedBox(width: 5)
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),

                // Nghệ sĩ nổi bật
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nghệ sĩ nổi bật'),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _singer.length,
                            itemBuilder: (BuildContext context, int index) {
                              var singer = _singer[index];
                              return Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: Colors.grey),
                                          image: DecorationImage(
                                            image: NetworkImage(singer['image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(singer['singerName']),
                                    ],
                                  ),
                                  const SizedBox(width: 5)
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),

                // Thể loại yêu thích
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Thể loại yêu thích'),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _type.length,
                            itemBuilder: (BuildContext context, int index){
                              var type = _type[index];
                              return Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey),
                                          image: DecorationImage(
                                            image: NetworkImage(type['image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(type['typeName']),
                                    ],
                                  ),
                                  const SizedBox(width: 5)
                                ],
                              );
                            }
                        ),
                      )
                      ,
                    ],
                  ),
                ),

                // Album yêu thích
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Album yêu thích'),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _album.length,
                            itemBuilder: (BuildContext context, int index){
                              var album = _album[index];
                              return Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey),
                                          image: DecorationImage(
                                            image: NetworkImage(album['image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(album['albumName']),
                                    ],
                                  ),
                                  const SizedBox(width: 5)
                                ],
                              );
                            }
                        ),
                      )
                      ,
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Expanded(child: CircularProgressIndicator()),


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
                          color: Colors.green,
                        )),
                    const Text(
                      'Trang chủ',
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
                                    builder: (context) => const SearchPage()),
                              )
                            },
                        icon: const Icon(Icons.search)),
                    const Text('Tìm kiếm')
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
      ),
    );
  }
}
