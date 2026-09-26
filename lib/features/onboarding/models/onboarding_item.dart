import 'package:flutter/material.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final String tag;
  final String imageAsset;
  final IconData icon;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.imageAsset,
    required this.icon,
  });
}
