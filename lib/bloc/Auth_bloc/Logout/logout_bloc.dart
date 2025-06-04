import 'package:bloc/bloc.dart';
import 'package:paramount_student/Repositories/auth_repo/logout_user.dart';
import 'logout_event.dart';
import 'logout_state.dart';


class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutState(isLogout: false)) {
    on<LogoutCurrentUser>(logoutCurrentUser);
  }

  Future<void> logoutCurrentUser(LogoutCurrentUser event,Emitter<LogoutState> emit) async{
    try{
      emit(state.copyWith(isLogout: true));
      await LogoutRepo.logoutCurrentUser(context: event.context);
      emit(state.copyWith(isLogout: false));
    }catch(error){
      emit(state.copyWith(isLogout: false));
    }
  }
}
