import 'package:bestiary/ui/ext.dart';
import 'package:bestiary/ui/wrappers/frozen_galss.dart';
import 'package:flutter/material.dart';

class AssetImageButton extends StatelessWidget {
  const AssetImageButton({
    super.key,
    required this.title,
    this.onTap,
    this.assetImage = "assets/images/oni.png",
  });

  static double get _height => 80.0;

  final String title;
  final String assetImage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(
            height: _height,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(const Color.fromARGB(255, 167, 145, 131), BlendMode.overlay),
                  image: AssetImage(assetImage),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          Positioned.fill(
            child: FrozenGalss(
              child: Center(
                child: Text(
                  title,
                  style: context.theme.font.subtitle.copyWith(
                    color: context.theme.color.fg.cover.active,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
