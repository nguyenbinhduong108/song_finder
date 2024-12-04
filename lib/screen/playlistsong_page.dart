
import 'package:flutter/material.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/add_playlist_song.dart';
import 'package:song_finder/screen/favorite_page.dart';
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
  late String playlistName = '';

  final TextEditingController _textController = TextEditingController();


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
                await api.deletePlayList(playListId);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoritePage()
                    )
                );
              },
              child: const Text('Xoá'),
            )
          ],
        )
    );

  }

  Future<void> fetchPlaylistSong() async {
    final data = await api.fetchPlaylistSong(widget.playlistId);

    setState(() {
      _playlistSong = data;
    });
  }

  Future<void> deletePlaylistSong(int playlistId, int songId) async {
    await api.deletePlaylistSong(playlistId, songId);
    await fetchPlaylistSong();
  }

  Future<void> editPlayList() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Chỉnh sửa"),
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
                onPressed: () {
                  _textController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Huỷ')
            ),
            ElevatedButton(
              onPressed: () async {
                final playListName = _textController.text.trim();
                if(playListName.isNotEmpty){
                  updatePlayList(playListName);
                  Navigator.pop(context);
                  _textController.clear();
                }
              },
              child: const Text('Cập nhật'),
            )
          ],
        )
    );
  }

  Future<void> updatePlayList(String playListName) async {
    await api.updatePlayList(widget.playlistId, playListName);
    await fetchPlaylistSong();
    
    setState(() {
      playlistName = playListName;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPlaylistSong();
    setState(() {
      playlistName = widget.playlistName;
    });
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FavoritePage()
                                )
                            )
                          },
                          icon: const Icon(
                            Icons.navigate_before,
                            size: 32,
                          )
                      ),
                      IconButton(
                          onPressed: () async {
                            await deletePlayList(widget.playlistId, playlistName);
                          },
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
                              playlistName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await editPlayList();
                                },
                                icon: const Icon(Icons.edit)
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () => {
                              Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                      builder: (context) => AddPlaylistSong(playlistId: widget.playlistId, playlistName: playlistName,)
                                  )
                              )
                            },
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
                                            onPressed: () async {
                                              await deletePlaylistSong(widget.playlistId, songId);
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