import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/presentation/app_colors.dart';
import 'custom_sizedBox.dart';


class ShimmerScreen extends StatelessWidget {
  final bool isHomeScreen;
  final bool isProfileScreen;
  final bool isSeeAllAndCategory;
  final bool isUserListing;

  const ShimmerScreen({
    this.isHomeScreen = false,
    this.isProfileScreen = false,
    this.isSeeAllAndCategory = false,
    this.isUserListing = false,
    super.key,
  });

  Widget _buildShimmerBox({
    double height = 100,
    double margin = 8.0,
    double width = double.infinity,
    BorderRadius? borderRadius,
    bool isProfileScreen = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.disableColor,
        shape: isProfileScreen ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isProfileScreen == true ? null : (borderRadius ?? BorderRadius.circular(15)),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        baseColor: AppColor.lightprimaryColor,
        highlightColor: AppColor.lightGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // See All And Category shimmer layout
            if (isSeeAllAndCategory == true) ...[
              const Sized(height: 0.01),
              _buildShimmerBox(height: 70,),
              const Sized(height: 0.01),
              _buildShimmerBox(height: 30,width: MediaQuery.sizeOf(context).width * 0.2),
              const Sized(height: 0.005),
              _buildShimmerBox(height: 10,width: MediaQuery.sizeOf(context).width * 0.32),
              const Sized(height: 0.02),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (_, __) => _buildShimmerBox(height: 120,),
              ),
            ],

            // user listings shimmer layout
            if (isUserListing == true) ...[
              const Sized(height: 0.01),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (_, __) => _buildShimmerBox(height: 120),
              ),
            ],

            // Home screen shimmer layout
            if (isHomeScreen == true) ...[
              const Sized(height: 0.05),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 1,
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (_, __) => Container(
                    width: 70,
                    height: 100,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.disableColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const Sized(height: 0.01),
              _buildShimmerBox(height: 20,width: MediaQuery.sizeOf(context).width * 0.3),
              const Sized(height: 0.01),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 1,
                height: MediaQuery.sizeOf(context).height * 0.28,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (_, __) => Container(
                    height: MediaQuery.sizeOf(context).height * 0.28,
                    width: MediaQuery.sizeOf(context).width * 0.45,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: AppColor.disableColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const Sized(height: 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShimmerBox(height: 20,width: MediaQuery.sizeOf(context).width * 0.3,margin: 0.0),
                  _buildShimmerBox(height: 20,width: MediaQuery.sizeOf(context).width * 0.1,margin: 0.0),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (_, __) => _buildShimmerBox(height: 120,),
              ),
            ],

            // Profile screen shimmer layout
            if (isProfileScreen == true) ...[
              const Sized(height: 0.05),
              _buildShimmerBox(height: 160,isProfileScreen: true), // Profile background
              const Sized(height: 0.02),
              _buildShimmerBox(height: 100), // FollowStatsCard
              const Sized(height: 0.02),
              for (int i = 0; i < 4; i++)
                _buildShimmerBox(height: 40), // Settings tiles
            ],
          ],
        ),
      ),
    );
  }
}

