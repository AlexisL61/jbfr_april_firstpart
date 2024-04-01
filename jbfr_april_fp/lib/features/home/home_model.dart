import 'package:flutter/material.dart';
import 'package:jbfr_april_fp/features/news/news_list_widget.dart';
import 'package:jbfr_april_fp/features/usb_key/usb_key_widget.dart';

class HomeTab {
  static List<HomeTab> availableHomeTabs = [
    HomeTab(icon: Icons.usb, page: UsbKeyWidget.new),
    HomeTab(icon: Icons.newspaper, page: NewsListWidget.new),
  ];

  final IconData icon;
  final Widget Function() page;

  HomeTab({required this.icon, required this.page});
}