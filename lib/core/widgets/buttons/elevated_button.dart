import 'package:flutter/material.dart';

import '../../style/repo.dart';




class AppElevatedButton extends StatefulWidget {
  final Future<void> Function() onPressed;
  final Widget child;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await widget.onPressed();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      child: _isLoading
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: StyleRepo.white,
              ),
            )
          : widget.child,
    );
  }
}