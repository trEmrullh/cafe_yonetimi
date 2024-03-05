import 'package:LAST_SUMMER_COFFE/cosntants/version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:LAST_SUMMER_COFFE/cosntants/sirket_bilgileri/my_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.color1,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value * MediaQuery.of(context).size.height / 3),
                  child: Transform.scale(
                    scale: _animation.value,
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  Card(
                    shadowColor: Colors.black,
                    elevation: 10,
                    surfaceTintColor: Colors.red,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/last_summer.jpeg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Design By',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Emrullah Orhan',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 30,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
