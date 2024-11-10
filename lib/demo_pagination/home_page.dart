import 'package:flutter/material.dart';

class HomePageDemo extends StatefulWidget {
  const HomePageDemo({super.key});

  @override
  State<HomePageDemo> createState() => _HomePageDemoState();
}

class _HomePageDemoState extends State<HomePageDemo> {

List<String> data = ['a','b','c','d','e','f','g','h','i','j' ,'k','l','m'];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('PaginationDemo'),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          //   /// it show the width and height of the screen device
          // debugPrint('height ${scrollInfo.context?.size?.height}');
          // debugPrint('width ${scrollInfo.context?.size?.width}');
          // debugPrint(
          //     'viewportDimension ${scrollInfo.metrics.viewportDimension}');
          // //   /// render the widget pixels
          // debugPrint('pixels ${scrollInfo.metrics.pixels}');
          // //   /// Infinity bec not yet set the itemCount
          // //   /// maxScrollExtent is the dimension tha the end of the list
          // //   ('maxScrollExtent ${scrollInfo.metrics.maxScrollExtent}');
          // debugPrint('axisDirection ${scrollInfo.metrics.axisDirection}');
          // debugPrint(
          //     'ScrollEndNotification ${scrollInfo is ScrollEndNotification}');
          if (scrollInfo is ScrollEndNotification &&
              scrollInfo.metrics.axisDirection == AxisDirection.down &&
              scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent) {
            /// call fetch get more data
             setState(() {
                List<String>  moreData = ['1','2','3','4','5','6','7','8','9','0'];
                data.addAll(moreData);
              });

          }

          return true;
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text('data ${data[index]}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
