import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api{
  var api = Dio(BaseOptions(baseUrl: dotenv.env['API_KEY'] as String));

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
}