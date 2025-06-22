import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bitirme_2/FotograflarClass.dart';
import 'package:flutter_application_bitirme_2/foto_goster.dart';

class GirisCikisListele extends StatefulWidget {
  String veri; // Veri parametresi

  // Constructor ile veri alıyoruz
  GirisCikisListele({required this.veri});

  @override
  State<GirisCikisListele> createState() => _GirisCikisListeleState();
}

class _GirisCikisListeleState extends State<GirisCikisListele> {
  var refKisiler = FirebaseDatabase.instance.ref().child("FOTORAFLAR");
  List<Fotograflarclass> tempFotograflar = []; // Firebase'den alınan veriler

  // Firebase'den verileri çekme fonksiyonu
  esitlikArama() async {
    var sorgu = refKisiler.orderByChild("tarih").equalTo("${widget.veri}");
    sorgu.onValue.listen((event) {
      var gelendegerler = event.snapshot.value as dynamic;
      if (gelendegerler != null) {
        List<Fotograflarclass> tempList = [];
        gelendegerler.forEach((key, nesne) {
          var gelenKisi = Fotograflarclass.fromJson(nesne);
          tempList.add(gelenKisi);
        });
        setState(() {
          tempFotograflar =
              tempList; // Veriyi state'e ekleyerek UI'yi güncelliyoruz
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    esitlikArama(); // Firebase verilerini alıyoruz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş- Çıkışlar"),
        backgroundColor: Colors.orange,
      ),
      body: tempFotograflar.isEmpty
          ? Center(
              child: CircularProgressIndicator()) // Veriler yükleniyorsa göster
          : ListView.builder(
              itemCount: tempFotograflar.length, // veri sayısı
              itemBuilder: (context, index) {
                var fotograflar = tempFotograflar[index];
                return GestureDetector(
                  // tıklanabilirlik özelliği verir
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FotoGoster(fotograflar: fotograflar)));
                  },
                  child: Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Plaka: ${fotograflar.plaka}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("İsim: ${fotograflar.isim}"),
                                Text("Soyisim: ${fotograflar.soyisim}"),
                                Text("Tarih: ${fotograflar.tarih}"),
                                Text("Saat: ${fotograflar.saat}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
