import 'package:infinity_circuit/exports.dart';

class CommonDropDown extends StatelessWidget {
  final Function() onTap;
  final String title;
  final BoxDecoration? boxDecoration;
  final bool isNormalText;
  final Color? normalTextColor;
  final double? normalFontSize;
  final double? width;
  final double? height;
  final double? radius;
  final double? iconSize;
  final Color? iconColor;
  final String? dropdownValue;
  final List<String>? dropdownList;
  final Function(String)? onChanged;

  const CommonDropDown({
    super.key,
    required this.onTap,
    required this.title,
    this.boxDecoration,
    this.isNormalText = true,
    this.normalTextColor = AppColors.white,
    this.normalFontSize = 16,
    this.width,
    this.height,
    this.radius,
    this.iconSize,
    this.iconColor,
    this.dropdownValue,
    this.dropdownList,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: SizeConfig.relativeHeight(height ?? 6.66),
        width: SizeConfig.relativeWidth(width ?? 87.47),
        padding: EdgeInsets.only(
          right: SizeConfig.relativeWidth(3.47),
          left: SizeConfig.relativeWidth(3.47),
          // bottom: SizeConfig.relativeHeight(1.97),
          // top: SizeConfig.relativeHeight(1.97),
        ),
        decoration: boxDecoration ??
            BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(radius ?? 15),
              border: Border.all(
                width: 1,
                color: AppColors.textFieldBorder,
              ),
            ),
        alignment: Alignment.center,
        child: DropdownButton(
          // Initial Value
          value: dropdownValue,
          hint: CommonTextWidget(
            text: title,
            fontSize: 16,
            color: Colors.black38,
          ),
          borderRadius: BorderRadius.circular(13),

          // Down Arrow Icon
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.primaryColor,
            size: SizeConfig.relativeSize(17),
          ),

          isExpanded: true,

          // Array list of items
          items: dropdownList!.map((String items) {
            return DropdownMenuItem<String>(
              value: items,
              child: CommonTextWidget(
                text: items,
                fontSize: 16,
                color:
                    items != "none" ? AppColors.primaryColor : Colors.black38,
              ),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (value) => onChanged!(value!),
          underline: const SizedBox(
            height: 0,
            width: 0,
          ),
        ),
      ),
    );
  }
}
