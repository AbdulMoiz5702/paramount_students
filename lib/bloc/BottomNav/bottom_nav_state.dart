

import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  final int currentIndex;
  const BottomNavState({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}
