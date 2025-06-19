import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper_fuctions/date_formatter.dart';
import '../../../../core/presentation/app_colors.dart';
import '../../../../core/presentation/image_constant.dart';
import '../../../../core/routes/routes.dart';
import '../../../../models/Chat_Models/All_chat_list.dart';
import '../../../common/text_widgets.dart';

class AllChatsWidget extends StatelessWidget {
  const AllChatsWidget({super.key, required this.chat,});
  final ChatMessageBody chat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, Routes.getChatMessages, arguments: {'id': chat.receiverId},);
        },
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: AppColor.lightprimaryColor,
          backgroundImage: chat.chatPartner.profilePicture != null
              ? NetworkImage(chat.chatPartner.profilePicture!)
              : const AssetImage(ImageConstant.ic_user_logo) as ImageProvider,
        ),
        title: mediumText(title: chat.chatPartner.name,),
        subtitle: regularText(
          title: chat.message,
          maxLines: 1,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            lightText(title:DateHelperFunctions.timeAgo(chat.createdAt.toString()),),
            if (chat.isRead == 0)
              const Icon(
                Icons.mark_chat_unread,
                color: AppColor.secondaryColor,
                size: 18,
              )
          ],
        ),
        tileColor: AppColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}