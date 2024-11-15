import 'package:LAST_SUMMER_COFFE/cosntants/version.dart';
import 'package:LAST_SUMMER_COFFE/shared/giris_yapilan_widget.dart';
import 'package:LAST_SUMMER_COFFE/shared/giris_yapilmayan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LAST_SUMMER_COFFE/controller/login_controller.dart';
import 'package:LAST_SUMMER_COFFE/controller/masa_controller.dart';
import 'package:LAST_SUMMER_COFFE/cosntants/sirket_bilgileri/my_colors.dart';
import 'package:LAST_SUMMER_COFFE/screens/masa_detay_screen.dart';
import 'package:LAST_SUMMER_COFFE/shared/urun_listesi_widget.dart';

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
    final loginController = ref.watch(loginControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'LAST SUMMER COFFEE',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: myDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: urunListesiWidget(),
          ),
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                    itemCount: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                    itemBuilder: (context, index1) {
                      return GestureDetector(
                        //borderRadius: BorderRadius.circular(20),
                        onSecondaryTapUp: (details) {
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              details.globalPosition.dx, // Sağa doğru konum
                              details.globalPosition.dy, // Aşağıya doğru konum
                              details.globalPosition.dx + 100, // Menünün genişliği
                              details.globalPosition.dy + 100, // Menünün yüksekliği
                            ),
                            items: List<PopupMenuEntry>.generate(1, (index2) {
                              return PopupMenuItem(
                                value: index2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${index1 + 1}. Masayı Taşı'),
                                    FaIcon(
                                      FontAwesomeIcons.chevronRight,
                                      size: 15,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  showMenu(
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                      details.globalPosition.dx + 50, // Sağa doğru konum
                                      details.globalPosition.dy, // Aşağıya doğru konum
                                      details.globalPosition.dx + 100, // Menünün genişliği
                                      details.globalPosition.dy + 100, // Menünün yüksekliği
                                    ),
                                    items: <PopupMenuEntry>[
                                      PopupMenuItem(
                                        child: SizedBox(
                                          height: 500,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: List<Widget>.generate(20, (index3) {
                                                return PopupMenuItem(
                                                  value: index3,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('${index3 + 1}. Masaya Taşı'),
                                                      FaIcon(
                                                        FontAwesomeIcons.downLong,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                  onTap: () async {
                                                    if (masaController.masaUrunleriniAl(index3 + 1).isEmpty) {
                                                      await masaController.masaTasi(index1 + 1, index3 + 1);
                                                    } else {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            contentPadding: const EdgeInsets.all(50),
                                                            title: const Text(
                                                              'Masa Taşıma İşlemi',
                                                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                                            ),
                                                            content: const Text(
                                                              'Taşımak İstesiğiniz Masa Boş Değil. Yine de Taşınsın Mı ?',
                                                              style: TextStyle(fontSize: 30),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () async {
                                                                  await masaController.masaTasi(index1 + 1, index3 + 1);
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
                                                    }
                                                  },
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                          );
                        },

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MasaDetayScreen(masaNo: index1 + 1),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: masaController.masaUrunleriniAl(index1 + 1).isEmpty ? Colors.green : Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Masa ${index1 + 1}',
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
          ),
        ],
      ),
    );
  }

  Widget myDrawer() {
    final loginController = ref.watch(loginControllerProvider);

    return Consumer(
      builder: (context, ref, child) {
        return Drawer(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: MyColors.color1,
                  maxRadius: 50,
                  child: loginController.isLogin == false || loginController.isLogin == null
                      ? const FaIcon(
                          FontAwesomeIcons.user,
                          size: 40,
                        )
                      : Text(
                          '${loginController.yetkiliKodAdi?.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                if (loginController.isLogin == true) girisYapilanWidget(loginController, context) else girisYapilmayanWidget(loginController),
                const Spacer(),
                InkWell(
                  onTap: null,
                  child: Text(
                    Version.versionNo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
