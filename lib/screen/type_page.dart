import 'package:flutter/material.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/song_page.dart';

class TypePage extends StatefulWidget{

  final int typeId;
  final String typeName;
  const TypePage({super.key, required this.typeId, required this.typeName});

  @override
  State<TypePage> createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {

  final Api api = Api();
  late List<dynamic> _song = [];

  Future<void> fetchSongByTypeId() async {
    final data = await api.fetchSongByTypeId(widget.typeId);
    setState(() {
      _song = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSongByTypeId();
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
                      widget.typeName,
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