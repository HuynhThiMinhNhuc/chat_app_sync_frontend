import 'package:chat_app_sync/src/app/app_config/app_constant.dart';
import 'package:chat_app_sync/src/common/network/api_provider.dart';
import 'package:chat_app_sync/src/common/network/api_response.dart';
import 'package:chat_app_sync/src/data/model/chat_room.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:flutter/rendering.dart';

class NetworkDatasource {
  final ApiProvider _apiProvider;

  NetworkDatasource(this._apiProvider);

  Future<ResponseData<Map<String, dynamic>>> login(
      String userName, String password) async {
    try {
      final params = {'username': userName, 'password': password};

      final res = await _apiProvider.get(AppConstant.login, params: params);
      return ResponseData.success(res['data'], response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }

  Future<ResponseData<List<ChatRoom>>> getRooms(int page, pageSize,
      [int? roomId]) async {
    try {
      final params = {'page': page, 'pageSize': pageSize};
      if (roomId != null) {
        params.addAll({'roomId': roomId});
      }
      final res =
          await _apiProvider.get(AppConstant.getRoomUrl, params: params);
      final roomRes = res['data']['items'] as List<dynamic>;
      final rooms = roomRes.map((json) => ChatRoom.fromJson(json as Map<String, dynamic>)).toList();
      return ResponseData.success(rooms, response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }

  Future<ResponseData<Message>> sendMessage(Message message) async {
    try {
      final res =
          await _apiProvider.post(AppConstant.sendMessageUrl, data: message.toJson());
      return ResponseData.success(Message.fromJson(res['data'] as Map<String,dynamic>), response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }

  Future<ResponseData<Map<String, dynamic>>> syncData(
      DateTime? lastTimeSync) async {
    try {
      final res =
          await _apiProvider.get(AppConstant.syncDataUrl, params: {'lastSyncData': lastTimeSync?.toIso8601String()});
      return ResponseData.success(res['data'], response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }

  Future<ResponseData> search(String content, int roomId) async {
    try {
      final params = {
        'content': content,
        'roomId': roomId,
        'limit': 20,
        'offset': 0
      };
      final res = await _apiProvider.get(AppConstant.search, params: params);
      final listMessage = Message.getListMessageFromJson(res['data'] as Map<String,dynamic>, roomId);
      return ResponseData.success(listMessage, response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }
}
