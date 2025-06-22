import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bitirme_2/giris.dart';
import 'package:flutter_application_bitirme_2/sayfa1.dart';
import 'package:flutter_application_bitirme_2/sayfa2.dart';
import 'package:flutter_application_bitirme_2/sayfa3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (Giris()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              "Sistem Kontrol Uygulaması",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Modlar",
                  icon: Icon(
                    Icons.looks_one,
                    color: Colors.black87,
                  ),
                ),
                Tab(
                  text: "Veri İşlemleri",
                  icon: Icon(
                    Icons.looks_two,
                    color: Colors.black87,
                  ),
                ),
                Tab(
                  text: "Giriş-Çıkışlar",
                  icon: Icon(
                    Icons.looks_3,
                    color: Colors.black87,
                  ),
                )
              ],
              indicatorColor: Colors.white, // seçili olanın altındaki çizgi
              labelColor: Colors.black, // yazı rengi
            ),
          ),
          body: TabBarView(children: [
            Sayfa1Tabs(),
            Sayfa2Tabs(),
            Sayfa3Tabs(),
          ]),
        ));
  }
}
