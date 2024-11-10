
import 'package:flutter/cupertino.dart';

import 'loading_more_data_widget.dart';

class PaginationSliverListView extends StatelessWidget {
  const PaginationSliverListView({
    super.key,
    required this.hasMoreData,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.emptyWidget,
    this.errorWidget,
    this.loadingWidget,
    this.hasError = false,
  });

  final int itemCount;
  final bool hasMoreData;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final bool hasError;
  @override
  Widget build(BuildContext context) {
    if (itemCount <= 0) {
      return emptyWidget ?? const SizedBox.shrink();
    }
    return SliverList.separated(
      separatorBuilder:
      separatorBuilder ?? (context, index) => const SizedBox.shrink(),
      itemCount: itemCount + 1,
      itemBuilder: (context, index) {
        if (index == itemCount) {
          return LoadingMoreDataWidget(
            hasMoreData: hasMoreData,
            hasError: hasError,
            errorWidget: errorWidget,
            loadingWidget: loadingWidget,
          );
        }
        return itemBuilder(context, index);
      },
    );
  }
}