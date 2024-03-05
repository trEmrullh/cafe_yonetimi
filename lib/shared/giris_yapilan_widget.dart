import 'package:LAST_SUMMER_COFFE/controller/login_controller.dart';
import 'package:LAST_SUMMER_COFFE/cosntants/sirket_bilgileri/my_colors.dart';
import 'package:flutter/material.dart';

Widget girisYapilanWidget(LoginController loginController, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 100),
    child: Expanded(
      child: Column(
        children: [
          Text(
            'Hoşgeldiniz',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            loginController.yetkiliAdi.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Bugün Şimdiye Kadar'),
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: MyColors.color1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    'Gün Sonunu Gör',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 200),
          InkWell(
            onTap: () async {
              await loginController.cikisYap();
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD32F2F),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: const Text(
                'Çıkış Yap',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
