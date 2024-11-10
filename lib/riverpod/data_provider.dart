import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_state.dart';

final dataProvider = StateNotifierProvider.autoDispose<DataNotifier,
    DataState>((ref) {
  return DataNotifier();
});


class DataNotifier extends StateNotifier<DataState> {
  DataNotifier() : super(DataState()) {
    getData();
  }

  Future<void> getData() async {
    try {
      final result = await Future.delayed(
          const Duration(seconds: 2), () => List<String>.generate(20, (index) {
            return '${state.page}';
          },));
      state = state.copyWith(
        data: [...state.data,...result],
        status: StatusState.success,
        page: state.page + 1,
        isHasMoreData: state.data.length < 200,
      );
    } catch (error) {
      state = state.copyWith(
        status: StatusState.error,
        errorMessage: error.toString(),
      );
    }
  }
}
