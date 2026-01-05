import 'package:flutter/material.dart';

class PokemonHeader extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final double? spacingTitles;
  final Widget superimposedImage;
  final BorderRadius borderRadius;
  const PokemonHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.superimposedImage,
    this.spacingTitles,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.25,
              decoration: BoxDecoration(color: Color.fromRGBO(211, 10, 64, 1), borderRadius: borderRadius),
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  SizedBox(height: spacingTitles),
                  subtitle,
                ],
              ),
            ),
          ],
        ),

        superimposedImage,
      ],
    );
  }
}
