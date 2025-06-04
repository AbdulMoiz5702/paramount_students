import 'package:flutter/cupertino.dart';
import 'package:paramount_student/core/presentation/app_colors.dart';
import 'package:paramount_student/views/screens/Chats/Get_all_chats.dart';
import 'package:paramount_student/views/screens/home/Home_screen.dart';
import '../../views/screens/Porfile/Profile_Screen.dart';

List<Widget> screens = [
  HomeScreen(),
  Container(color: AppColor.backgroundColor,),
  GetAllChatsScreen(),
  ProfileScreen(),
];