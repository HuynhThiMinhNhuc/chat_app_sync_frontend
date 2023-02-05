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

  Future<ResponseData<ChatRoom>> getRooms(int roomId) async {
    try {
      final res = await _apiProvider
          .get(AppConstant.getRoomUrl, params: {'roomId': roomId});
      return ResponseData.success(ChatRoom.fromJson(res['data']),
          response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }

  Future<ResponseData<Message>> sendMessage(Map<String, dynamic> params) async {
    try {
      final res =
          await _apiProvider.post(AppConstant.sendMessageUrl, data: params);
      return ResponseData.success(Message.fromJson(res['data']), response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }

  Future<ResponseData<Map<String, dynamic>>> syncData(
      Map<String, dynamic> params) async {
    try {
      final res =
          await _apiProvider.get(AppConstant.getMessageUrl, params: params);
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
      final res = await _apiProvider.post(AppConstant.search, params: params);
      final listMessage = Message.getListMessageFromJson(res['data'] as List);
      return ResponseData.success(listMessage, response: res);
    } catch (e) {
      return ResponseData.failed(e);
    }
  }
}
