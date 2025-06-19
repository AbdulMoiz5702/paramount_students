import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:paramount_student/Repositories/Chat_Repo/Chat_Repo.dart';
import '../../models/Chat_Models/All_chat_list.dart';
import '../../models/Chat_Models/Chat_messages_model.dart';
import '../../models/Chat_Models/Send_message_model.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends HydratedBloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState(isAllChats: false,allChats: [],errorMessage: '',isChatsMessages: false,chatMessages: [])) {
    on<GetAllChats>(getAllChats);
    on<GetChatsMessages>(getChatMessagesChats);
    on<SendChatsMessages>(sendChatsMessages);
    on<NewChatMessageReceived>(onNewChatMessageReceived);

  }


  TextEditingController messageController = TextEditingController();

  Future<void> getAllChats(GetAllChats event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isAllChats: true));
      final ChatListResponse responseModel = await ChatsRepo.getAllChats();
      emit(state.copyWith(allChats: responseModel.responseBody, isAllChats: false));
    } catch (error) {
      emit(state.copyWith(isAllChats: false, errorMessage: error.toString()));
    }
  }

  Future<void> getChatMessagesChats(GetChatsMessages event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isChatsMessages: true));
      final ChatMessagesResponse responseModel = await ChatsRepo.getChatsMessages(id: event.id);
      final List<ChatMessage> messages = responseModel.responseBody.data;
      emit(state.copyWith(chatMessages: messages, isChatsMessages: false,));
    } catch (error) {
      emit(state.copyWith(isChatsMessages: false, errorMessage: error.toString(),));
    }
  }

  Future<void> sendChatsMessages(SendChatsMessages event, Emitter<ChatState> emit) async {
    SendMessageRequest sendMessageRequest = SendMessageRequest(message: messageController.text.trim());
    await ChatsRepo.sendChatsMessages(receiverId: event.receiverId,context:event.context,sendMessage: sendMessageRequest).then((value){
      if(value.statusCode == 200){
        messageController.clear();
      }
    });
  }





  @override
  ChatState? fromJson(Map<String, dynamic> json) {
    try {
      return ChatState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ChatState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }

}
