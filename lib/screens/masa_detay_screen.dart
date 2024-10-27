import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:LAST_SUMMER_COFFE/controller/masa_controller.dart';
import 'package:LAST_SUMMER_COFFE/model/urun_model.dart';
import 'package:LAST_SUMMER_COFFE/shared/urun_listesi_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MasaDetayScreen extends ConsumerWidget {
  const MasaDetayScreen({
    super.key,
    this.masaNo,
  });

  final int? masaNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masaController = ref.watch(masaControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () async {
            await masaController.icerikleriCihazaKaydet(masaNo!).then((value) {
              Navigator.of(context).pop();
            });
          },
        ),
        title: Column(
          children: [
            const Text(
              'LAST SUMMER COFFE',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'MASA ${masaNo}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 4,
            child: urunListesiWidget(kullanilanEkran: 'MasaDetay', masaNo: masaNo),
          ),
          Expanded(
            flex: 10,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemCount: masaController.masaUrunleriniAl(masaNo!).isEmpty ? 1 : masaController.masaUrunleriniAl(masaNo!).length,
                      padding: const EdgeInsets.only(left: 100, right: 300, top: 40, bottom: 50),
                      itemBuilder: (context, index1) {
                        List<Urun> item = masaController.masaUrunleriniAl(masaNo!);

                        if (item.isEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(top: 100),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black54,
                                width: 2,
                              ),
                            ),
                            child: const Text(
                              'Masa Boş. Ürün Yok.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          );
                        } else {
                          return Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB0BEC5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        item[index1].urunAdi.toString(),
                                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${item[index1].fiyat} TL',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          'Adet: ${item[index1].adet}',
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      SizedBox(
                                        height: 50,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) => const SizedBox(width: 10),
                                          itemCount: 2,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index2) {
                                            return InkWell(
                                              onTap: () {
                                                switch (index2) {
                                                  case 0:
                                                    masaController.urunAzalt(masaNo!, index1, item[index1]);

                                                  case 1:
                                                    masaController.urunArttir(masaNo!, index1, item[index1]);
                                                    break;
                                                }
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: index2 == 1 ? Colors.blue : Colors.red,
                                                maxRadius: 15,
                                                child: FaIcon(
                                                  index2 == 1 ? FontAwesomeIcons.plus : FontAwesomeIcons.minus,
                                                  size: 16,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  masaController.urunKompleSil(masaNo!, index1);
                                },
                                child: const CircleAvatar(
                                  maxRadius: 18,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'TOPLAM',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${masaController.masaFiyatToplami(masaNo)} TL',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(50),
                                title: const Text(
                                  'Ödeme İşlemi',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  'Ödeme Başarılı Bir Şekilde Alındı Mı ?',
                                  style: TextStyle(fontSize: 30),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      masaController.odemeyiAl(masaNo!);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Evet'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('İptal Et'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            'ÖDEMEYİ\nAL',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
