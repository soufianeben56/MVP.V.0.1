import 'package:infinity_circuit/exports.dart';

extension NumX on double {
  EdgeInsets paddingLeft() =>
      EdgeInsets.only(left: SizeConfig.relativeWidth(this));

  EdgeInsets paddingRight() =>
      EdgeInsets.only(right: SizeConfig.relativeWidth(this));

  EdgeInsets paddingTop() => EdgeInsets.only(top: this);

  EdgeInsets paddingBottom() => EdgeInsets.only(bottom: this);

  EdgeInsets paddingAll() => EdgeInsets.all(this);

  EdgeInsets paddingVertical() => EdgeInsets.symmetric(vertical: this);

  EdgeInsets paddingHorizontal() =>
      EdgeInsets.symmetric(horizontal: SizeConfig.relativeWidth(this));

  BorderRadius circularBorder() => BorderRadius.circular(this);

  Widget get verticalBox {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget get horizontalBox {
    return SizedBox(
      width: toDouble(),
    );
  }
}
