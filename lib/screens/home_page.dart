import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:last_summer/controller/masa_controller.dart';
import 'package:last_summer/screens/masa_detay_screen.dart';
import 'package:last_summer/shared/urun_listesi_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  @override
  void initState() {
    for (var i = 1; i < 21; i++) {
      ref.read(masaControllerProvider).icerikleriCihazdanAl(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final masaController = ref.watch(masaControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'LAST SUMMER COFFE',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: urunListesiWidget(),
          ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      maxRadius: 10,
                    ),
                    SizedBox(width: 5),
                    Text('Boş Masa'),
                    SizedBox(width: 100),
                    CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      maxRadius: 10,
                    ),
                    SizedBox(width: 5),
                    Text('Dolu Masa'),
                  ],
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 10.0,
                    mainAxisSpacing: 40,
                    mainAxisExtent: 100,
                    crossAxisSpacing: 40,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MasaDetayScreen(masaNo: index + 1),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: masaController.masaUrunleriniAl(index + 1).isEmpty ? Colors.green : Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Masa ${index + 1}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
