
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/data_bloc.dart';
import '../../pagination/pagination_list_view.dart';
import '../../pagination/scroll_notification_handler.dart';

class PaginationBlocDemoPage extends StatefulWidget {
  const PaginationBlocDemoPage({super.key});

  @override
  State<PaginationBlocDemoPage> createState() => _PaginationBlocDemoPageState();
}

class _PaginationBlocDemoPageState extends State<PaginationBlocDemoPage> {

  @override
  void initState() {
    context.read<DataBloc>().add(GetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isHasMoreData = context.select<DataBloc,bool>((value) => value.state.isHasMoreData);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaginationHandler'),
        centerTitle: true,
      ),
      body: ScrollNotificationHandler(
        loadMore: () => context.read<DataBloc>().add(GetDataEvent()),
        isHasMore: isHasMoreData,
        child: BlocBuilder<DataBloc, DataState>(builder: (context,state) {
          switch (state.status) {
            case StatusState.progress:
              return const Center(
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
      ));
  }
}
