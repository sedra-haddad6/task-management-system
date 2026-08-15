import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'obs.dart';
import 'variable_status.dart';

class ObsBuilder<T> extends StatelessWidget {
  final Obs<T> obs;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context, String error) errorBuilder;
  final Widget Function(BuildContext context) loadingBuilder;

  const ObsBuilder({
    super.key,
    required this.obs,
    required this.builder,
    required this.errorBuilder,
    required this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (obs.status == VariableStatus.loading) {
        return loadingBuilder(context);
      } else if (obs.status == VariableStatus.hasError) {
        return errorBuilder(context, obs.error!);
      } else {
        return builder(context, obs.data!);
      }
    });
  }
}