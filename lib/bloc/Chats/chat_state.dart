import 'package:equatable/equatable.dart';

import '../../models/Chat_Models/All_chat_list.dart';

class  ChatState extends Equatable{
  final bool isAllChats;
  final List<ChatMessage> allChats;
  final String errorMessage;
  const ChatState({required this.isAllChats,required this.allChats,required this.errorMessage});

  ChatState copyWith ({bool ? isAllChats,List<ChatMessage> ? allChats,String ? errorMessage}){
    return ChatState(isAllChats: isAllChats ?? this.isAllChats,allChats: allChats ?? this.allChats,errorMessage: errorMessage ?? this.errorMessage);
  }


  @override
  List<Object?> get props => [isAllChats,allChats,errorMessage];

  Map<String, dynamic> toJson() => {
    'isAllChats': isAllChats,
    'allChats': allChats.map((e) => e.toJson()).toList(),
    'errorMessage': errorMessage,
  };

  factory ChatState.fromJson(Map<String, dynamic> json) => ChatState(
    isAllChats: json['isAllChats'] ?? false,
    allChats: (json['allChats'] as List<dynamic>?)?.map((e) => ChatMessage.fromJson(e)).toList() ?? [],
    errorMessage: json['errorMessage'] ?? '',
  );

}

extension ChatStateExtension on ChatState {
  List<ChatMessage> get allChatsModels => allChats;
}

