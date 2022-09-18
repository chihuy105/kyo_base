import 'package:kyo_base/imports/base_component_import.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

/// Note that .connect() should not be called if autoConnect: true (by default, it's enabled to true)
class SocketIOService {
  SocketIOService({required String socketUrl}){
    _socketUrl = socketUrl;
    socket = IO.io(
      socketUrl,
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
      // .setExtraHeaders({'token': Get.find<UserSecureStorage>().token})
          .enableReconnection()
          .setReconnectionAttempts(1000)
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(10000)
          .build(),
    );
  }

  late final String _socketUrl;
  late final IO.Socket socket;

  void init() {
    socket.onConnect((_) {
      logger.i('Socket-onConnect');
      logger.i('socket.id ${socket.id}');
    });
    socket.onDisconnect((_) {
      logger.e('Socket-onDisconnect');
    });
    socket.onError((e) {
      logger.e('Socket-onError: $e');
    });
    socket.onAny((string, data) {
      if (data != 'disconnect') { // TODO temporary ignore this until server fix it
        logger.i('Socket-any: $string \nData: $data');
      }
    });
    socket.onConnectError((e) {
      logger.i('Socket-onConnectError $e');
    });
  }

  void setToken({required String token}) {
    logger.i('setToken socket $token');
    socket.io.options['extraHeaders'] = {'token': token};
    socket.io..disconnect()..connect();
  }

  void clearToken() {
    socket.io.options['extraHeaders'] = {'token': ''};
    socket.io..disconnect()..connect();
  }

  void close() {
    socket.dispose();
  }

  void emit({required String event, required String data}) {
    socket.emit(event, data);
  }

  // void listen(String key, Function(NotificationModel notification) onChange) {
  //   socket.on(key, (notifyData) {
  //     try {
  //       var notification = NotificationModel.fromJson(notifyData);
  //       onChange(notification);
  //     } catch (e) {
  //       logger.e(e);
  //     }
  //   });
  // }

  // void listenData(String key,
  //     Function(NotificationModel notification, Map? data) onChange) {
  //   socket.on(key, (notifyData) {
  //     NotificationModel? notification;
  //     Map? data;
  //     try {
  //       if (notifyData is Map<String, dynamic>) {
  //         notification = NotificationModel.fromJson(notifyData);
  //         final notificationData = notification.data;
  //         if (notificationData is Map) {
  //           data = notificationData;
  //         } else if (notificationData != null) {
  //           data = notificationData.isNullOrEmpty() == true
  //               ? json.decode(notificationData.toString())
  //               : null;
  //         }
  //       }
  //     } catch (e) {
  //       logger.e(e);
  //     }
  //     if (notification != null && data != null) {
  //       onChange(notification, data);
  //     }
  //
  //   });
  // }
}
