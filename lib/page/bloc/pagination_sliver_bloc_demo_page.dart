


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/data_bloc.dart';
import '../../pagination/pagination_sliver_list_view.dart';
import '../../pagination/scroll_notification_handler.dart';

class PaginationSliverBlocDemoPage extends StatefulWidget {
  const PaginationSliverBlocDemoPage({super.key});

  @override
  State<PaginationSliverBlocDemoPage> createState() => _PaginationSliverBlocDemoPageState();
}

class _PaginationSliverBlocDemoPageState extends State<PaginationSliverBlocDemoPage> {


  @override
  void initState() {
   context.read<DataBloc>().add(GetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isHasMoreData = context.select<DataBloc,bool>((value) => value.state.isHasMoreData);
    return Scaffold(
      body: ScrollNotificationHandler(

        loadMore: () => context.read<DataBloc>().add(GetDataEvent()),
        isHasMore: isHasMoreData,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('PaginationHandler'),
              floating: true,
              centerTitle: true,
            ),
            const SliverToBoxAdapter(
              child: Card(
                color: Colors.greenAccent,
                child: SizedBox(
                  height: 200,

                ),
              ),
            ),
            BlocBuilder<DataBloc,DataState>(builder: (context, state) {
              switch(state.status){
                case StatusState.progress : return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),));
                case StatusState.error : return SliverToBoxAdapter(child: Center(child: Text(state.errorMessage),));
                case StatusState.success : return PaginationSliverListView(
                  hasMoreData: state.isHasMoreData,
                  itemCount: state.data.length,
                  hasError: state.status == StatusState.error,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                        child: Text('page ${state.data[index]}'),
                      ),
                    );
                  },
                );
                default :return SliverToBoxAdapter(child: SizedBox());
              }
            },)
          ],
        ),
      ),
    );
  }
}
