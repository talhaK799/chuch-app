import 'package:flutter/material.dart';

extension sizeBoxNumber on num {
  SizedBox get height => SizedBox(height: this.toDouble());
  SizedBox get width => SizedBox(
        width: this.toDouble(),
      );
}
