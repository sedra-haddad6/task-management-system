import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final Function? onRefresh;
  const EmptyWidget({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Icon(Icons.error_outline)),

        if (onRefresh != null)
          RefreshIndicator(
            onRefresh: () => onRefresh!(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height + 1,
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
          ),
      ],
    );
  }
}

class SliverEmptyWidget extends StatelessWidget {
  final void Function()? onRefresh;
  const SliverEmptyWidget({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Center(child: Icon(Icons.error_outline)),

        if (onRefresh != null)
          //TODO - translate
          ElevatedButton(onPressed: onRefresh!, child: const Text("retry")),
      ]),
    );
  }
}
