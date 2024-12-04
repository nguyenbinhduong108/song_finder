import 'package:flutter/material.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/playlistsong_page.dart';


class AddPlaylistSong extends StatefulWidget{

  final int playlistId;
  final String playlistName;


  const AddPlaylistSong({super.key, required this.playlistId, required this.playlistName});

  @override
  State<AddPlaylistSong> createState() => _AddPlaylistSongState();
}

class _AddPlaylistSongState extends State<AddPlaylistSong> {

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

  Future<void> checkPlaylistSong(int songId) async {
    final data = await api.checkPlaylistSong(widget.playlistId, songId);

    if(data == false){
      try{
        await api.addPlaylistSong(widget.playlistId, songId);
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text("Thông báo"),
              content: Text('Thêm thành công'),
            )
        );
      }
      catch (e){
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text("Thông báo"),
              content: Text('Thêm không thành công'),
            )
        );
      }

    }
    else{
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Thông báo"),
            content: Text('Bài hát đã tồn tại trong danh sách phát'),
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSong();
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlaylistSong(playlistId: widget.playlistId, playlistName: widget.playlistName)
                          )
                        ),
                      },
                      icon: const Icon(
                        Icons.navigate_before,
                        size: 32,
                      )
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
                                Row(
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
                                            style: const TextStyle(
                                                fontSize: 20
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.53,
                                          child: Text(
                                            song['singer']['singerName'],
                                            style: const TextStyle(
                                                color: Colors.blueGrey
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await checkPlaylistSong(songId);
                                        },
                                        icon: const Icon(Icons.add_circle)
                                    )
                                  ],
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
        ));
  }
}