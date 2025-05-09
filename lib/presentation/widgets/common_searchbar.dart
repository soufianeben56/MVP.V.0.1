import 'package:infinity_circuit/exports.dart';

import '../../generated/assets.gen.dart';
class CommonSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color backgroundColor;
  final Color hintTextColor;
  final Function(String) onChanged;
  final Function() onEditingComplete;
  final Function(String) onSubmitted;
  final SvgGenImage AssetsSvgGen;

  const CommonSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.onEditingComplete,
    required this.onSubmitted,
    this.hintText = 'Suchen', // Default hint text
    this.backgroundColor = Colors.white, // Default background color
    this.hintTextColor = Colors.grey,  required this.AssetsSvgGen, // Default hint text color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0, // Minimal height for the search bar
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0), // Rounded corners for aesthetics
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.svg.icSearch.path, // Use the SVG asset as the prefix
            // Adjust height as needed
          ),
          SizedBox(width: 8.0), // Space between the icon and the text field
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onSubmitted: onSubmitted,
              style: TextStyle(
                fontSize: 16.0, // Adjust font size as needed
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: hintTextColor.withOpacity(0.60),
                ),
                border: InputBorder.none, // No border
                isDense: true, // Minimizes the height of the text field
                contentPadding: EdgeInsets.symmetric(vertical: 0), // Reduces padding for minimal height
              ),
            ),
          ),
        ],
      ),
    );
  }
}
