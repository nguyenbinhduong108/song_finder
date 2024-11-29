import 'package:flutter/material.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/song_page.dart';

class SingerPage extends StatefulWidget{

  final int singerId;
  final String singerImage;
  final String singerName;

  const SingerPage({super.key, required this.singerId, required this.singerImage, required this.singerName});

  @override
  State<SingerPage> createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> {

  final Api api = Api();
  late List<dynamic> _song = [];
  late List<dynamic> _album = [];

  Future<void> fetchSongBySingerId() async{
    final data = await api.fetchSongBySingerId(widget.singerId);
    setState(() {
      _song = data;
    });
  }

Future<void> fetchAlbumBySingerId() async{
    final data = await api.fetchAlbumBySingerId(widget.singerId);
    setState(() {
      _album = data;
    });
}


  @override
  void initState() {
    super.initState();
    fetchSongBySingerId();
    fetchAlbumBySingerId();
  }

  @override
  void dispose() {
    _song = [];
    _album = [];
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(
                            image: NetworkImage(widget.singerImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.singerName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Bài hát: ${_song.length}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                              Text('Album: ${_album.length}', style: const TextStyle(fontSize: 16, color: Colors.grey))
                            ],
                          )
                        ],
                      ),

                      // Album
                      _album.isNotEmpty
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Album",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 140,
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
                                            width: 100,
                                            height: 100,
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
                          ),
                        ],
                      )
                      : const SizedBox(),



                      // Bài hát
                      _song.isNotEmpty
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bài hát",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 170,
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
                                                Text(
                                                  widget.singerName,
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
                      : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}