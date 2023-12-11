import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{

  final String? title;
  final VoidCallback? onBackPress;

  const CommonAppBar({Key? key,required this.title,this.onBackPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: true,
      leading: IconButton(
        onPressed: onBackPress ?? (){Get.back();},
        icon:const Icon(Icons.arrow_back,color: Colors.white,)
        //replace with our own icon data.
      ),
      titleSpacing: 5,
      title: Text(title ?? ""),
      titleTextStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
