import 'package:kyo_base/imports/base_component_import.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Author: Kyo Huu
/// Create date: 7/28/2020
///
/// This module provide a Dio instance to all the Service that's needed it
/// It will also contain the base url and all other Dio option
///

class DioModule extends DisposableInterface {
  DioModule({
    required this.baseUrl,
    required this.showLog,
  });

  Dio? _dio;

  final String baseUrl;
  final bool showLog;

  Dio get dio {
    if (_dio != null) {
      return _dio!;
    }

    logger.i('**** Dio create');
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 11000,
      receiveTimeout: 11000,
      sendTimeout: 11000,
    );
    // Get Data for mobile on server
    options.headers["device"] = 'mobile';

    _dio = Dio(options);

    if (showLog) {
      _dio!.interceptors.add(PrettyDioLogger(
        request: false,
        requestHeader: false,
        requestBody: true,
        responseBody: false,
      ));
    }

    // Check token
    // final storage = Get.find<UserSecureStorage>();
    // if (storage.user != null) {
    //   addToken(storage.user!.token);
    // }

    addTokenInterceptor();

    return _dio!;
  }

  // TODO Add token to Interceptor
  void addTokenInterceptor() {
    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        logger.i('interceptor 401');

        // final storage = Get.find<UserSecureStorage>();
        // storage.unAuthorized.value = true;
      }

      return handler.next(error);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }));
  }

  void addToken(String? token) {
    if (token == null) return;
    logger.i('DioModule.addToken => $token');

    dio.options.headers["Authorization"] = 'Bearer $token';
  }

  void removeToken() {
    logger.i('DioModule.removeToken =>');
    dio.options.headers["Authorization"] = null;
  }

  @override
  void onClose() {
    logger.i('**** Dio clear');
    //dio.clear();
  }
}
