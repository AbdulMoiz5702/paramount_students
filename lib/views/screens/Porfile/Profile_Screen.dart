import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/core/presentation/app_colors.dart';
import 'package:paramount_student/views/common/custom_button.dart';
import 'package:paramount_student/views/common/error_widgte.dart';
import 'package:paramount_student/views/common/shimmer_widget.dart';

import '../../../bloc/Profile/profile_bloc.dart';
import '../../../bloc/Profile/profile_event.dart';
import '../../../bloc/Profile/profile_state.dart';
import '../../../core/routes/routes.dart';






class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      context.read<ProfileBloc>().add(GetCurrentUser(id: int.parse(CurrentUserSecrets.currentUserId)),
      );
    });
    return Scaffold(
      appBar: AppBar(title: Text("User Profile"),actions: [
        TapIcon(color: AppColor.purpleColor,size: 40,iconData: Icons.edit, onTap: (){
          final data = context.read<ProfileBloc>().state;
          Navigator.pushNamed(context, Routes.updateProfileScreen,arguments: {'data':data.user});
        }),
      ],),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.onGetUser == true) {
            return ShimmerScreen(isProfileScreen: true);
          } else if (state.user == null) {
            return ErrorRetryWidget(
              errorMessage: state.errorMessage,
              onRetry: () {},
            );
          } else {
            final user = state.user!;
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    buildWhen: (pre, current) => pre.image != current.image,
                    builder: (context, state) {
                      if (state.image != null) {
                        return GestureDetector(
                          onTap: () {
                            context.read<ProfileBloc>().add(PickUserProfilePic(context: context),);
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: FileImage(state.image!),
                          ),
                        );
                      } else if (user.profilePicture != null) {
                        return GestureDetector(
                          onTap: () {
                            context.read<ProfileBloc>().add(
                              PickUserProfilePic(context: context),
                            );
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(user.profilePicture!),
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 40,
                          child: TapIcon(
                            iconData: Icons.person,
                            size: 35,
                            onTap: () {
                              context.read<ProfileBloc>().add(
                                PickUserProfilePic(context: context),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Name: ${user.firstName} ${user.lastName}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  Text('Email: ${user.email}'),
                  SizedBox(height: 8),
                  Text('Gender: ${user.gender}'),
                  // Add more fields as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
