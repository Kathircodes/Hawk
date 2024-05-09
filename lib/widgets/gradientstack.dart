import 'package:flutter/material.dart';

/// It applies/stacks multiple layers of gradient behind the child element
class GradientStack extends StatelessWidget {
  final List<Gradient> gradients;
  final Widget? child;
  const GradientStack({
    super.key,
    required this.gradients,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return gradients.isNotEmpty ? getGradients(0) : child ?? Container();
  }

  Widget getGradients(int index) {
    return Container(
      decoration: BoxDecoration(gradient: gradients[index]),
      child: gradients.length - index > 1 ? getGradients(++index) : child,
    );
  }
}
