import 'package:infinity_circuit/exports.dart';
import '../../../generated/assets.gen.dart';

class SolutionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onTapLeading;
  final Function()? onTapAction;
  final String title;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottomWidget;
  final SvgGenImage? actionIcon;
  final Function()? onTapBleAction;

  const SolutionAppBar({
    super.key,
    this.onTapLeading,
    this.onTapAction,
    required this.title,
    this.backgroundColor = AppColors.primaryBackGroundColor,
    this.bottomWidget,
    this.actionIcon,
    this.onTapBleAction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      toolbarHeight: kToolbarHeight,
      backgroundColor: backgroundColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      leading: _buildLeadingIcon(context),
      title: _buildTitle(),
      centerTitle: true,
      actions: [
        if (onTapBleAction != null)
          _buildCircularIcon(
            icon: Assets.svg.icImage111,
            onTap: onTapBleAction,
            iconColor: AppColors.primaryColor,
          ),
        _buildCircularIcon(
          icon: actionIcon ?? Assets.svg.icSol,
          onTap: onTapAction ?? () {},
        ),
      ],
      bottom: bottomWidget,
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    return Assets.svg.icBackArrow
        .svg(
      width: SizeConfig.relativeWidth(10.13),
      height: SizeConfig.relativeHeight(4.68),
    )
        .wrapPadding(
      padding: EdgeInsets.only(
        left: SizeConfig.relativeWidth(4.80),
        top: SizeConfig.relativeHeight(1.48),
        bottom: SizeConfig.relativeHeight(0.62),
      ),
    )
        .addGestureTap(
      onTap: onTapLeading ?? () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildCircularIcon({
    required SvgGenImage icon, 
    required Function()? onTap, 
    Color iconColor = AppColors.color212121,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: SizeConfig.relativeWidth(4.0),
          top: SizeConfig.relativeHeight(1.48),
          bottom: SizeConfig.relativeHeight(0.62),
        ),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: icon.svg(
          width: SizeConfig.relativeWidth(6.0),
          height: SizeConfig.relativeHeight(3.5),
          color: iconColor,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return CommonTextWidget(
      text: title,
      fontSize: SizeConfig.setSp(18),
      fontWeight: FontWeight.w600,
      color: AppColors.color212121,
      textAlign: TextAlign.center,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, SizeConfig.relativeHeight(6.40));
}
