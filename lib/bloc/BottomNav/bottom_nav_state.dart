

import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  final int currentIndex;
  const BottomNavState({required this.currentIndex});

  BottomNavState copyWith({int ? currentIndex}){
    return BottomNavState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}
