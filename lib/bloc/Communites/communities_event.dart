

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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


class FollowCommunities extends CommunitiesEvent {
  final int id;
  final BuildContext context;
  FollowCommunities({required this.id,required this.context});
  @override
  List<Object> get props => [id,context];
}

class UnFollowCommunities extends CommunitiesEvent {
  final int id;
  final BuildContext context;
  UnFollowCommunities({required this.id,required this.context});
  @override
  List<Object> get props => [id,context];
}
