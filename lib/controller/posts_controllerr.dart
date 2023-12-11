import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nmg_test/base_service/base_service.dart';
import 'package:nmg_test/model/posts_users.dart';

import '../model/posts_list.dart';
import '../utils/app_end_point.dart';

class PostController extends GetxController{

  var service = Get.put(BaseService());

  RxBool showLoader = false.obs;

  List<PostsModel> postList = [];

  PostsModel? postsModel;

  Map<String,String> authMap = {};

  @override
  void onInit() {
    getPosts();
  }

  getPosts() {
    showLoader.value = true;
    update();

    service.getRequest(EndPoints.posts).then((response) {

      List<dynamic> jsonList = response.body;

      postList = jsonList.map((json) => PostsModel.fromJson(json)).toList();
      debugPrint("postList ${postList[0].userId}");

      getUsers();

    }).onError((error, stackTrace) {
      showLoader.value = false;
      debugPrint("ErrorMsg $error \n $stackTrace");
      update();
    });
  }

  getUsers() {
    showLoader.value = true;

    service.getRequest(EndPoints.users).then((response) {

      showLoader.value = false;

      List<dynamic> jsonList = response.body;

      List<PostsUsers> postUsersList = jsonList.map((json) => PostsUsers.fromJson(json)).toList();

      /// add author id and name in map
      for (var user in postUsersList) {
        authMap[user.id.toString()]= user.name!;
      }

      debugPrint("postList ${postUsersList[0].name} ${authMap.entries}");

      update();

    }).onError((error, stackTrace) {
      showLoader.value = false;
      debugPrint("ErrorMsg $error \n $stackTrace");
      update();
    });
  }

  getPostsById({required String postId}) {
    showLoader.value = true;

    service.getRequest("${EndPoints.posts}/$postId").then((response) {

      showLoader.value = false;

      postsModel = PostsModel.fromJson(response.body);

      debugPrint("postById ${postsModel?.title}");

      update();

    }).onError((error, stackTrace) {
      showLoader.value = false;
      debugPrint("ErrorMsg $error \n $stackTrace");
      update();
    });
  }




}