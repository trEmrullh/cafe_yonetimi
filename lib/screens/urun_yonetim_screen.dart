import 'package:LAST_SUMMER_COFFE/model/urun_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UrunYonetimScreen extends ConsumerStatefulWidget {
  const UrunYonetimScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UrunYonetimScreen();
}

class _UrunYonetimScreen extends ConsumerState<UrunYonetimScreen> {
  var urunListesi = [
    "{'ID': 1, 'urunAdi': 'Çay', 'fiyat': 10.0, 'adet': 1}",
    "{'ID': 2, 'urunAdi': 'Su', 'fiyat': 10.0, 'adet': 1}",
    "{'ID': 3, 'urunAdi': 'Oralet Çeşitleri', 'fiyat': 10.0, 'adet': 1}",
  ];

  List<Urun>? gelenUrunListesi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ürünler',
          style: TextStyle(
            fontSize: 20,
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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {},
            child: Text('AAA'),
          )
        ],
      ),
    );
  }
}
