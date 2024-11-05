import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GunSonuController extends ChangeNotifier {
  late double gunSonu;

  Future<void> gunSonunuGetir() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    double? gelenGunSonu = await _prefs.getDouble('GunSonu');

    if (gelenGunSonu == null) {
      gunSonu = 0.0;
    } else {
      gunSonu = gelenGunSonu;
    }

    notifyListeners();
  }

  Future<void> gunSonunaEkle(double value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    await gunSonunuGetir();

    gunSonu += value;

    await _prefs.setDouble('GunSonu', gunSonu);

    await gunSonunuGetir();
  }

  Future<void> gunSonunuSifirla() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('GunSonu');
    await gunSonunuGetir();

    notifyListeners();
  }
}

final gunSonuControllerProvider = ChangeNotifierProvider((ref) {
  return GunSonuController();
});
