import 'dart:convert';
import 'package:flutter_practice/models/album.dart';
import 'package:http/http.dart' as http;
import 'package:moment_dart/moment_dart.dart';

import '../models/progress_summertime_saga.dart';

class ApiService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse('$apiUrl/posts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/users'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<List<Album>> getAlbums() async {
    final response = await http.get(Uri.parse('$apiUrl/albums'));
    if (response.statusCode == 200) {
      // return json.decode(response.body);
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => Album.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  static Future<String> getLichCupDien() async {
    // Get the current date
    Moment now = Moment.now();
    String tuNgay = now.format('DD-MM-YYYY');
    String denNgay = now.add(const Duration(days: 5)).format('DD-MM-YYYY');
    const maKH = 'PB06070016618';
    const chucNang = 'MaKhachHang';
    final response = await http.get(Uri.parse(
        'https://cskh.evnspc.vn/TraCuu/GetThongTinLichNgungGiamMaKhachHang?tuNgay=$tuNgay&denNgay=$denNgay&maKH=$maKH&ChucNang=$chucNang'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<ProgressSummertimeSaga> getProgressSummertimeSagaData() async {
    final response = await http
        .get(Uri.parse('https://summertimesaga.com/data/progress.json'));

    if (response.statusCode == 200) {
      ProgressSummertimeSaga data =
          ProgressSummertimeSaga.fromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load progress data');
    }
  }
}
