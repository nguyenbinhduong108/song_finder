import 'package:flutter/material.dart';
import 'package:song_finder/screen/home_page.dart';
import 'package:song_finder/screen/search_page.dart';

import 'favorite_page.dart';

class AccountPage extends StatelessWidget{
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: const Text('AccountPage'),
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
                          icon: const Icon(Icons.favorite)
                      ),
                      const Text('Yêu thích')
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
                          icon: const Icon(
                              Icons.account_circle_outlined,
                            color: Colors.green,
                          )
                      ),
                      const Text(
                          'Tôi',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      )
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