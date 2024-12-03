
import 'package:flutter/material.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/song_page.dart';

class PlaylistSong extends StatefulWidget {

  final int playlistId;
  final String playlistName;

  const PlaylistSong({super.key, required this.playlistId, required this.playlistName});

  @override
  State<PlaylistSong> createState() => _PlaylistSongState();
}

class _PlaylistSongState extends State<PlaylistSong> {

  final Api api = Api();

  late List<dynamic> _playlistSong = [];

  Future<void> fetchPlaylistSong() async {
    final data = await api.fetchPlaylistSong(widget.playlistId);

    setState(() {
      _playlistSong = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPlaylistSong();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => {
                            Navigator.pop(context),
                          },
                          icon: const Icon(
                            Icons.navigate_before,
                            size: 32,
                          )
                      ),
                      IconButton(
                          onPressed: () => {},
                          icon: const Icon(
                            Icons.delete,
                            size: 32,
                          )
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 10,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.playlistName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            IconButton(
                                onPressed: () => {},
                                icon: const Icon(Icons.edit)
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text(
                              'Thêm vào danh sách phát',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                              ),
                            )
                        ),
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                              itemCount: _playlistSong.length,
                              itemBuilder: (BuildContext context, int index){
                                var song = _playlistSong[index];
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
                                                width: MediaQuery.of(context).size.width * 0.53,
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
                                                width: MediaQuery.of(context).size.width * 0.53,
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
                                          ),
                                          IconButton(
                                            onPressed: () => {},
                                            icon: const Icon(Icons.delete)
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
                    )
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}