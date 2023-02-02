import 'package:chat_app_sync/src/app/app_manager.dart';
import 'package:chat_app_sync/src/data/model/message.dart';
import 'package:chat_app_sync/src/data/model/user.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final searchKey = ''.obs;
  final result = <Message>[].obs;

  @override
  void onInit() {
    final argument = Get.arguments;
    if (argument is String && argument.isNotEmpty) {
      searchKey.value = argument;
      getResultSearch();

      //TODO: remove after test
      result.value = [
        Message(
            id: 1,
            localId: 1,
            content: 'How are you',
            createdAt: DateTime.now(),
            sender: User(id: 1, userName: 'Minh Nhuc', imageUri: null),
            roomId: 2)
      ];
    }
    super.onInit();
  }

  getResultSearch() async {
    //TODO: get result search depend on search_key
  }

  onNavigateToChatRoomSearchResult() {
    //TODO: navigate to chat room
  }
}
