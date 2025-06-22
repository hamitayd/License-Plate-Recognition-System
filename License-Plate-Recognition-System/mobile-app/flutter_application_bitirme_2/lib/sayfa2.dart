import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bitirme_2/vtdaki_butun_kayitlari_getirme.dart';

class Sayfa2Tabs extends StatefulWidget {
  const Sayfa2Tabs({super.key});

  @override
  State<Sayfa2Tabs> createState() => _Sayfa2TabsState();
}

class _Sayfa2TabsState extends State<Sayfa2Tabs> {
  var refKisiler = FirebaseDatabase.instance.ref().child("kisiler_tablo");

  TextEditingController adControllerKE = TextEditingController();
  TextEditingController soyadControllerKE = TextEditingController();
  TextEditingController plakaControllerKE = TextEditingController();

  TextEditingController adControllerKS = TextEditingController();
  TextEditingController soyadControllerKS = TextEditingController();
  void kisiEkle() async {
    var bilgi = HashMap<String, dynamic>();
    bilgi["kisi_ad"] = "${adControllerKE.text}";
    bilgi["kisi_soyad"] = "${soyadControllerKE.text}";
    bilgi["kisi_plaka"] = "${plakaControllerKE.text}";

    // Loading göstergesi ekleyelim
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(), // loading göstergesi
              SizedBox(width: 20),
              Text("Veri ekleniyor..."),
            ],
          ),
        );
      },
    );

    try {
      // Firebase işleminden önce loading göstergesi açık
      await refKisiler.push().set(bilgi); // veri kaydı yapar

      // Veritabanına başarılı bir şekilde eklendiğinde UI'yi güncelle
      setState(() {
        // UI'yi güncelle
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Kayıt Eklendi: ${adControllerKE.text} ${soyadControllerKE.text} ${plakaControllerKE.text}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    } finally {
      // Dialogu kapatalım
      Navigator.pop(context); // loading göstergeyi kapat

      // Alanları temizleme
      adControllerKE.clear();
      soyadControllerKE.clear();
      plakaControllerKE.clear();
    }
  }

  void _kaydet() {
    String ad = adControllerKE.text;
    String soyad = soyadControllerKE.text;
    String plaka = plakaControllerKE.text;

    if (ad.isNotEmpty && soyad.isNotEmpty && plaka.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Bu kaydı yapmak istediğinize emin misiniz?"),
                actions: [
                  TextButton(
                      onPressed: () => {
                            Navigator.pop(context),
                            adControllerKE.clear(),
                            soyadControllerKE.clear(),
                            plakaControllerKE.clear()
                          },
                      child: Text("Hayır")),
                  TextButton(
                      onPressed: () => {
                            Navigator.pop(context),
                            kisiEkle(),
                          },
                      child: Text("Evet")),
                ],
              ));

      // Alanları temizleme
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
    }
  }

  void _sil() {
    String ad = adControllerKS.text;
    String soyad = soyadControllerKS.text;
    if (ad.isNotEmpty && soyad.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text("Bu kaydı silmek istediğinize emin misiniz?"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Hayır")),
                  TextButton(
                      onPressed: () => {
                            Navigator.pop(context),
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Kayıt Silindi: $ad $soyad')),
                            )
                          },
                      child: Text("Evet")),
                ],
              ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen gerekli alanları doldurunuz.')),
      );
    }
    adControllerKS.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kayıt Ekleme',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: adControllerKE,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ad',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: soyadControllerKE,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Soyad',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: plakaControllerKE,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Plaka',
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _kaydet,
                      child: Text('Kaydet'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VtdakiButunKayitlariGetirme()));
                  },
                  child: Text("Tüm Kişileri Listele"))
            ],
          ),
        ),
      ),
    );
  }
}
