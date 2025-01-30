import 'dart:math';

import 'package:flutter/material.dart';

class CustomBounceCurve extends Curve {
  @override
  double transform(double t) {
    const double amplitude = 0.5;
    const double period = 0.4;

    if (t == 0.0) return 0.0;
    if (t == 1.0) return 1.0;

    return 1.0 -
        amplitude *
            pow(2.0, -10.0 * t) *
            sin((t - period / 4.0) * (2 * pi) / period);
  }
}
