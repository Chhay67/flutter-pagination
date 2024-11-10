import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pagination/pagination_sliver_list_view.dart';
import '../../pagination/scroll_notification_handler.dart';
import '../../riverpod/data_provider.dart';
import '../../riverpod/data_state.dart';

class PaginationHandlerDemo extends ConsumerStatefulWidget {
  const PaginationHandlerDemo({super.key});

  @override
  ConsumerState createState() => _PaginationHandlerDemoState();
}

class _PaginationHandlerDemoState extends ConsumerState<PaginationHandlerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        
        body: ScrollNotificationHandler(
          loadMore: () => ref.read(dataProvider.notifier).getData(),
          isHasMore: ref.watch(dataProvider).isHasMoreData,
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('PaginationHandler'),
                floating: true,
                centerTitle: true,
              ),
              /// summary 1
              const SliverToBoxAdapter(
                child: Card(
                  color: Colors.greenAccent,
                  child: SizedBox(
                    height: 200,
                    child: Center(child: Text('Summary 1')),
                  ),
                ),
              ),
              /// summary 2
              const SliverToBoxAdapter(
                child: Card(
                  color: Colors.grey,
                  child: SizedBox(
                    height: 200,
                    child: Center(child: Text('Summary 2')),
                  ),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final dataState = ref.watch(dataProvider);
                  switch(dataState.status){
                    case StatusState.progress : return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),));
                    case StatusState.error : return SliverToBoxAdapter(child: Center(child: Text(dataState.errorMessage),));
                    case StatusState.success : return PaginationSliverListView(
                      hasMoreData: ref.watch(dataProvider).isHasMoreData,
                      itemCount: dataState.data.length,
                      hasError: dataState.status == StatusState.error,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                            child: Text('page ${dataState.data[index]}'),
                          ),
                        );
                      },
                    );
                    default :return const SliverToBoxAdapter(child: SizedBox());
                  }

                },
              ),
              // PaginationSliverListView(
              //   hasMoreData: true,
              //   itemCount: data.length,
              //   hasError: false,
              //   itemBuilder: (context, index) {
              //     return Card(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8)),
              //       margin: const EdgeInsets.symmetric(vertical: 8),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              //         child: Text('data ${data[index]}'),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ));
  }
}

