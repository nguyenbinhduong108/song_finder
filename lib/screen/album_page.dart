import 'package:flutter/material.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/song_page.dart';

class AlbumPage extends StatefulWidget{
  final int albumId;
  final String albumName;
  const AlbumPage({super.key, required this.albumId, required this.albumName});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {

  final Api api = Api();

  late List<dynamic> _song = [];

  Future<void> fetchSongByAlbumId() async {
    final data = await api.fetchSongByAlbumId(widget.albumId);
    setState(() {
      _song = data;
    });
  }

  @override
  void initState() {
    fetchSongByAlbumId();
    super.initState();
  }

  @override
  void dispose() {
    _song = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    widget.albumName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _song.length,
                          itemBuilder: (BuildContext context, int index){
                            var song = _song[index];
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
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}