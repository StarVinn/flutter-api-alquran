import 'package:flutter/material.dart';
import 'post_model.dart';
import 'posts.dart';

String cleanHtmlTags(String htmlString) {
  return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
}

class SurahDetailPage extends StatelessWidget {
  final SurahDetail surahDetail;

  const SurahDetailPage({super.key, required this.surahDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          surahDetail.namaLatin ?? "Detail Surah",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: surahDetail.ayat?.length ?? 0,
        itemBuilder: (context, index) {
          final ayat = surahDetail.ayat![index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  ayat.nomor.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                ayat.ar ?? "-",
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontFamily: "Arabic",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                  height: 1.5,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Latin: ${cleanHtmlTags(ayat.tr ?? "-")}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Terjemahan: ${ayat.idn ?? "-"}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
