import 'dart:convert'; // base64Decode kullanabilmek için gerekli
import 'dart:typed_data'; // Uint8List kullanmak için gerekli
import 'package:flutter/material.dart';
import 'package:flutter_application_bitirme_2/FotograflarClass.dart'; // Fotograflarclass'ı import et

class FotoGoster extends StatelessWidget {
  final Fotograflarclass
      fotograflar; // Fotograflarclass türünde bir veri alıyoruz

  // Constructor ile veriyi alıyoruz
  FotoGoster({required this.fotograflar});

  @override
  Widget build(BuildContext context) {
    // Base64 verisini çözme işlemi
    String base64Image =
        fotograflar.resim_metni; // Base64 formatındaki veriyi alıyoruz
    Uint8List bytes = base64Decode(base64Image); // Base64'ü çöz

    return Scaffold(
      appBar: AppBar(
        title: Text("Fotoğraf Detayları"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black, // Arka planı siyah yapıyoruz
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Resmi ekranda tam genişlikte ve yükseklikte gösteriyoruz
            Image.memory(
              bytes,
              width:
                  MediaQuery.of(context).size.width, // Ekranın genişliği kadar
              height: MediaQuery.of(context).size.height /
                  3, // Ekranın yüksekliği kadar
              fit: BoxFit.cover, // Resmi boyutlara göre kırpma işlemi
            ),
            SizedBox(height: 20),
            // Alttaki yazıları beyaz renkte yapıyoruz
            Text(
              "İsim: ${fotograflar.isim}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              "Soyisim: ${fotograflar.soyisim}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              "Tarih: ${fotograflar.tarih}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              "Saat: ${fotograflar.saat}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
