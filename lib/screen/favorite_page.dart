import 'package:flutter/material.dart';
import 'package:song_finder/screen/search_page.dart';

import 'account_page.dart';
import 'home_page.dart';

class FavoritePage extends StatelessWidget{
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: const Text('FavoritePage'),
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
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            )
                          },
                          icon: const Icon(
                            Icons.home,
                          )
                      ),
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
                              MaterialPageRoute(builder: (context) => const SearchPage()),
                            )
                          },
                          icon: const Icon(Icons.search)
                      ),
                      const Text('Tìm kiếm')
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FavoritePage()),
                            )
                          },
                          icon: const Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                          )
                      ),
                      const Text(
                          'Yêu thích',
                          style: TextStyle(
                            color: Colors.redAccent,
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
                              MaterialPageRoute(builder: (context) => const AccountPage()),
                            )
                          },
                          icon: const Icon(Icons.account_circle_outlined)
                      ),
                      const Text('Tôi')
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

}