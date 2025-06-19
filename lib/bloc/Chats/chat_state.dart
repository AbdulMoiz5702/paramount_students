import 'package:equatable/equatable.dart';

import '../../models/Chat_Models/All_chat_list.dart';
import '../../models/Chat_Models/Chat_messages_model.dart';

class  ChatState extends Equatable{
  final bool isAllChats;
  final bool isChatsMessages;
  final List<ChatMessageBody> allChats;
  final List<ChatMessage> chatMessages;
  final String errorMessage;
  const ChatState({required this.isAllChats,required this.allChats,required this.errorMessage,required this.isChatsMessages,required this.chatMessages});

  ChatState copyWith ({bool ? isAllChats,List<ChatMessageBody> ? allChats,String ? errorMessage,bool ? isChatsMessages,List<ChatMessage> ? chatMessages}){
    return ChatState(isAllChats: isAllChats ?? this.isAllChats,allChats: allChats ?? this.allChats,errorMessage: errorMessage ?? this.errorMessage,isChatsMessages: isChatsMessages ?? this.isChatsMessages,chatMessages: chatMessages ?? this.chatMessages);
  }


  @override
  List<Object?> get props => [isAllChats,allChats,errorMessage,isChatsMessages,chatMessages];

  Map<String, dynamic> toJson() => {
    'isAllChats': isAllChats,
    'isChatsMessages':isChatsMessages,
    'chatMessages':chatMessages.map((e) => e.toJson()).toList(),
    'allChats': allChats.map((e) => e.toJson()).toList(),
    'errorMessage': errorMessage,

  };

  factory ChatState.fromJson(Map<String, dynamic> json) => ChatState(
    isAllChats: json['isAllChats'] ?? false,
    isChatsMessages: json['isChatsMessages'] ?? false,
    chatMessages: (json['chatMessages'] as List<dynamic>?)?.map((e) => ChatMessage.fromJson(e)).toList() ?? [],
    allChats: (json['allChats'] as List<dynamic>?)?.map((e) => ChatMessageBody.fromJson(e)).toList() ?? [],
    errorMessage: json['errorMessage'] ?? '',
  );

}

extension ChatStateExtension on ChatState {
  List<ChatMessageBody> get allChatsModels => allChats;
}

extension ChatMessagesStateExtension on ChatState {
  List<ChatMessage> get allChatsMessagesModels => chatMessages;
}

