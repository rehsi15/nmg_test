import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nmg_test/common_widget/app_bar.dart';
import 'package:nmg_test/controller/posts_controllerr.dart';
import 'package:nmg_test/view/posts_details.dart';

class PostsList extends StatelessWidget {
  PostsList({super.key});

  PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(title: 'Post List',),
          body: GetBuilder<PostController>(builder: (controller) {
         return (controller.showLoader.isTrue)?
         const  Center(child: CircularProgressIndicator()):
         ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.postList.length,
            separatorBuilder: (context, index) => const Divider(color: Colors.grey,), // Separator between items
            itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){

              /// navigate to second screen using id
              Get.to(PostDetails(postId:controller.postList[index].id?.toString()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("userId: ${controller.postList[index].userId?.toString() ?? ""}"),
                Text("id: ${controller.postList[index].id?.toString() ?? ""}"),
                Text("title: ${controller.postList[index].title ?? ""}"),
                Text("Author: ${controller.authMap[controller.postList[index].userId.toString()]}"),
                Text("body: ${controller.postList[index].body ?? ""}"),
              ],
            ),
          );
        }).paddingOnly(top: 20);
      })),
    );
  }
}
