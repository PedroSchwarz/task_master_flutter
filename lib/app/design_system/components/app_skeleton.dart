import 'package:flutter/material.dart';

class AppSkeleton extends StatefulWidget {
  const AppSkeleton({required this.isLoading, required this.child, super.key});

  final bool isLoading;
  final Widget child;

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ShimmerPainter(animationValue: _controller.value),
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.transparent)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  const _ShimmerPainter({required this.animationValue});

  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    final shimmerWidth = size.width * 0.5;
    final shimmerPosition = animationValue * (size.width + shimmerWidth) - shimmerWidth;

    final gradient = LinearGradient(
      colors: [baseColor, highlightColor, baseColor],
      stops: const [0.3, 0.5, 0.7],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      transform: _SlidingGradientTransform(translationX: shimmerPosition),
    );

    final paint = Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final rrect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12));

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_ShimmerPainter oldDelegate) => oldDelegate.animationValue != animationValue;
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.translationX});

  final double translationX;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(translationX, 0.0, 0.0);
  }
}
