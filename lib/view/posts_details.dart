import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:nmg_test/common_widget/app_bar.dart';
import 'package:nmg_test/controller/posts_controllerr.dart';

class PostDetails extends StatelessWidget {

  PostController controller = Get.find<PostController>();

  String? postId;
  
  PostDetails({super.key,this.postId}){
    controller.getPostsById(postId: postId ?? "1");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const CommonAppBar(title: 'Post Detail',),
          body: GetBuilder<PostController>(builder: (controller) {
            return (controller.showLoader.isTrue)?
            const Center( child: CircularProgressIndicator()):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("userId: ${controller.postsModel?.userId.toString() ?? ""}"),
                Text("id: ${controller.postsModel?.id.toString() ?? ""}"),
                Text("title: ${controller.postsModel?.title.toString() ?? ""}"),
                Text("body: ${controller.postsModel?.body.toString() ?? ""}"),
              ],
            ).paddingSymmetric(horizontal: 10,vertical: 20);
          })),
    );
  }
}
