import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bitirme_2/FotograflarClass.dart';

class Listele extends StatefulWidget {
  String veri; // Veri parametresi

  // Constructor ile veri alıyoruz
  Listele({required this.veri});

  @override
  State<Listele> createState() => _ListeleState();
}

class _ListeleState extends State<Listele> {
  var refKisiler = FirebaseDatabase.instance.ref().child("FOTORAFLAR");
  List<Fotograflarclass> fotografListesi = [];
  Uint8List? bytes; // Firebase'den alınan base64 resmi tutacağımız değişken

  // Firebase'den verileri çekme fonksiyonu
  esitlikArama() async {
    var sorgu = refKisiler.orderByChild("tarih").equalTo("${widget.veri}");
    sorgu.onValue.listen((event) {
      var gelendegerler = event.snapshot.value as dynamic;
      if (gelendegerler != null) {
        List<Fotograflarclass> tempFotograflar = [];
        gelendegerler.forEach((key, nesne) {
          var gelenKisi = Fotograflarclass.fromJson(nesne);
          print("*******************");
          print("Kişi plaka : ${gelenKisi.plaka}");
          print("Tarih: ${gelenKisi.tarih}");

          // Base64 string'i Uint8List'e dönüştürme
          Uint8List decodedBytes = base64Decode(gelenKisi.resim_metni);

          // Listeye ekleyin (isteğe bağlı)
          tempFotograflar.add(gelenKisi);

          // State'i güncelle
          setState(() {
            bytes = decodedBytes; // Resim verisini güncelliyoruz
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    esitlikArama(); // Verileri çeker
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş-çıkışlar"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: bytes == null
            ? CircularProgressIndicator() // Veriler yüklenene kadar bir yükleme simgesi göster
            : Image.memory(bytes!), // Resmi ekranda göster
      ),
    );
  }
}
