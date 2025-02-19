import 'package:flutter/material.dart';
import 'surah_model.dart';

String cleanHtmlTags(String htmlString) {
  return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
}

class SurahDetailPage extends StatefulWidget {
  final SurahDetail surahDetail;

  const SurahDetailPage({super.key, required this.surahDetail});

  @override
  _SurahDetailPageState createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  TextEditingController searchController = TextEditingController();
  List<Ayat> filteredAyat = [];

  @override
  void initState() {
    super.initState();
    filteredAyat = widget.surahDetail.ayat ?? [];
  }

  void filterAyat(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredAyat = widget.surahDetail.ayat ?? [];
      } else {
        filteredAyat = widget.surahDetail.ayat!
            .where((ayat) => ayat.nomor.toString().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.surahDetail.namaLatin ?? "Detail Surah",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: searchController,
                onChanged: filterAyat,
                decoration: const InputDecoration(
                  hintText: "Cari Ayat...",
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 248, 223), width: 2), // 2px border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 2), // 2px border when focused
                  ),
                  hintStyle: TextStyle(color: Colors.white60),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: filteredAyat.length,
        itemBuilder: (context, index) {
          final ayat = filteredAyat[index];
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
                      cleanHtmlTags(ayat.tr ?? "-"),
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
