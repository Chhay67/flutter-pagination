import 'package:flutter/material.dart';

class LoadingMoreDataWidget extends StatelessWidget {
  const LoadingMoreDataWidget({
    super.key,
    this.hasError = false,
    this.hasMoreData = false,
    this.errorWidget,
    this.loadingWidget,
  });
  final bool hasError;
  final bool hasMoreData;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return errorWidget ??
          const TextButton(
            onPressed: null,
            child: Text('something when wrong!'),
          );
    }
    if (hasMoreData && hasError == false) {
      return Center(child: loadingWidget ?? const CircularProgressIndicator());
    }
    return const SizedBox.shrink();
  }
}