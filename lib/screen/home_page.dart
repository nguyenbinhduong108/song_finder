import 'package:flutter/material.dart';
import 'package:song_finder/screen/account_page.dart';
import 'package:song_finder/screen/favorite_page.dart';
import 'package:song_finder/screen/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // Bạnner
              Container(
                height: 200,
                color: Colors.blue,
                child: const Center(child: Text('Nội dung 1')),
              ),

              // Thể loại ưu chuộng
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thể loại ưu chuộng'),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
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
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),

              // Nghệ sĩ nổi bật
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nghệ sĩ nổi bật'),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),

              // Bài hát yêu thích
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bài hát yêu thích'),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
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
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('Nhac trẻ'),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
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
                          color: Colors.green,
                        )),
                    const Text(
                      'Trang chủ',
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
                                    builder: (context) => const SearchPage()),
                              )
                            },
                        icon: const Icon(Icons.search)),
                    const Text('Tìm kiếm')
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
      ),
    );
  }
}
