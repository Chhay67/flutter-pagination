import 'package:flutter/cupertino.dart';

class ScrollNotificationHandler extends StatelessWidget {
  const ScrollNotificationHandler({super.key,required this.child,required this.loadMore,required this.isHasMore});
  final bool isHasMore;
  final Function() loadMore;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          // if (kDebugMode) {
          //   /// it show the width and height of the screen device
          //   print('height ${scrollInfo.context?.size?.height}');
          //   print('width ${scrollInfo.context?.size?.width}');
          //   print('viewportDimension ${scrollInfo.metrics.viewportDimension}');
          //   /// render the widget pixels
          //   print('pixels ${scrollInfo.metrics.pixels}');
          //   /// Infinity bec not yet set the itemCount
          //   /// maxScrollExtent is the dimension tha the end of the list
          //   print('maxScrollExtent ${scrollInfo.metrics.maxScrollExtent}');
          //   print('axisDirection ${scrollInfo.metrics.axisDirection}');
          //   print('scrollInfo $scrollInfo');
          //   print('ScrollEndNotification ${scrollInfo is ScrollEndNotification}');
          // }
          if (scrollInfo is ScrollEndNotification &&
              scrollInfo.metrics.axisDirection == AxisDirection.down &&
              scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
            if (isHasMore) {
              loadMore();
            }

          }

          return true;
        },
        child: child);
  }
}