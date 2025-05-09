import 'package:infinity_circuit/extentions/double_ext.dart';
import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget wrapContainer({
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color color = Colors.transparent,
  }) {
    return Container(
      padding: padding,
      margin: margin,
      color: color,
      child: this,
    );
  }

  Widget wrapCenter() {
    return Center(
      child: this,
    );
  }

  Widget wrapPadding({
    EdgeInsets padding = const EdgeInsets.all(0),
  }) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget addGestureTap({required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }

  Widget wrapPaddingAll({
    double padding = 0,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget wrapPaddingHorizontal({
    double padding = 0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }

  Widget wrapPaddingVertical({double padding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: this,
    );
  }

  Widget wrapPaddingSymmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  Widget clipRectAll(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: this,
    );
  }

  Widget clipRectCustom(BorderRadius radius) {
    return ClipRRect(
      borderRadius: radius,
      child: this,
    );
  }

  addMarginRight(double margin) {
    return Padding(
      padding: margin.paddingRight(),
      child: this,
    );
  }

  addMarginLeft(double margin) {
    return Padding(
      padding: margin.paddingLeft(),
      child: this,
    );
  }

  addMarginVertical(double margin) {
    return Padding(
      padding: margin.paddingVertical(),
      child: this,
    );
  }

  addMarginHorizontal(double margin) {
    return Container(
      padding: margin.paddingHorizontal(),
      child: this,
    );
  }

  Widget expand({int flex =1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget flexible({int flex = 1, FlexFit flexFit = FlexFit.loose}) {
    return Flexible(
      flex: flex,
      fit: flexFit,
      child: this,
    );
  }

  Widget visibility(bool visible) {
    return Visibility(
      visible: visible,
      child: this,
    );
  }

  Widget offstage(bool visible) {
    return Offstage(
      offstage: visible,
      child: this,
    );
  }

  /// Widget to show exception
  Widget errorWidget(Object ex) => ErrorWidget(ex);
}
