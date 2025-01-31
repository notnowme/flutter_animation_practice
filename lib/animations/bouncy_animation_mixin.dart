import 'package:animation_practice/animations/custom_bounceOut_curve.dart';
import 'package:flutter/material.dart';

mixin BouncyAnimationMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController extendController;
  late AnimationController bounceController;

  late Animation<double> extendAnimation;
  late Animation<double> bounceAnimation;

  double startSize = 0;
  double endSize = 0;

  void setSize(double start, double end) {
    extendAnimation = Tween<double>(begin: start, end: end).animate(
      CurvedAnimation(
        parent: extendController,
        curve: const Cubic(0.23, 0.86, 0.29, 1),
      ),
    );

    bounceAnimation = Tween<double>(begin: end, end: start).animate(
      CurvedAnimation(
        parent: bounceController,
        curve: CustomBounceCurve(),
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    extendController = AnimationController(
      duration: const Duration(milliseconds: 380),
      vsync: this,
    );
    bounceController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // extendAnimation = Tween<double>(begin: startSize, end: endSize).animate(
    //   CurvedAnimation(
    //     parent: extendController,
    //     curve: Curves.easeInOut,
    //   ),
    // );

    // bounceAnimation = Tween<double>(begin: endSize, end: startSize).animate(
    //   CurvedAnimation(parent: bounceController, curve: CustomBounceCurve()),
    // );

    extendController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 200));
        bounceController.forward();
      }
    });

    bounceController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        extendController.reset();
        bounceController.reset();
      }
    });
  }

  @override
  void dispose() {
    extendController.dispose();
    bounceController.dispose();
    super.dispose();
  }
}
