class Kisiler {
  String kisi_ad;
  String kisi_soyad;
  String kisi_plaka;

  Kisiler(
      {required this.kisi_ad,
      required this.kisi_soyad,
      required this.kisi_plaka});
  factory Kisiler.fromJson(Map<dynamic, dynamic> json) {
    return Kisiler(
        kisi_ad: json["kisi_ad"] as String,
        kisi_soyad: json["kisi_soyad"] as String,
        kisi_plaka: json["kisi_plaka"] as String);
  }
}
