import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/views/common/custom_sizedBox.dart';
import 'package:paramount_student/views/common/shimmer_widget.dart';
import 'package:paramount_student/views/common/text_widgets.dart';
import '../../../bloc/Communites/communities_bloc.dart';
import '../../../bloc/Communites/communities_event.dart';
import '../../../bloc/Events/events_bloc.dart';
import '../../../bloc/Events/events_event.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future<void> loadAllData(BuildContext context) async {
      context.read<EventsBloc>().add(GetAllEvents());
      context.read<CommunitiesBloc>().add(GetAllCommunities());
      await Future.wait([
        context.read<EventsBloc>().stream.firstWhere((state) => !state.isAllEvents),
        context.read<CommunitiesBloc>().stream.firstWhere((state) => !state.isAllCommunities),
      ]);
    }
    return FutureBuilder(
      future: loadAllData(context),
      builder: (context, snapshot) {
        final eventsState = context.watch<EventsBloc>().state;
        final communitiesState = context.watch<CommunitiesBloc>().state;
        if (snapshot.connectionState == ConnectionState.waiting || eventsState.isAllEvents == true  || communitiesState.isAllCommunities == true ) {
          return const ShimmerScreen(isHomeScreen: true,);
        } else if (eventsState.errorMessage.isNotEmpty || communitiesState.errorMessage.isNotEmpty) {
          return Center(
            child: mediumText(
              title: 'Ops ${eventsState.errorMessage.isNotEmpty ? eventsState.errorMessage : communitiesState.errorMessage}',
              textAlign: TextAlign.center
            ),
          );
        }else if(eventsState.allEvents.isEmpty && communitiesState.allCommunities.isEmpty){
          return Center(
            child: mediumText(
                title: 'Ops No listing found',
                textAlign: TextAlign.center
            ),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Sized(height: 0.05),
                mediumText(title: 'Communities', textAlign: TextAlign.center),
                const Sized(height: 0.02),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    children: List.generate(
                      communitiesState.allCommunities.length, (index) {
                        final community = communitiesState.allCommunities[index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              lightText(title: community.name),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Sized(height: 0.05),
                mediumText(title: 'Events', textAlign: TextAlign.center),
                const Sized(height: 0.02),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: eventsState.allEvents.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 3, // width / height → square (1:1)
                  ),
                  itemBuilder: (context, index) {
                    final event = eventsState.allEvents[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          mediumText(title:  event.eventName,),
                          const Sized(height: 0.01),
                          lightText(title:  event.eventDate.toString(),),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

