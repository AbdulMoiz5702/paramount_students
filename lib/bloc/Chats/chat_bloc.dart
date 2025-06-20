import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:paramount_student/Repositories/Chat_Repo/Chat_Repo.dart';
import 'package:paramount_student/Repositories/Pusher_Repo/pusher_repo.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import '../../models/Chat_Models/All_chat_list.dart';
import '../../models/Chat_Models/Chat_messages_model.dart';
import '../../models/Chat_Models/Send_message_model.dart';
import '../../models/Chat_Models/pusher_tigger_model.dart';
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
    final trimmedMessage = messageController.text.trim();
    final pusherTriggerMessageModel = PusherTriggerMessageModel(message: trimmedMessage, senderId: int.parse(CurrentUserSecrets.currentUserId), receiverId: event.receiverId,);
    final sendMessageRequest = SendMessageRequest(message: trimmedMessage);
    final chatFuture = ChatsRepo.sendChatsMessages(
      receiverId: event.receiverId,
      context: event.context,
      sendMessage: sendMessageRequest,
    );
    final pusherFuture = Future(() async {
      await PusherRepo.triggerEvent(data: pusherTriggerMessageModel);
    });
    await Future.wait([pusherFuture, chatFuture]);
    final response = await chatFuture;
    if (response.statusCode == 200) {
      messageController.clear();
  }}




  void onNewChatMessageReceived(NewChatMessageReceived event, Emitter<ChatState> emit) {
    final updatedMessages = List<ChatMessage>.from(state.chatMessages)..add(event.newMessage);
    emit(state.copyWith(chatMessages: updatedMessages));
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
