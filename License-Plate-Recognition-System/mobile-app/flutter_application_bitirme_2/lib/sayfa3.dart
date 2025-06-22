import 'package:flutter/material.dart';
import 'package:flutter_application_bitirme_2/giris_cikis_listele.dart';
import 'package:flutter_application_bitirme_2/isme_gore_gc_listele.dart';
import 'package:flutter_application_bitirme_2/listele.dart';

class Sayfa3Tabs extends StatefulWidget {
  const Sayfa3Tabs({super.key});

  @override
  State<Sayfa3Tabs> createState() => _Sayfa3TabsState();
}

class _Sayfa3TabsState extends State<Sayfa3Tabs> {
  var tarihKontrol = TextEditingController();
  var isimKontrol = TextEditingController();
  var soyadKontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giriş-Çıkış Kontrolü',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextField(
                          controller: tarihKontrol,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tarih',
                          ),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000), // ilk tarih
                                    lastDate: DateTime(2050)) // son tarih
                                .then((alinanTarih) {
                              setState(() {
                                try {
                                  tarihKontrol.text =
                                      "${alinanTarih!.year}/${alinanTarih.month}/${alinanTarih.day}";
                                } catch (e) {
                                  tarihKontrol.clear();
                                }
                              });
                            });
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextField(
                          controller: isimKontrol,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'İsim'),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextField(
                          controller: soyadKontrol,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Soyad'),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GirisCikisListele(
                                                  veri: tarihKontrol.text)));
                                },
                                child: Text("Listele")),
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IsmeGoreGcListele(
                                                  isim: isimKontrol.text,
                                                  soyad: soyadKontrol.text,
                                                  tarih: tarihKontrol.text)));
                                },
                                child: Text("İsme Göre Listele")),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
