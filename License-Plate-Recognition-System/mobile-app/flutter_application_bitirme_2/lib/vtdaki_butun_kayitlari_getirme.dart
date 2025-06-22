import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bitirme_2/Kisiler.dart';

class VtdakiButunKayitlariGetirme extends StatefulWidget {
  const VtdakiButunKayitlariGetirme({super.key});

  @override
  State<VtdakiButunKayitlariGetirme> createState() =>
      _VtdakiButunKayitlariGetirmeState();
}

class _VtdakiButunKayitlariGetirmeState
    extends State<VtdakiButunKayitlariGetirme> {
  // Firebase verilerini dinleyeceğimiz referans
  var refKisiler = FirebaseDatabase.instance.ref().child("kisiler_tablo");

  // Verileri depolayacağımız liste
  List<String> tumKisilerDizi = [];

  // Firebase'den verileri almak ve listeyi güncellemek
  tumKisiler() async {
    // Firebase'den verileri dinleme işlemi
    refKisiler.onValue.listen((event) {
      var gelendegerler = event.snapshot.value as dynamic;
      if (gelendegerler != null) {
        tumKisilerDizi.clear(); // Listeyi temizle (her seferinde)
        gelendegerler.forEach((key, nesne) {
          var gelenKisi = Kisiler.fromJson(nesne);
          // Veriyi listeye ekle
          tumKisilerDizi.add(
              "${gelenKisi.kisi_ad} ${gelenKisi.kisi_soyad} - ${gelenKisi.kisi_plaka}");
        });
        // UI'yi güncelle
        setState(() {});
      }
    });
  }

  kisiSil(int index) async {
    String seciliKayit = tumKisilerDizi[index];
    int a = seciliKayit.indexOf('-');

    String result =
        seciliKayit.substring(a + 2, seciliKayit.length); // 'a' dahil
    print(result);

    try {
      // Veritabanında kisiler_tablo'yu tarayıp, kisi_plaka'nın değeri "plaka" ile eşleşen kişiyi buluyoruz
      DatabaseEvent event =
          await refKisiler.orderByChild('kisi_plaka').equalTo(result).once();

      // Eğer veri bulunduysa
      if (event.snapshot.exists) {
        // snapshot.children: tüm kişileri döndürür, bu durumda sadece eşleşen kişi olacak
        event.snapshot.children.forEach((child) {
          // Bu kişinin benzersiz ID'sini alıyoruz
          String personId = child.key!;
          // Kişiyi veritabanından siliyoruz
          refKisiler.child(personId).remove();
          print('$result kaydı başarıyla silindi.');
        });
      } else {
        print('$result kaydı bulunamadı.');
      }
    } catch (e) {
      // Hata durumunda bildirim
      print('Hata: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Veriyi al
    tumKisiler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Ana Sayfa"),
      ),
      body: ListView.builder(
        itemCount: tumKisilerDizi.length, // veri sayısı
        itemBuilder: (context, index) {
          // veri kümesinin boyutu kadar tekrar çalışır, for gibi
          return GestureDetector(
            // tıklanabilirlik özelliği verir
            onTap: () {
              // Burada ilgili kişiyle alakalı işlem yapabilirsin.
            },
            child: Card(
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        // text'e tıklanabilirlik özelliği verir
                        onTap: () {
                          print("Text ile ${tumKisilerDizi[index]} seçildi");
                        },
                        child: Text(tumKisilerDizi[index]),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: PopupMenuButton(
                        child: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text("Sil"),
                          ),
                        ],
                        onSelected: (menuItemValue) {
                          if (menuItemValue == 1) {
                            kisiSil(index);
                            print("${tumKisilerDizi[index]} Silindi");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
