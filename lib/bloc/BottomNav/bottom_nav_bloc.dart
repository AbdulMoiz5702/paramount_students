import 'package:bloc/bloc.dart';
import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';


class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(currentIndex: 0)) {
    on<ChangeCurrentIndex>(changeCurrentIndex);
  }


  void changeCurrentIndex(ChangeCurrentIndex event ,Emitter<BottomNavState> emit){
    emit(state.copyWith(currentIndex: event.currentIndex));
  }

}
