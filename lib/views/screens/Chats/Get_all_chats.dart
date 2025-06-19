import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Chats/chat_bloc.dart';
import 'package:paramount_student/bloc/Chats/chat_event.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/shimmer_widget.dart';
import '../../common/text_widgets.dart';
import 'Widgets/all_chats_widgets.dart';


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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allChatState.allChats.length,
                  itemBuilder: (context, index) {
                    final chat = allChatState.allChats[index];
                    return AllChatsWidget(chat: chat);
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


