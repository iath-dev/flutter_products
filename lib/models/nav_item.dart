import 'package:flutter/material.dart';

class NavItem {
  final String route;
  final Widget screen;
  final IconData icon;
  final String label;

  NavItem(
      {required this.route,
      required this.screen,
      required this.icon,
      required this.label});
}
