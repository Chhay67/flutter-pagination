import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataState()) {
    on<GetDataEvent>(_getData);
  }
  Future<void> _getData(GetDataEvent event, Emitter<DataState> emit) async {
    try {
      final result = await Future.delayed(
          Duration(seconds: 2),
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
