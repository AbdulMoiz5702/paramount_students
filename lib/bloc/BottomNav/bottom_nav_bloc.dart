import 'package:bloc/bloc.dart';
import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';


class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitial()) {
    on<BottomNavEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
