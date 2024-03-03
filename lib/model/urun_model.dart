class Urun {
  String? urunAdi;
  double? fiyat;
  int? adet;

  Urun({
    this.urunAdi,
    this.fiyat,
    this.adet,
  });

  Urun.fromJson(Map<String, dynamic> json) {
    urunAdi = json['UrunAdi'];
    fiyat = json['Fiyat'];
    adet = json['Adet'];
  }

  Map<String, dynamic> toJson() => {
        'UrunAdi': urunAdi,
        'Fiyat': fiyat,
        'Adet': adet,
      };
}
