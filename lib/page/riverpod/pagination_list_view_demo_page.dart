import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pagination/pagination_list_view.dart';
import '../../pagination/scroll_notification_handler.dart';
import '../../riverpod/data_provider.dart';
import '../../riverpod/data_state.dart';

class PaginationListViewDemoPage extends ConsumerWidget {
  const PaginationListViewDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataState = ref.watch(dataProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('PaginationHandler'),
        centerTitle: true,
      ),
      body: ScrollNotificationHandler(
        loadMore: () => ref.read(dataProvider.notifier).getData(),
        isHasMore: dataState.isHasMoreData,
        child: Builder(
          builder: (context) {
            switch(dataState.status){
              case StatusState.progress : return const Center(child: CircularProgressIndicator(),);
              case StatusState.error : return Center(child: Text(dataState.errorMessage),);
              case StatusState.success : return PaginationListView(
                hasMoreData: dataState.isHasMoreData,
                itemCount: dataState.data.length,
                hasError: dataState.status == StatusState.error,
                
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                      child: Text('page ${dataState.data[index]} index : $index'),
                    ),
                  );
                },
              );
              default :return const SizedBox();
            }
          }
        ),
      ),
    );
  }
}
