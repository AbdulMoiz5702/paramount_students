import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/views/common/error_widgte.dart';
import 'package:paramount_student/views/common/shimmer_widget.dart';
import '../../bloc/Profile/profile_bloc.dart';
import '../../bloc/Profile/profile_event.dart';
import '../../bloc/Profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {

   Future.microtask((){
     context.read<ProfileBloc>().add(GetCurrentUser(id: int.parse(CurrentUserSecrets.currentUserId)));
   });
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.onGetUser == true) {
            return ShimmerScreen(isProfileScreen: true,);
          }else if (state.user == null){
            return ErrorRetryWidget(errorMessage: state.errorMessage, onRetry: (){});
          }else {
            final user = state.user!;
            return  Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.firstName} ${user.lastName}', style: TextStyle(fontSize: 20)),
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
