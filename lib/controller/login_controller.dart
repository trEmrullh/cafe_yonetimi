import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  bool? isLogin = false;
  bool errorLogin = false;

  TextEditingController personelNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? yetkiliAdi;
  String? yetkiliKodAdi;

  Future<void> loginFun() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    isLogin = true;

    await _prefs.setString('KullaniciAd', personelNameController.text.toLowerCase());
    await _prefs.setBool('isLogin', isLogin!);

    await getAllDataFun();

    personelNameController.clear();
    passwordController.clear();

    notifyListeners();
  }

  Future<bool> errorLoginFun() async {
    errorLogin = true;

    personelNameController.clear();
    passwordController.clear();

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        errorLogin = false;
        notifyListeners();
      },
    );
    return errorLogin;
  }

  Future<void> getAllDataFun() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    var name = _prefs.getString('KullaniciAd');
    isLogin = _prefs.getBool('isLogin');

    switch (name) {
      case null:
        yetkiliAdi = null;
        break;
      case 'emre':
        yetkiliAdi = 'Emre AKKÖZ';
        break;
      case 'emrullah':
        yetkiliAdi = 'Emrullah ORHAN';
        break;
      case 'mustafa':
        yetkiliAdi = 'Mustafa BOZGEYİK';
        break;
      case 'hakan':
        yetkiliAdi = 'Hakan BOZGEYİK';
        break;
      default:
        notifyListeners();
    }

    if (yetkiliAdi != null) {
      List<String> parcalar = yetkiliAdi!.split(' ');
      if (parcalar.length >= 2) {
        yetkiliKodAdi = '${parcalar[0][0]}${parcalar[1][0]}';
      }
    }
    notifyListeners();
  }

  Future<void> cikisYap() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.remove('KullaniciAd');
    await _prefs.remove('isLogin');

    yetkiliAdi = null;
    yetkiliKodAdi = null;
    isLogin = null;
    notifyListeners();
  }
}

final loginControllerProvider = ChangeNotifierProvider((ref) {
  return LoginController();
});
