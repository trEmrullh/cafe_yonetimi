import 'package:LAST_SUMMER_COFFE/cosntants/sirket_bilgileri/my_colors.dart';
import 'package:LAST_SUMMER_COFFE/model/urun_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UrunYonetimScreen extends ConsumerStatefulWidget {
  const UrunYonetimScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UrunYonetimScreen();
}

class _UrunYonetimScreen extends ConsumerState<UrunYonetimScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ÜRÜNLER',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Yeni Ürün Ekleme'),
                      titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      content: SizedBox(
                        width: 400,
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Ürün Adı',
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Fiyat',
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
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
                        InkWell(
                          onTap: () async {},
                          child: Container(
                            height: 25,
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                            decoration: BoxDecoration(
                              color: MyColors.darkPurple,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 0.5,
                                color: MyColors.darkPurple,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.plus,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'EKLE',
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
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                  color: MyColors.darkGreen,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.plus,
                      size: 12,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Ürün Ekle',
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
          ],
        ),
      ),
    );
  }
}
