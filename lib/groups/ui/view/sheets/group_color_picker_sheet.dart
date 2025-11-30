import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';

class GroupColorPickerSheet extends StatefulWidget {
  const GroupColorPickerSheet({
    required this.onChanged,
    this.initialColor,
    super.key,
  });

  final ValueChanged<int?> onChanged;
  final int? initialColor;

  @override
  State<GroupColorPickerSheet> createState() => _GroupColorPickerSheetState();
}

class _GroupColorPickerSheetState extends State<GroupColorPickerSheet> {
  double red = 1;
  double green = 1;
  double blue = 1;

  Color get currentColor =>
      Color.from(alpha: 1, red: red, green: green, blue: blue);

  @override
  void initState() {
    final initialColor = widget.initialColor;
    if (initialColor != null) {
      final color = Color(initialColor);
      red = color.r;
      green = color.g;
      blue = color.b;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return SafeArea(
      child: Padding(
        padding: const .symmetric(horizontal: AppSpacing.s),
        child: Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localization.group_color,
              style: theme.textTheme.headlineMedium,
            ),
            const Gap(AppSpacing.m),
            Container(
              height: 250,
              width: .infinity,
              decoration: BoxDecoration(
                color: currentColor,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(AppSpacing.m),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(localization.group_color_red),
                Slider(
                  padding: const .symmetric(vertical: AppSpacing.s),
                  value: red,
                  min: 0,
                  max: 1,
                  activeColor: Colors.red,
                  onChanged: (value) => setState(() => red = value),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(localization.group_color_green),
                Slider(
                  padding: const .symmetric(vertical: AppSpacing.s),
                  value: green,
                  min: 0,
                  max: 1,
                  activeColor: Colors.green,
                  onChanged: (value) => setState(() => green = value),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(localization.group_color_blue),
                Slider(
                  padding: const .symmetric(vertical: AppSpacing.s),
                  value: blue,
                  min: 0,
                  max: 1,
                  activeColor: Colors.blue,
                  onChanged: (value) => setState(() => blue = value),
                ),
              ],
            ),
            const Gap(AppSpacing.m),
            Row(
              spacing: AppSpacing.s,
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      widget.onChanged(null);
                    },
                    child: Text(
                      localization.remove_color,
                      textAlign: .end,
                    ),
                  ),
                ),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {
                      widget.onChanged(currentColor.toARGB32());
                    },
                    child: Text(
                      localization.select_color,
                      textAlign: .end,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
