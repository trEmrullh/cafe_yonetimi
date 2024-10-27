import 'package:LAST_SUMMER_COFFE/cosntants/sirket_bilgileri/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:LAST_SUMMER_COFFE/controller/masa_controller.dart';
import 'package:LAST_SUMMER_COFFE/cosntants/urunler.dart';
import 'package:LAST_SUMMER_COFFE/model/urun_model.dart';

Widget urunListesiWidget({String? kullanilanEkran, int? masaNo}) {
  Urunler urunler = Urunler();

  return Consumer(
    builder: (context, ref, child) {
      final masaController = ref.watch(masaControllerProvider);

      return Column(
        children: [
          const Text(
            'ÜRÜNLER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            indent: 50,
            endIndent: 50,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
              itemCount: urunler.urunler.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Urun urun = urunler.urunler[index];

                return InkWell(
                  onTap: kullanilanEkran == 'MasaDetay'
                      ? () {
                          masaController.urunEkle(masaNo!, urun);
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: kullanilanEkran == 'MasaDetay' ? Colors.black26 : MyColors.color1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 12,
                          child: Text(
                            urun.urunAdi.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${urun.fiyat} TL',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (kullanilanEkran == 'MasaDetay')
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.keyboard_arrow_right,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
    },
  );
}
