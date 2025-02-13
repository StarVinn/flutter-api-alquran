import 'package:flutter/material.dart';
import 'http_service.dart';
import 'surah_model.dart';
import 'surah_detail.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final HttpService httpService = HttpService();
  List<Surah> surahList = [];
  List<Surah> filteredSurahList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSurah();
    searchController.addListener(() {
      filterSurah();
    });
  }

  void fetchSurah() async {
    surahList = await httpService.getSurah();
    setState(() {
      filteredSurahList = surahList;
    });
  }

  void filterSurah() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredSurahList = surahList.where((surah) {
        return surah.nama_latin.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Al-Quran',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 200, // Adjust width as needed
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Cari Surah...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: filteredSurahList.length,
        itemBuilder: (context, index) {
          final surah = filteredSurahList[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(
                  surah.nomor.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                surah.nama_latin,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jumlah Ayat: ${surah.jumlah_ayat}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Tempat Turun: ${surah.tempat_turun}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Arti: ${surah.arti}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                final surahDetail =
                    await httpService.getSurahDetail(surah.nomor);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahDetailPage(
                      surahDetail: surahDetail,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
