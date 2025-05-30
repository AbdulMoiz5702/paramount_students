

import 'package:equatable/equatable.dart';

abstract class CommunitiesEvent  extends Equatable{
  @override
  List<Object> get props => [];
}


class GetAllCommunities extends CommunitiesEvent {}

class GetSingleCommunities extends CommunitiesEvent {
  final int id;
  GetSingleCommunities({required this.id});
  @override
  List<Object> get props => [id];
}
