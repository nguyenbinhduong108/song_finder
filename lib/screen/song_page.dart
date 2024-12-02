import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_finder/api/api.dart';
import 'package:song_finder/screen/home_page.dart';
import 'package:song_finder/ultis/format.dart';

class SongPage extends StatefulWidget{

  final int songId;

  const SongPage({super.key, required this.songId});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {

  final Api api = Api();
  final Format format = Format();
  late AudioPlayer player = AudioPlayer();
  late dynamic _song = {};

  bool isPlay = false;
  bool isFavorite = false;

  late double duration = 0;
  late double position = 0;
  late Timer _timer;

  Future<dynamic> latestListenTime(int songId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('USER_ID');
    final data = await api.checkHistory(userId!, songId);
    final favorite = await api.checkFavorite(userId!, songId);
    setState(() {
      isFavorite = favorite;
    });

    if(data){
      await api.updateLatestListenTime(userId, songId, DateTime.now().toString(), favorite);
    }
    else{
      await api.addLatestListenTime(userId, songId, DateTime.now().toString());
    }
  }

  Future<void> fetchOneSong() async{
    final data = await api.fetchOneSong(widget.songId);
    setState(() {
      _song = data;
      duration = format.formatDurationToInt(_song["duration"] as String);
    });

    await latestListenTime(_song['songId']);
  }

  Future<dynamic> updateFavorite(int songId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('USER_ID');
    await api.updateFavorite(userId!, songId, DateTime.now().toString(), !isFavorite);

    final response = await api.checkFavorite(userId!, songId);

    setState(() {
      isFavorite = response;
    });
  }

  void nextSong() {
    _stopSong();
    if(widget.songId == 108){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const SongPage(songId: 1)
        ),
      );
    }
    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SongPage(songId: widget.songId + 1)
        ),
      );
    }
  }
  void preSong() {
    _stopSong();
    if(widget.songId == 1){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const SongPage(songId: 108)
        ),
      );
    }
    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SongPage(songId: widget.songId - 1)
        ),
      );
    }
  }

  Future<void> _playSong() async {
    if (isPlay) {
      await player.pause();
    } else {
      await player.play(UrlSource(_song['link']));
    }
    setState(() {
      isPlay = !isPlay;
    });
  }

  Future<void> _stopSong() async {
    await player.stop();
  }

  bool isMuteVolume = false;
  bool isLowVolume = false;
  bool isHighVolume = true;

  Future<void> setMuteVolume() async {
    setState(() {
      isMuteVolume = true;
      isLowVolume = false;
      isHighVolume = false;
    });
    await player.setVolume(0);
    await player.play(UrlSource(_song['link']));
  }

  Future<void> setLowVolume() async {
    setState(() {
      isMuteVolume = false;
      isLowVolume = true;
      isHighVolume = false;
    });
    await player.setVolume(0.5);
    await player.play(UrlSource(_song['link']));
  }

  Future<void> setHighVolume() async {
    setState(() {
      isMuteVolume = false;
      isLowVolume = false;
      isHighVolume = true;
    });
    await player.setVolume(1.0);
    await player.play(UrlSource(_song['link']));
  }

  @override
  void initState() {
    fetchOneSong();
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPlay) {
        setState(() {
          // Cập nhật position chỉ khi isPlay là true, và đảm bảo nó không vượt quá duration
          if (position < duration) {
            position += 1;
          }
        });
      }
    });

  }

  @override
  void dispose() {
    player.dispose();
    player.stop();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:
          _song == {} || _song == null
          ? const Expanded(child: CircularProgressIndicator())
          : Center(
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => {
                          _stopSong(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          )
                        },
                        icon: const Icon(
                          Icons.navigate_before,
                          size: 36,
                        )
                    ),
                    IconButton(
                        onPressed: () async => {
                          await updateFavorite(_song['songId'])
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 24,
                          color: isFavorite ? Colors.pink : Colors.white,
                        )
                    ),
                  ],

                ),
              )
          ),
          Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _song["songName"] ?? '',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(300),
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                          image: NetworkImage(_song['image'] ?? "https://www.gmund.com/shop/media/catalog/product/cache/57287fcdeda6cd7f4b6d0a051b2db908/g/m/gmund_papier_lakepaper_extra_white_matt_flat_f179.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 12,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                trackHeight: 1,
                                thumbShape:
                                const RoundSliderThumbShape(
                                    enabledThumbRadius:
                                    7),
                                thumbColor: Colors.white),
                            child: Slider(
                              min: 0,
                              max: duration,
                              value: position,
                              onChanged: (value) => {
                                setState(() {
                                  position = value;
                                })
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Text(format.formatIntToDuration(position)),
                              Text(_song['duration'] ?? ''),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => {},
                            icon: SvgPicture.asset(
                              'lib/assets/shuffle-solid.svg',
                              height: 24,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                          IconButton(
                            onPressed: () => { preSong() },
                            icon: SvgPicture.asset(
                              'lib/assets/backward-step-solid.svg',
                              height: 24,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _playSong();
                            },
                            icon: SvgPicture.asset(
                              !isPlay ? 'lib/assets/circle-play-regular.svg' : 'lib/assets/pause-solid.svg',
                              height: 40,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                          IconButton(
                            onPressed: () => { nextSong() },
                            icon: SvgPicture.asset(
                              'lib/assets/forward-step-solid.svg',
                              height: 24,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                          if (isMuteVolume)
                            IconButton(
                              onPressed: () => {
                                setLowVolume()
                              },
                              icon: SvgPicture.asset(
                                'lib/assets/volume-xmark-solid.svg',
                                height: 24,
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                            )
                          else if(isLowVolume)
                            IconButton(
                              onPressed: () => {
                                setHighVolume()
                              },
                              icon: SvgPicture.asset(
                                'lib/assets/volume-low-solid.svg',
                                height: 24,
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                            )
                          else
                            IconButton(
                              onPressed: () => {
                                setMuteVolume()
                              },
                              icon: SvgPicture.asset(
                                'lib/assets/volume-high-solid.svg',
                                height: 24,
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    ),
        )
    );
  }
}