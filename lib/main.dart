import 'package:LAST_SUMMER_COFFE/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:LAST_SUMMER_COFFE/cosntants/sirket_bilgileri/sirket_bilgileri.dart';
import 'package:LAST_SUMMER_COFFE/screens/home_page.dart';
import 'package:LAST_SUMMER_COFFE/screens/splash_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyApp();
}

class _MyApp extends ConsumerState<MyApp> {
  bool? isLoading;

  @override
  void initState() {
    initFun();
    super.initState();
  }

  Future<void> initFun() async {
    setState(() {
      isLoading = true;
    });

    await ref.read(loginControllerProvider).getAllDataFun();

    await Future.delayed(
      const Duration(seconds: 5),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: SirketBilgileri.sirketAdi.toUpperCase(),
      theme: ThemeData(
        fontFamily: 'Nunito',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Nunito',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: isLoading == true ? const SplashScreen() : const HomePage(),
    );
  }
}
