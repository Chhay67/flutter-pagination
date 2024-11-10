import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/data_cubit/data_cubit.dart';
import '../../pagination/pagination_list_view.dart';
import '../../pagination/scroll_notification_handler.dart';

class PaginationCubitDemoPage extends StatelessWidget {
  const PaginationCubitDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaginationHandler'),
        centerTitle: true,
      ),
      body: BlocBuilder<DataCubit, DataState>(
        builder: (context, state) {
          return ScrollNotificationHandler(
            loadMore: () => context.read<DataCubit>().getData(),
            isHasMore: state.isHasMoreData,
            child: Builder(builder: (context) {
              switch (state.status) {
                case StatusState.progress:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case StatusState.error:
                  return Center(
                    child: Text(state.errorMessage),
                  );
                case StatusState.success:
                  return PaginationListView(
                    hasMoreData: state.isHasMoreData,
                    itemCount: state.data.length,
                    hasError: state.status == StatusState.error,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 20),
                          child:
                              Text('page ${state.data[index]} index : $index'),
                        ),
                      );
                    },
                  );
                default:
                  return SizedBox();
              }
            }),
          );
        },
      ),
    );
  }
}
