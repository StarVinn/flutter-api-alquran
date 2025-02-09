import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class HttpService {
  final String postsURL = 'https://quran-api.santrikoding.com/api/surah';
  Future<List<Surah>> getSurah() async {
    http.Response res = await http.get(Uri.parse(postsURL));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Surah> surah = body
          .map(
            (dynamic item) => Surah.fromJson(item),
          )
          .toList();
      return surah;
    } else {
      throw Exception('Failed to load Surah');
    }
  }
  Future<SurahDetail> getSurahDetail(int nomor) async {
    final String url = '$postsURL/$nomor';
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return SurahDetail.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load Surah');
    }
  }
  
}
