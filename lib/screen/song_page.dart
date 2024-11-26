import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SongPage extends StatelessWidget{
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                  Icons.navigate_before,
                                  size: 36,
                              )
                          ),
                          IconButton(
                              onPressed: () => {},
                              icon: const Icon(
                                  Icons.favorite,
                                  size: 24,
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
                        const Text(
                            "Let's it go",
                            style: TextStyle(fontSize: 24),
                        ),
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(300),
                            border: Border.all(color: Colors.grey),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://picsum.photos/200/300'),
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
                                  max: 100,
                                  value: 30,
                                  onChanged: (value) => {},
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: const Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('00:00'),
                                  Text('3:10'),
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
                                onPressed: () => {},
                                icon: SvgPicture.asset(
                                  'lib/assets/backward-step-solid.svg',
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                ),
                              ),
                              IconButton(
                                onPressed: () => {},
                                icon: SvgPicture.asset(
                                  'lib/assets/circle-play-regular.svg',
                                  height: 40,
                                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                ),
                              ),
                              IconButton(
                                onPressed: () => {},
                                icon: SvgPicture.asset(
                                  'lib/assets/forward-step-solid.svg',
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                ),
                              ),
                              IconButton(
                                onPressed: () => {},
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