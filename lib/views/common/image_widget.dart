import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/presentation/app_colors.dart';


class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final File? imageFile;
  ///[svgPath] is required parameter for showing svg image
 final  String? svgPath;
 final double svgWidth;
 final double svgHeight;
 final bool isImageColor;
 final Color iconColor;


  final BoxFit fit;
  const ImageWidget({
    super.key,
    this.svgPath,
    this.imageUrl,
    this.assetPath,
    this.imageFile,
    this.svgHeight = 0.1,
    this.iconColor = AppColor.whiteColor,
    this.svgWidth = 0.1,
    this.fit = BoxFit.fill,
    this.isImageColor = false
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: fit,
        placeholder: (context, url) => const Center(
          child: Icon(
            Icons.image,
            color: Colors.grey,
            size: 40,
          ),
        ),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      );
    }
   else  if (svgPath != null && svgPath!.isNotEmpty) {
      return SvgPicture.asset(
        svgPath!,
        height: MediaQuery.of(context).size.height*svgHeight,
        width: MediaQuery.of(context).size.width*svgWidth,
        fit: fit ?? BoxFit.contain,
        // color: color,
      );
    }
    else if (assetPath != null && assetPath!.isNotEmpty) {
      return Image.asset(
        assetPath!,
        fit: fit,
        color: isImageColor ? iconColor : null,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      color: AppColor.secondaryColor,
      alignment: Alignment.center,
      child: const Icon(
        Icons.error_outline,
        color: AppColor.blackColor,
        size: 40,
      ),
    );
  }
}

