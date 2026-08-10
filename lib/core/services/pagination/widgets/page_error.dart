import 'package:flutter/material.dart';

class PageError extends StatelessWidget {
  final Function() retry;
  final String error;
  const PageError({
    super.key,
    required this.retry,
    //TODO - translate
    this.error = 'Some Error',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: [
          Text(error),
          //TODO - translate
          ElevatedButton(onPressed: retry, child: Text("retry")),
        ],
      ),
    );
  }
}
