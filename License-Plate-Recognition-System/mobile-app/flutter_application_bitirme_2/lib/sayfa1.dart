import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Sayfa1Tabs extends StatefulWidget {
  const Sayfa1Tabs({super.key});

  @override
  State<Sayfa1Tabs> createState() => _Sayfa1TabsState();
}

class _Sayfa1TabsState extends State<Sayfa1Tabs> {
  var refKisiler = FirebaseDatabase.instance.ref();
  var bilgi = HashMap<String, dynamic>();

  //Firebase'e mod değerini güncellemek için kullanılan fonksiyon

  void _modDegistir(String mod) async {
    try {
      // Mod değerini güncellemek için 'settings/mod' yolunu kullanıyoruz
      await refKisiler
          .child('mod_kontrol/mod')
          .set(mod); // Veriyi 'settings/mod' yoluna kaydediyoruz

      // UI'yi güncelle
      setState(() {
        // Burada herhangi bir UI değişikliği yapılması gerekiyorsa yapılabilir
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mod $mod seçildi.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          leading: Icon(Icons.looks_one),
          title: Text("Plaka Okumalı Geçiş Modu"),
          subtitle: Text("1.Mod"),
          trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Mod Hakkında Bilgi"),
                          content: Text(
                              "Sistemin ana çalışma modudur. Sistem bu modda çalışırken gelen araçların plakalarını okur ve plaka sisteme kayıtlı ise araca geçiş izni verir"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Tamam"))
                          ],
                        ));
              },
              icon: Icon(Icons.info)),
          onTap: () {
            _modDegistir("1");

            print("1.Mod Seçildi.");
          },
        ),
        ListTile(
          leading: Icon(Icons.looks_two),
          title: Text("Basit Çalışma Modu"),
          subtitle: Text("2.Mod"),
          trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Mod Hakkında Bilgi"),
                          content: Text(
                              "Sistemin basit çalışma modudur. Bu modda sistem bir araç tespit ettiğinde plaka sorgusu yapmadan geçiş izni verir."),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Tamam"))
                          ],
                        ));
              },
              icon: Icon(Icons.info)),
          onTap: () {
            _modDegistir("2");
            print("2.Mod Seçildi.");
          },
        ),
        ListTile(
          leading: Icon(Icons.looks_3),
          title: Text("Sürekli Kapalı Modu"),
          subtitle: Text("3.Mod"),
          trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Mod Hakkında Bilgi"),
                          content: Text(
                              "Bu modda sistem herhangi bir işlevi yerine getirmez. Kapı sürekli kapalı durumda kalır ve kimseye geçiş izni vermez."),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Tamam"))
                          ],
                        ));
              },
              icon: Icon(Icons.info)),
          onTap: () {
            _modDegistir("3");
            print("3.Mod Seçildi.");
          },
        ),
      ],
    ));
  }
}
