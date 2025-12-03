import 'dart:async';

import 'package:flutter/material.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({
    required this.focusNode,
    required this.onChanged,
    required this.hintText,
    this.prefixIcon,
    this.textInputAction = .done,
    this.debounceDuration,
    this.hasClearButton = true,
    super.key,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final String hintText;
  final IconData? prefixIcon;
  final TextInputAction textInputAction;
  final Duration? debounceDuration;
  final bool hasClearButton;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  Timer? _debounceTimer;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      onChanged: (value) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(
          widget.debounceDuration ?? const Duration(milliseconds: 500),
          () {
            widget.onChanged(value);
          },
        );
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.hasClearButton
            ? IconButton(
                onPressed: () {
                  _controller.clear();
                  widget.onChanged('');
                },
                icon: const Icon(Icons.clear),
              )
            : null,
      ),
      textInputAction: .done,
      textCapitalization: .sentences,
    );
  }
}
