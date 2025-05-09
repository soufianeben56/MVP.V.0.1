import 'package:infinity_circuit/exports.dart';

import '../utils/validation_utils.dart';

extension StringX on String {
  ///Returns first letter of the string as Caps eg -> Flutter
  String firstLetterUpperCase() => length > 1
      ? this[0].toUpperCase() +
          substring(1)
              .toLowerCase() /*"${this[0].toUpperCase()}${substring(1).toLowerCase()}"*/
      : this;

  /// Return a bool if the string is null or empty
  bool get isEmptyOrNull => isEmpty;

  /// Returns the string if it is not `null`, or the empty string otherwise
  String get orEmpty => this;

  // if the string is empty perform an action
  String ifEmpty(Function action) => isEmpty ? action() : this;

  String? toPascalCase() {
    if (isNotEmpty) {
      return substring(0, 1).toUpperCase() + substring(1);
    } else {
      return this;
    }
  }

  Text withStyle({
    TextStyle? style,
    int maxLine = 1,
    TextOverflow overflow = TextOverflow.clip,
  }) {
    return Text(
      this,
      style: style,
      maxLines: maxLine,
      overflow: overflow,
    );
  }

  withNormalFont(
    BuildContext context, {
    Color color = Colors.black,
  }) {
    return Text(
      this,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color),
    );
  }

  Text text(
    BuildContext context, {
    Color color = Colors.black,
    TextStyle? textStyle,
    TextOverflow overflow = TextOverflow.clip,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      this,
      style: textStyle ??
          Theme.of(context).textTheme.titleLarge!.copyWith(color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  subText(
    BuildContext context, {
    Color color = Colors.black54,
  }) {
    return Text(
      this,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: color),
    );
  }

  withSmallFont(
    BuildContext context, {
    Color color = Colors.black54,
  }) {
    return Text(
      this,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: color),
    );
  }

  String toUTFValue(int hex) {
    List<int> chars = List.generate(length, (index) => 0);
    for (int i = 0; i < length; i++) {
      if (codeUnitAt(i) >= 0x0030 && codeUnitAt(i) <= 0x0039) {
        chars[i] = hex + (codeUnitAt(i) - '0'.codeUnitAt(0));
      } else {
        chars[i] = codeUnitAt(i);
      }
    }
    return String.fromCharCodes(chars);
  }

  bool validatePassword() =>
      RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[/!@$&\\]).{8,}$")
          .hasMatch(this);

  String getFileNameFromUrl() {
    Uri uri = Uri.parse(this);
    return uri.pathSegments.last;
  }

  bool isValidUrl() {
    return RegExp(RegexPattern.url).hasMatch(this);
  }
}
