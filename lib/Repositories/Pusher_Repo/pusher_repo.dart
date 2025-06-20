import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:paramount_student/core/exceptions/net_work_excptions.dart';
import 'package:paramount_student/core/services/Network_services/pusher_credentials.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherRepo {

   static  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

    static Future<void> initPusher({required Function(dynamic message) onMessageReceived,required BuildContext context}) async {
    try {
      await pusher.init(
        apiKey:  PusherCredentials.key,
        cluster: PusherCredentials.cluster,

        onConnectionStateChange: (currentState, previousState) {
          debugPrint("Connection changed from $previousState to $currentState");
        },
        onError: (message, code, exception) {
          debugPrint("Error: $message, Code: $code, Exception: $exception");
        },
        onSubscriptionSucceeded: (channelName, data) {
          debugPrint("Subscribed to $channelName successfully with data: $data");
        },
        onEvent: (event) {
          debugPrint("Event received: ${event.eventName}, Data: ${event.data}");
        },
        onSubscriptionError: (message, exception) {
          debugPrint("Subscription error: $message, Exception: $exception");
        },
        onDecryptionFailure: (event, reason) {
          debugPrint("Decryption failure: $event, Reason: $reason");
        },
        onMemberAdded: (channelName, member) {
          debugPrint("Member added to $channelName: ${member.userId}");
        },
        onMemberRemoved: (channelName, member) {
          debugPrint("Member removed $channelName: ${member.userId}");
        },
      );

      await pusher.subscribe(
        channelName: PusherCredentials.channelName,
          onEvent: (event) {
            debugPrint("Pusher Event received: ${event.eventName}, Data: ${event.data}");
            try {
              if (event.data is String) {
                debugPrint("🔍 Raw String Data: ${event.data}");
                final decoded = jsonDecode(event.data!);
                debugPrint("✅ Decoded JSON: $decoded");
                onMessageReceived(decoded as Map<String, dynamic>);
              } else if (event.data is Map) {
                debugPrint("✅ Event data is already a Map");
                final safeMap = (event.data as Map).cast<String, dynamic>();
                onMessageReceived(safeMap);
              }
            } catch (e) {
              debugPrint('❌ Error decoding Pusher message: $e');
            }
          }
      );
      await pusher.connect();
    } catch (error,s) {
      ExceptionHandler.handle(error, context);
      debugPrint("Pusher init error: $error $s");
    }
  }


}