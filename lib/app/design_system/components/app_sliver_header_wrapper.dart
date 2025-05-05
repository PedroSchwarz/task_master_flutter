import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';

class AppSliverHeaderWrapper extends StatelessWidget {
  const AppSliverHeaderWrapper.floating({required this.child, this.padding = AppSpacing.s, this.backgroundColor, super.key})
    : floating = true,
      pinned = false;

  const AppSliverHeaderWrapper.pinned({required this.child, this.padding = AppSpacing.s, this.backgroundColor, super.key})
    : floating = false,
      pinned = true;

  final Widget child;
  final double padding;
  final Color? backgroundColor;

  final bool floating;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: floating,
      pinned: pinned,
      delegate: _AppPersistentHeaderDelegate(
        child: DecoratedBox(decoration: const BoxDecoration(), child: Padding(padding: EdgeInsets.all(padding), child: child)),
      ),
    );
  }
}

class _AppPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _AppPersistentHeaderDelegate({required this.child});

  final Widget child;

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
}
