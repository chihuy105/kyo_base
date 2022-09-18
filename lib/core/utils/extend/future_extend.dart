import 'package:retry/retry.dart';

import 'package:kyo_base/imports/base_component_import.dart';

bool _isCanRetry(DioError err) {
  return (err.type == DioErrorType.response ||
          err.type == DioErrorType.connectTimeout ||
          err.type == DioErrorType.sendTimeout ||
          err.type == DioErrorType.receiveTimeout) &&
      err.error != null &&
      (err.error is SocketException || err.error is TimeoutException);
}

extension FutureExtendRequestApi<T> on Future<T?> {
  Future<T> retryRequest({
    int retryTime = 3,
    Duration delayFactor = const Duration(milliseconds: 200),
    Duration maxDelay = const Duration(seconds: 30),
  }) async {
    // ignore: prefer_typing_uninitialized_variables
    var  a;
    await retry(
        () async {
          // print('retry: ok loop');
          await then((value) {
            // print('retry value: $value');
            a = Future.value(value as T);
          });
        },
        maxAttempts: retryTime,
        delayFactor: delayFactor,
        maxDelay: maxDelay,
        // Retry on SocketException or TimeoutException
        retryIf: (e) {
          // print('retry: ok retryIf');
          if (e is DioError) {
            logger.i('retry: start');
            return _isCanRetry(e);
          }
          return false;
        });
    return a;
  }
}
