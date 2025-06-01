import 'package:equatable/equatable.dart';
import 'package:paramount_student/models/Communities_models/Communities_model.dart';

import '../../models/Communities_models/Single_communit_response.dart';

class CommunitiesState extends Equatable {
  final bool isAllCommunities;
  final List<CommunityModel> allCommunities;
  final SingleCommunityResponseModel ? singleCommunities;
  final String errorMessage;
  final bool isSingleCommunities;

  const CommunitiesState({
    required this.isAllCommunities,
    required this.allCommunities,
    required this.errorMessage,
    required this.isSingleCommunities,
    required this.singleCommunities,
  });

  CommunitiesState copyWith({
    bool? isAllCommunities,
    List<CommunityModel>? allCommunities,
    String? errorMessage,
    bool ? isSingleCommunities,
    SingleCommunityResponseModel ? singleCommunities
  }) {
    return CommunitiesState(
        isAllCommunities: isAllCommunities ?? this.isAllCommunities,
        allCommunities: allCommunities ?? this.allCommunities,
        isSingleCommunities: isSingleCommunities ?? this.isSingleCommunities,
        errorMessage: errorMessage ?? this.errorMessage,
        singleCommunities: singleCommunities ?? this.singleCommunities
    );
  }

  @override
  List<Object?> get props => [isAllCommunities,allCommunities,errorMessage,isSingleCommunities,singleCommunities];
}


extension CommunitiesStateExtension on CommunitiesState {
  List<CommunityModel> get allEventsModels => allCommunities;
}


