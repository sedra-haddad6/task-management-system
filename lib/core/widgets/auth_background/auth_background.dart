import 'dart:ui';

import 'package:flutter/material.dart';

import '../../style/repo.dart';


class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    super.key,
    required this.child,
  });

  Widget _circle({
    required double size,
    required Color color,
    bool blur = false,
  }) {
    Widget circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );

    if (!blur) return circle;

    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: 8,
        sigmaY: 8,
      ),
      child: circle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleRepo.white,
      body: SafeArea(
        child: Stack(
          children: [

            Positioned(
              top: -45,
              right: -45,
              child: _circle(
                size: 140,
                color: StyleRepo.darkBlue,
                blur: true,
              ),
            ),

            Positioned(
              top: 120,
              left: -55,
              child: _circle(
                size: 135,
                color: StyleRepo.green,
                blur: true,
              ),
            ),

            Positioned(
              bottom: -45,
              left: -40,
              child: _circle(
                size: 120,
                color: StyleRepo.green,
                blur: true,
              ),
            ),

            Positioned(
              bottom: 40,
              right: -40,
              child: _circle(
                size: 110,
                color: StyleRepo.green,
                blur: true,
              ),
            ),

            Positioned.fill(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}