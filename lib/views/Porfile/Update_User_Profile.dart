import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/Repositories/Profile_repo/profile_repo.dart';
import 'package:paramount_student/bloc/Profile/profile_bloc.dart';
import 'package:paramount_student/bloc/Profile/profile_event.dart';
import 'package:paramount_student/bloc/Profile/profile_state.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:paramount_student/core/helper_fuctions/format_validator.dart';
import 'package:paramount_student/core/presentation/image_constant.dart';
import 'package:paramount_student/views/common/custom_button.dart';
import 'package:paramount_student/views/common/custom_loading.dart';
import 'package:paramount_student/views/common/custom_sizedBox.dart';
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
  void initState() {
    super.initState();
    ProfileRepo.initializeControllersData(user: widget.data, context: context);
  }

  @override
  Widget build(BuildContext context) {
    var bloc =  context.read<ProfileBloc>();
    final key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              Sized(height: 0.05,),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(controller: bloc.firstNameController, hintText: 'First Name', validate: (value){
                      return FormValidators.validateNormalField(value, 'First Name');
                    }),
                  ),
                  Sized(width: 0.02,),
                  Expanded(
                    child: CustomTextField(controller: bloc.lastNameController, hintText: 'Last Name', validate: (value){
                      return FormValidators.validateNormalField(value, 'Last Name');
                    }),
                  ),
                ],
              ),
              CustomTextField(controller: bloc.lastNameController, hintText: 'Last Name', validate: (value){
                return FormValidators.validateNormalField(value, 'Last Name');
              }),
              Sized(height: 0.02,),
              CustomTextField(controller: bloc.courseOfStudyController, hintText: 'Course', validate: (value){
                return FormValidators.validateNormalField(value, 'Course');
              }),
              Sized(height: 0.02,),
              CustomTextField(controller: bloc.countryController, hintText: 'Country', validate: (value){
                return FormValidators.validateNormalField(value, 'Country');
              }),
              Sized(height: 0.02,),
              BlocBuilder<ProfileBloc,ProfileState>(
                buildWhen: (pre,current) => pre.isUserUpdate != current.isUserUpdate,
                  builder: (context ,state){
                  return state.isUserUpdate == true ? CustomLoading(imagePath: ImageConstant.ic_loading_animation) : CustomButton(title: 'Update', onTap: (){
                    context.read<ProfileBloc>().add(UpdateCurrentUser(id: int.parse(CurrentUserSecrets.currentUserId), context: context));
                  });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
