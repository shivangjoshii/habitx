import 'package:flutter/material.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final String highlight;
  final IconData icon;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.highlight,
    required this.icon,
  });
}
