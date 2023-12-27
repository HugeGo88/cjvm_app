import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/color_utils.dart' as color_utils;

class LoadingConfetti extends StatefulWidget {
  const LoadingConfetti({super.key});

  @override
  State<LoadingConfetti> createState() => _LoadingConfettiState();
}

class _LoadingConfettiState extends State<LoadingConfetti> {
  late ConfettiController controller;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController();
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
            numberOfParticles: 10,
            emissionFrequency: 0.1,
            colors: [
              Colors.red,
              Colors.red.shade100,
              Colors.red.shade500,
              Colors.red.shade700,
              color_utils.commonThemeData.primaryColor
            ],
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Image(
            width: 125,
            height: 125,
            image: AssetImage('images/logo125.png'),
          ),
        ),
      ],
    );
  }
}
