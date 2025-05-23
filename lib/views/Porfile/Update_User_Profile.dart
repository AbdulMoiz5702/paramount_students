import 'package:flutter/material.dart';
import 'package:paramount_student/views/common/custom_textfeild.dart';
import '../../models/user_models/user_profile_model.dart';


class UpdateUserProfile extends StatefulWidget {
  final User data;
  const UpdateUserProfile({super.key,required this.data});

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomTextField(controller: controller, hintText: hintText, validate: validate),
          ],
        ),
      ),
    );
  }
}
