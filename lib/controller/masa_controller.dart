import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:last_summer/model/urun_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasaController extends ChangeNotifier {
  Map<int, List<Urun>> masaUrunListeleri = {};
  int? masaNumber;

  void urunEkle(int masaNo, Urun urun) {
    if (!masaUrunListeleri.containsKey(masaNo)) {
      masaUrunListeleri[masaNo] = [];
    }
    masaUrunListeleri[masaNo]?.add(urun);
    masaNumber = masaNo;

    notifyListeners();
  }

  List<Urun> masaUrunleriniAl(int masaNo) {
    return masaUrunListeleri[masaNo] ?? [];
  }

  double masaFiyatToplami(int? masaNo) {
    double total = 0.0;
    List<Urun>? masadakiUrunler = masaUrunListeleri[masaNo];

    if (masadakiUrunler != null) {
      for (var i in masadakiUrunler) {
        total += (i.fiyat! * i.adet!);
      }
    }

    return total;
  }

  void urunKompleSil(int masaNo, int index) {
    masaUrunListeleri[masaNo]?.removeAt(index);
    notifyListeners();
  }

  void urunArttir(int masaNo, int index, Urun urun) {
    List<Urun>? urunList = masaUrunListeleri[masaNo];

    if (urunList!.contains(urun)) {
      urunList[index].adet = urunList[index].adet! + 1;
    }
    notifyListeners();
  }

  void urunAzalt(int masaNo, int index, Urun urun) {
    List<Urun>? urunList = masaUrunListeleri[masaNo];

    if (urunList!.contains(urun)) {
      if (urunList[index].adet! > 1) {
        urunList[index].adet = urunList[index].adet! - 1;
      } else {
        urunKompleSil(masaNo, index);
      }
    }

    notifyListeners();
  }

  Future<void> odemeyiAl(int masaNo) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.remove('Masa$masaNo');
    masaUrunListeleri[masaNo]?.clear();
    notifyListeners();
  }

  Future<void> icerikleriCihazaKaydet(int masaNo) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<Urun>? urunList = masaUrunListeleri[masaNo];
    if (urunList != null) {
      List<String> urunJsonList = urunList.map((urun) => jsonEncode(urun.toJson())).toList();

      await _prefs.setStringList('Masa$masaNo', urunJsonList);
    }
    notifyListeners();
  }

  Future<List<Urun>> icerikleriCihazdanAl(int masaNo) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    List<String>? urunJsonList = _prefs.getStringList('Masa$masaNo');

    if (urunJsonList != null) {
      notifyListeners();
      return masaUrunListeleri[masaNo] = urunJsonList.map((urunJson) => Urun.fromJson(jsonDecode(urunJson))).toList();
    } else {
      return [];
    }
  }
}

final masaControllerProvider = ChangeNotifierProvider((ref) {
  return MasaController();
});
