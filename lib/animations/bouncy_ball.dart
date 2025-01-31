import 'package:animation_practice/animations/bouncy_animation_mixin.dart';
import 'package:flutter/material.dart';

class BouncyBall extends StatefulWidget {
  const BouncyBall({super.key});

  @override
  State<BouncyBall> createState() => _BouncyBallState();
}

class _BouncyBallState extends State<BouncyBall>
    with TickerProviderStateMixin, BouncyAnimationMixin {
  @override
  void initState() {
    super.initState();
    setSize(140, 219);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('tapped');
        extendController.forward();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([extendAnimation, bounceController]),
        builder: (context, child) {
          double size = extendController.isAnimating
              ? extendAnimation.value
              : bounceAnimation.value;
          return Container(
            width: extendAnimation.isDismissed ? 140 : size,
            height: extendAnimation.isDismissed ? 140 : size,
            decoration: BoxDecoration(
              color: Colors.amber[900],
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}
