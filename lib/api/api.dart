import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api{
  var api = Dio(BaseOptions(baseUrl: dotenv.env['API_KEY'] as String));

  // User
  Future<dynamic> fetchAllUser() async {
    try {
      final response = await api.get('/users');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> fetchUser(int userId) async {
    try {
      final response = await api.get('/users/$userId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  // Songs
  Future<dynamic> fetchSong() async {
    try{
      final response = await api.get('/songs');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> fetchSongBySingerId(int singerId) async {
    try{
      final response = await api.get('/songs/singer/$singerId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> fetchSongByTypeId(int typeId) async {
    try{
      final response = await api.get('/songs/type/$typeId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> fetchSongByAlbumId(int typeId) async {
    try{
      final response = await api.get('/songs/album/$typeId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> fetchOneSong(int songId) async{
    try {
      final response = await api.get('/songs/$songId');
      return response.data;
    }
    catch(e){
      print(e);
      return [];
    }
  }


  // Singer
  Future<dynamic> fetchSinger() async {
    try{
      final response = await api.get('/singers');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  // Type
  Future<dynamic> fetchType() async {
    try{
      final response = await api.get('/songs/type');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  // Album
  Future<dynamic> fetchAlbum() async {
    try{
      final response = await api.get('/songs/albums');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> fetchAlbumBySingerId(int singerId) async {
    try{
      final response = await api.get('/songs/albums/$singerId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  // Favorite
  Future<dynamic> fetchFavorite(int userId) async {
    try{
      final response = await api.get('/favorite/$userId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> checkFavorite(int userId, int songId) async{
    try{
      final response = await api.get('/check-favorite/$userId/$songId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> updateLatestListenTime(int userId, int songId, String latestListenTime, bool favorite) async {
    try{
      final response = await api.put('/favorite/put/$userId/$songId', data: {
        'songId': null,
        'userId': null,
        'latestListenTime': latestListenTime,
        'isFavorite': favorite,
      });
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> addLatestListenTime(int userId, int songId, String latestListenTime) async {
    try{
      final response = await api.post('/history-listen/post', data: {
        'songId': songId,
        'userId': userId,
        'latestListenTime': latestListenTime,
        'isFavorite': false,
      });
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> updateFavorite(int userId, int songId, String latestListenTime, bool isFavorite) async{
    try{
      final response = await api.put('/favorite/put/$userId/$songId', data: {
        'latestListenTime': latestListenTime,
        'isFavorite': isFavorite,
      });
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  // History
  Future<dynamic> checkHistory(int userId, int songId) async{
    try{
      final response = await api.get('/check-history-listen/$userId/$songId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> fetchHistory() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('USER_ID');
      final response = await api.get('/history-listen/$userId');
      
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  // PlayList
  Future<dynamic> fetchPlayList(int userId) async {
    try{
      final response = await api.get('/users/playlist/$userId');
      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }
  
  Future<dynamic> addPlayList(String playListName) async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('USER_ID');
      final response = await api.post('/users/playlist/post', data: {
        'playlistName': playListName,
        'dateCreated': DateTime.now().toString(),
        'user': {
          'userId': userId!
        }
      });

      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deletePlayList(int playListId) async {
    try{
      await api.delete('/users/playlist/delete/$playListId');
    }
    catch (e) {
      print(e);
    }
  }

  // PlayListSong
  Future<dynamic> fetchPlaylistSong(int playlistId) async {
    try{
      final response = await api.get('/users/playlist-song/$playlistId');

      return response.data;
    }
    catch (e) {
      print(e);
      return [];
    }
  }
}