import 'dart:io';

import 'package:flutter/material.dart';

class CustomCachedImages extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? overlayColor;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useFade;
  final Duration fadeDuration;

  const CustomCachedImages({
    super.key,
    required this.imageUrl,
    this.radius = 16,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.overlayColor,
    this.placeholder,
    this.errorWidget,
    this.useFade = true,
    this.fadeDuration = const Duration(milliseconds: 300),
  });

  bool get _isFile => imageUrl?.startsWith('/') ?? false;

  bool get _isEmpty => imageUrl == null || imageUrl!.trim().isEmpty;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);

    Widget imageContent;

    if (_isEmpty) {
      imageContent = _fallbackImage();
    } else if (_isFile) {
      imageContent = _buildFileImage();
    } else {
      imageContent = _buildNetworkImage();
    }

    final clipped = ClipRRect(borderRadius: borderRadius, child: imageContent);

    if (useFade) {
      return AnimatedSwitcher(duration: fadeDuration, child: clipped);
    }
    return clipped;
  }

  /// Handles File image (local path)
  Widget _buildFileImage() {
    return Image.file(
      File(imageUrl!),
      width: width,
      height: height,
      fit: fit,
      color: overlayColor,
      errorBuilder: (_, _, _) => _fallbackImage(),
    );
  }

  /// Handles regular network image
  Widget _buildNetworkImage() {
    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: fit,
      color: overlayColor,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (_, _, _) => errorWidget ?? _fallbackImage(),
    );
  }

  /// Default fallback image when URL is empty or fails
  Widget _fallbackImage() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported),
    );
  }
}
