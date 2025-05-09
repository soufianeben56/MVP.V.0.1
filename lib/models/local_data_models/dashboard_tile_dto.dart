import 'package:flutter/material.dart';

class DashboardTileDTO{
  int? id;
  String? label;
  Widget? icon;
  String? routeName;
  DashboardTileDTO({this.id,this.label, this.icon,this.routeName});
}