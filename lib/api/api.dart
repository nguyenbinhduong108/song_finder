import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api{
  var api = Dio(BaseOptions(baseUrl: dotenv.env['API_KEY'] as String));

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
}