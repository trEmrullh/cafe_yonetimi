import 'package:LAST_SUMMER_COFFE/controller/gun_sonu_controller.dart';
import 'package:LAST_SUMMER_COFFE/controller/login_controller.dart';
import 'package:LAST_SUMMER_COFFE/cosntants/sirket_bilgileri/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

Widget girisYapilanWidget(LoginController loginController, BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      return Padding(
        padding: EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 100),
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
              onTap: () async {
                String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

                await ref.read(gunSonuControllerProvider).gunSonunuGetir();

                showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer(
                      builder: (context, ref, child) {
                        final gunSonuControllerConsumer = ref.watch(gunSonuControllerProvider);

                        return AlertDialog(
                          title: Text('Gün Sonu'),
                          titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: SizedBox(
                            height: 400,
                            width: 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(endIndent: 300),
                                Text(
                                  '$date',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(endIndent: 300),
                                const SizedBox(height: 20),
                                Text(
                                  'Gün Sonu Toplamı',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${gunSonuControllerConsumer.gunSonu} TL',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Gün Sonunu Sıfırlamak İstiyor Musunuz ?'),
                                      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      actions: [
                                        InkWell(
                                          onTap: () async {
                                            await ref.read(gunSonuControllerProvider).gunSonunuSifirla();

                                            if (context.mounted) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Container(
                                              height: 25,
                                              width: 100,
                                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                              decoration: BoxDecoration(
                                                color: MyColors.red,
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: MyColors.red,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'SIFIRLA',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        InkWell(
                                          borderRadius: BorderRadius.circular(5),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 100,
                                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color: MyColors.grey2,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 0.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.x,
                                                  size: 10,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  'VAZGEÇ',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 25,
                                width: 100,
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: MyColors.red,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 0.5,
                                    color: MyColors.red,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.x,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'SIFIRLA',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 25,
                                width: 100,
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: MyColors.grey2,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.x,
                                      size: 10,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'KAPAT',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
            // const SizedBox(height: 10),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MyPageRoute(
            //         page: UrunYonetimScreen(),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //     decoration: BoxDecoration(
            //       color: MyColors.color1,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Row(
            //       children: [
            //         Text(
            //           'Ürünleri Yönet',
            //           style: const TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         const Spacer(),
            //         const Padding(
            //           padding: EdgeInsets.only(left: 20),
            //           child: Icon(
            //             Icons.keyboard_arrow_right,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
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
      );
    },
  );
}
