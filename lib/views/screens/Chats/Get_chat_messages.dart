// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Chats/chat_event.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/views/common/custom_button.dart';
import 'package:paramount_student/views/common/custom_textfeild.dart';
import '../../../bloc/Chats/chat_bloc.dart';
import '../../../core/helper_fuctions/format_validator.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/shimmer_widget.dart';
import '../../common/text_widgets.dart';



class GetChatMessagesScreen extends StatelessWidget {
  final int id;
  const GetChatMessagesScreen({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    final chatBloc =  context.read<ChatBloc>();
    Future<void> loadAllData(BuildContext context) async {
      context.read<ChatBloc>().add(GetChatsMessages(id: id));
      await Future.microtask((){
        context.read<ChatBloc>().stream.firstWhere((state) => !state.isChatsMessages);
      });
    }
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
                const Sized(height: 0.05),
            Row(
              children: [
                Expanded(child: CustomTextField(controller: chatBloc.messageController, hintText: 'type message .....', validate: (value){
                  FormValidators.validateNormalField(value, 'message must not be empty');
                })),
                TapIcon(iconData: Icons.send, onTap: (){
                  chatBloc.add(SendChatsMessages(receiverId: id, context: context));
                }),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: messagesState.chatMessages.length,
              itemBuilder: (context, index) {
                final messages = messagesState.chatMessages[index];
                final currentUserId = CurrentUserSecrets.currentUserId;
                return Align(
                  alignment: messages.senderId == currentUserId? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: messages.senderId == currentUserId ? Colors.blueAccent.withOpacity(0.8) : Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: messages.senderId == currentUserId
                            ? const Radius.circular(18)
                            : const Radius.circular(0),
                        bottomRight: messages.senderId == currentUserId
                            ? const Radius.circular(0)
                            : const Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      messages.message,
                      style: TextStyle(
                        color: messages.senderId == currentUserId ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
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
