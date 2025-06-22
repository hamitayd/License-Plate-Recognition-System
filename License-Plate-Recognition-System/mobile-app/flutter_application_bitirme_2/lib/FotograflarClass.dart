class Fotograflarclass {
  String plaka;
  String resim_metni;
  String tarih;
  String isim;
  String soyisim;
  String saat;
  Fotograflarclass(
      {required this.plaka,
      required this.resim_metni,
      required this.tarih,
      required this.isim,
      required this.soyisim,
      required this.saat});

  // Firebase'den gelen JSON verisini Dart objesine dönüştürme
  factory Fotograflarclass.fromJson(Map<dynamic, dynamic> json) {
    return Fotograflarclass(
        plaka: json['plaka'] ?? '',
        resim_metni: json['resim metni'] ?? '',
        tarih: json['tarih'] ?? '',
        isim: json['isim'] ?? '',
        soyisim: json['soyisim'] ?? '',
        saat: json['saat'] ?? '');
  }
}
