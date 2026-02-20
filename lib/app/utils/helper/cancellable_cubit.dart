import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin CancellableCubit<S> on Cubit<S> {
  CancelToken _cancelToken = CancelToken();
  CancelToken get cancelToken => _cancelToken;

  /// Call this when back button is pressed to cancel ongoing requests
  void cancelRequests() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Request cancelled by user');
      // Create a new token for future requests
      _cancelToken = CancelToken();
    }
  }

  @override
  Future<void> close() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Cubit closed');
    }
    return super.close();
  }
}
