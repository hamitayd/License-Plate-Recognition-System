import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_bitirme_2/main.dart';

class Giris extends StatefulWidget {
  const Giris({super.key});
  @override
  State<Giris> createState() => _GirisState();
}

class _GirisState extends State<Giris> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 31, 208, 240),
            Colors.black87
          ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/fotolar/real_foto.png",
                height: screenHeight / 1.5,
                width: screenWidth / 1.5,
                //height: 100,
                //width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
