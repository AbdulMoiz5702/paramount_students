// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Chats/chat_event.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/views/common/custom_button.dart';
import 'package:paramount_student/views/common/custom_textfeild.dart';
import '../../../Repositories/Pusher_Repo/pusher_repo.dart';
import '../../../bloc/Chats/chat_bloc.dart';
import '../../../core/helper_fuctions/format_validator.dart';
import '../../../models/Chat_Models/Chat_messages_model.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/shimmer_widget.dart';
import '../../common/text_widgets.dart';
import 'Widgets/chat_bubble_widget.dart';



class GetChatMessagesScreen extends StatelessWidget {
  final int id;
  const GetChatMessagesScreen({super.key,required this.id});
  @override
  Widget build(BuildContext context) {
    final chatBloc =  context.read<ChatBloc>();

    return FutureBuilder(
      future: loadAllData(context),
      builder: (context, snapshot) {
        final messagesState = context.watch<ChatBloc>().state;
        if (snapshot.connectionState == ConnectionState.waiting || messagesState.isAllChats == true) {
          return const ShimmerScreen(isHomeScreen: true,);
        } else if (snapshot.hasError) {
          return Center(
            child: mediumText(
                title: 'Ops ${messagesState.errorMessage}',
                textAlign: TextAlign.center
            ),
          );
        }else if(messagesState.allChats.isEmpty){
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
                const Sized(height: 0.02),
                ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: messagesState.chatMessages.length,
              itemBuilder: (context, index) {
                final messages = messagesState.chatMessages[index];
                final currentUserId = CurrentUserSecrets.currentUserId;
                return ChatBubbleWidget(messages: messages, currentUserId: currentUserId);
              },
            ),
                const Sized(height: 0.02),
                Row(
                  children: [
                    Expanded(child: CustomTextField(controller: chatBloc.messageController, hintText: 'type message .....', validate: (value){
                      return FormValidators.validateNormalField(value, 'message must not be empty');
                    })),
                    TapIcon(iconData: Icons.send, onTap: (){
                      chatBloc.add(SendChatsMessages(receiverId: id, context: context));
                    }),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

// Future<void> loadAllData(BuildContext context) async {
//   context.read<ChatBloc>().add(GetChatsMessages(id: id));
//   await Future.microtask((){
//     context.read<ChatBloc>().stream.firstWhere((state) => !state.isChatsMessages);
//   });
// }



