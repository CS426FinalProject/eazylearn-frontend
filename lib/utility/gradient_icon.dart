import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final List<Color> colors;
  GradientIcon({@required this.icon, @required this.colors});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ).createShader(bounds),
        child: SizedBox(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ));
  }
}
