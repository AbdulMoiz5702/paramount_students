import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class ChangeCurrentIndex extends BottomNavEvent {
  final int currentIndex;
  ChangeCurrentIndex({required this.currentIndex});
  @override
  List<Object> get props => [currentIndex];
}
