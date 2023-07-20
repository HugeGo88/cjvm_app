import 'package:flutter/material.dart';

class LogoProgress extends StatefulWidget {
  const LogoProgress({
    super.key,
  });

  @override
  State<LogoProgress> createState() => _LogoProgressState();
}

class _LogoProgressState extends State<LogoProgress>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: false);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.linear);

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'images/logo.png',
          width: 150,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
