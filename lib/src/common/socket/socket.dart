import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final _socket = IO.io(AppConstant.baseUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
    'connect_timeout': 210,
  });

  SocketService() {
    // socket.connect();
    log('Socket is created');
    _socket.onConnect((data) {
      log('Socket connected');
    });
    _socket.onReconnect((data) {
      log('Socket is reconnect');
    });
    _socket.onDisconnect((data) {
      log('Socket disconnected');
    });
    _socket.onConnectError((error) {
      log('Connect error');
      log(error.toString());
    });
    _socket.onError((error) {
      log('Socket is error');
      log(error.toString());
    });
    _socket.on('messageSent', (data) {
      log('Receive message');
      log(data.toString());
    });
  }

  void connect() {
    log("Socket connect");
    _socket.connect();
    addEventReconnect((data) async {
      _socket.emit('reconnect', () => AppManager().getUserToken());
    });
  }

  void disconnect() {
    log("Socket disconnect");
    _socket.clearListeners();
    _socket.disconnect();
  }

  void close() {
    _socket.close();
  }

  void emitLogin(String token) {
    log("Socket login");
    _socket.emit('login', <String, dynamic>{'token': token});
  }

  void emit(String nameEvent, [dynamic data]) {
    log("Socket emit ${nameEvent}");
    _socket.emit(nameEvent, data);
  }

  void addEventListener(String nameEvent, dynamic Function(dynamic) callback) {
    log('Socket event listener added: ' + nameEvent);
    _socket.on(nameEvent, callback);
  }

  void addEventReconnect(dynamic Function(dynamic) callback) =>
      _socket.onReconnect(callback);

  void removeEventListener(String nameEvent,
      [dynamic Function(dynamic)? handler]) {
    log('Socket event listener ' + nameEvent + ' is remove');
    _socket.off(nameEvent, handler);
  }
}
