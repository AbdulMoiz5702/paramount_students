import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../routes/routes.dart';

class ConnectivityService {
  final Connectivity connectivity = Connectivity();
  late final StreamSubscription subscription;


  void listenForConnectionChanges(BuildContext context) {
    subscription = connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        try {
          final check = await InternetAddress.lookup('www.google.com');
          if (check.isNotEmpty && check[0].rawAddress.isNotEmpty) {
            Navigator.pushReplacementNamed(context, Routes.splash);
          }
        } catch (_) {
          debugPrint("No actual internet access yet.");
        }
      }
    });
  }


  void dispose() {
    subscription.cancel();
  }

}
