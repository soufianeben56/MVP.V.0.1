import 'package:flutter/material.dart';
import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/presentation/views/howtouse/howtouse_view.dart';

/// A widget that makes technical terms clickable and navigates directly to
/// their explanation in the How To Use section.
class TermLinkWidget extends StatelessWidget {
  /// The technical term to be displayed and made clickable
  final String term;
  
  /// Optional text style to override the default style
  final TextStyle? style;
  
  /// Whether to show an underline to indicate this is clickable
  final bool showUnderline;
  
  /// The section ID in the How To Use page to scroll to
  final String sectionId;

  const TermLinkWidget({
    super.key,
    required this.term,
    required this.sectionId,
    this.style,
    this.showUnderline = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the How To Use page with the section ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HowToUseView(initialSectionId: sectionId),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            term,
            style: style?.copyWith(
              decoration: showUnderline ? TextDecoration.underline : null,
              color: AppColors.primaryColor,
            ) ?? 
            TextStyle(
              fontSize: SizeConfig.setSp(12),
              color: AppColors.primaryColor,
              decoration: showUnderline ? TextDecoration.underline : null,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.info_outline,
            size: SizeConfig.setSp(12),
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
} 