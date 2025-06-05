import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Chats/chat_bloc.dart';
import 'package:paramount_student/bloc/Chats/chat_event.dart';
import 'package:paramount_student/core/helper_fuctions/date_formatter.dart';
import 'package:paramount_student/core/presentation/image_constant.dart';
import '../../../core/presentation/app_colors.dart';
import '../../../core/routes/routes.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/shimmer_widget.dart';
import '../../common/text_widgets.dart';


class GetAllChatsScreen extends StatelessWidget {
  const GetAllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> loadAllData(BuildContext context) async {
      context.read<ChatBloc>().add(GetAllChats());
      await Future.microtask((){
        context.read<ChatBloc>().stream.firstWhere((state) => !state.isAllChats);
      });
    }
    return FutureBuilder(
      future: loadAllData(context),
      builder: (context, snapshot) {
        final allChatState = context.watch<ChatBloc>().state;
        if (snapshot.connectionState == ConnectionState.waiting || allChatState.isAllChats == true) {
          return const ShimmerScreen(isHomeScreen: true,);
        } else if (snapshot.hasError) {
          return Center(
            child: mediumText(
                title: 'Ops ${allChatState.errorMessage}',
                textAlign: TextAlign.center
            ),
          );
        }else if(allChatState.allChats.isEmpty){
          return Center(
            child: mediumText(
                title: 'Ops No listing found',
                textAlign: TextAlign.center
            ),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Sized(height: 0.05),
                const Sized(height: 0.02),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allChatState.allChats.length,
                  itemBuilder: (context, index) {
                    final chat = allChatState.allChats[index];
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
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
