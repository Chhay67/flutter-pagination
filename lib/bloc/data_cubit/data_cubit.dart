import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataState()) {
    getData();
  }

  Future<void> getData() async {
    try {
      final result = await Future.delayed(
          const Duration(seconds: 2),
          () => List<String>.generate(
                10,
                (index) {
                  return '${state.page}';
                },
              ));
      emit(state.copyWith(
        data: [...state.data, ...result],
        status: StatusState.success,
        page: state.page + 1,
        isHasMoreData: state.data.length < 50,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: StatusState.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
