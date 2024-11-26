import 'package:flutter/material.dart';

import 'account_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: const Text('SearchPage'),
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
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            )
                          },
                      icon: const Icon(
                        Icons.home,
                      )),
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
                              MaterialPageRoute(
                                  builder: (context) => const SearchPage()),
                            )
                          },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.green,
                      )),
                  const Text(
                    'Tìm kiếm',
                    style: TextStyle(
                      color: Colors.green,
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
                              MaterialPageRoute(
                                  builder: (context) => const FavoritePage()),
                            )
                          },
                      icon: const Icon(Icons.favorite)),
                  const Text('Yêu thích')
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AccountPage()),
                            )
                          },
                      icon: const Icon(Icons.account_circle_outlined)),
                  const Text('Tôi')
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
