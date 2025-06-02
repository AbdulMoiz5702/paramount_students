import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paramount_student/bloc/Communites/communities_state.dart';
import 'package:paramount_student/core/helper_fuctions/current_access_token.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/Communites/communities_bloc.dart';
import '../../../bloc/Communites/communities_event.dart';
import '../../../core/presentation/app_colors.dart';
import '../../../models/Communities_models/Single_communit_response.dart';
import '../../common/shimmer_widget.dart';
import '../../common/text_widgets.dart';

class CommunitiesDetailScreen extends StatelessWidget {
  final int id;
  const CommunitiesDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Future<void> loadAllData(BuildContext context) async {
      context.read<CommunitiesBloc>().add(GetSingleCommunities(id: id));
      await Future.wait([
        context.read<CommunitiesBloc>().stream.firstWhere(
          (state) => !state.isSingleCommunities,
        ),
      ]);
    }

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: loadAllData(context),
        builder: (context, snapshot) {
          final communitiesState = context.watch<CommunitiesBloc>().state;
          if (snapshot.connectionState == ConnectionState.waiting ||
              communitiesState.isSingleCommunities == true) {
            return const ShimmerScreen(isUserListing: true);
          } else if (snapshot.hasError) {
            return Center(
              child: mediumText(
                title: 'Ops ${communitiesState.errorMessage}',
                textAlign: TextAlign.center,
              ),
            );
          } else if (communitiesState.singleCommunities != null) {
            final data = communitiesState.singleCommunities!;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          data.coverPhotoUrl ?? '',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: Icon(Icons.broken_image, size: 60),
                              ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        bottom: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 5),
                                ],
                              ),
                            ),
                            Text(
                              '${data.city}, ${data.country}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  Center(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(data.logoUrl ?? ''),
                      onBackgroundImageError:
                          (_, __) => Icon(Icons.person, size: 40),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Follow and Like buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<CommunitiesBloc, CommunitiesState>(
                        buildWhen: (pre,current)=> pre.followCommunities != current.followCommunities,
                        builder: (context, state) {
                          return ElevatedButton.icon(
                            onPressed: () {
                              final List<Follower> followers = communitiesState.singleCommunities?.followers ?? [];
                              final bool isFollowing = followers.any((follower) => follower.id == CurrentUserSecrets.currentUserId,);
                              if (isFollowing) {
                                context.read<CommunitiesBloc>().add(FollowCommunities(id: id, context: context));
                              } else {
                                context.read<CommunitiesBloc>().add(FollowCommunities(id: id, context: context));
                              }
                            },
                            icon: Icon(Icons.person_add_alt),
                            label: Text("Follow"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          // TODO: Like logic
                        },
                        icon: Icon(Icons.favorite_border),
                        color: Colors.red,
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Divider(),

                  Text(data.description ?? '', style: TextStyle(fontSize: 14)),

                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.people, color: AppColor.accentColor, size: 18),
                      SizedBox(width: 6),
                      Text('${data.numberOfFollowers} followers'),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Interests:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children:
                        data.interests.map((interest) {
                          return Chip(
                            label: Text(interest.name),
                            backgroundColor: AppColor.lightGrey,
                          );
                        }).toList(),
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Socials:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      if (data.instagramLink.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.camera_alt_outlined),
                          onPressed:
                              () => launchUrl(Uri.parse(data.instagramLink)),
                        ),
                      if (data.tiktokLink.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.music_note_outlined),
                          onPressed:
                              () => launchUrl(Uri.parse(data.tiktokLink!)),
                        ),
                      if (data.youtubeLink.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.play_circle_outline),
                          onPressed:
                              () => launchUrl(Uri.parse(data.youtubeLink)),
                        ),
                    ],
                  ),

                  SizedBox(height: 20),
                  if (data.galleries.isNotEmpty) ...[
                    Text(
                      'Gallery:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.galleries.length,
                        separatorBuilder: (_, __) => SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              data.galleries[index],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.broken_image),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  SizedBox(height: 20),
                  if (data.moderators.isNotEmpty) ...[
                    Text(
                      'Moderators:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...List.generate(data.moderators.length, (index) {
                      final mod = data.moderators[index];
                      return Text('- ${mod.name}');
                    }),
                    SizedBox(height: 15),
                  ],

                  if (data.announcements.isNotEmpty) ...[
                    Text(
                      'Announcements:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...List.generate(data.announcements.length, (index) {
                      final a = data.announcements[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(a.title),
                        subtitle: Text(a.description),
                      );
                    }),
                  ],
                ],
              ),
            );
          } else {
            return Center(
              child: mediumText(
                title: 'Ops No Data found',
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
