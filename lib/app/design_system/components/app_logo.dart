import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({this.color, this.size, super.key});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SvgPicture.asset(
      'assets/logo.svg',
      height: size,
      width: size,
      colorFilter: ColorFilter.mode(color ?? theme.colorScheme.primary, BlendMode.srcIn),
    );
  }
}
