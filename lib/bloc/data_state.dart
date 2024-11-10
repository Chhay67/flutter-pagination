part of 'data_bloc.dart';

enum StatusState {
  initial,
  progress,
  success,
  error,
}

class DataState {
  DataState({
    this.status = StatusState.progress,
    this.data = const [],
    this.page = 1,
    this.errorMessage = 'something went wrong!',
    this.isHasMoreData = false,
  });


  final StatusState status;
  final List<String> data;
  final int page;
  final String errorMessage;

  final bool isHasMoreData;

  DataState copyWith({
    StatusState? status,
    List<String>? data,
    String? errorMessage,
    int? page,
    bool? isHasMoreData,
  }){
    return DataState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      isHasMoreData: isHasMoreData ?? this.isHasMoreData,
    );
  }

}