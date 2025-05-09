import 'package:infinity_circuit/exports.dart';
import '../../generated/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onTapLeading, onTapAction;
  final Widget? leadingWidget;
  final String title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool showLeading, showAction;
  final String? actionIconPath;
  final PreferredSizeWidget? bottomWidget;

  const CustomAppBar({
    super.key,
    this.onTapLeading,
    this.leadingWidget,
    required this.title,
    this.actions,
    this.backgroundColor = AppColors.primaryBackGroundColor,
    this.showLeading = true,
    this.showAction = true,
    this.onTapAction,
    this.actionIconPath,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight,
      backgroundColor: backgroundColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      leading: showLeading
          ? leadingWidget ??
          Assets.svg.icBackArrow
              .svg(
              width: SizeConfig.relativeWidth(10.13),
              height: SizeConfig.relativeHeight(4.68))
              .wrapPadding(
              padding: EdgeInsets.only(
                  left: SizeConfig.relativeWidth(4.80),
                  top: SizeConfig.relativeHeight(1.48),
                  bottom: SizeConfig.relativeHeight(0.62)))
              .addGestureTap(
              onTap: onTapLeading ??
                      () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  })
          : Offstage(),
      title: CommonTextWidget(
        text: title,
        fontSize: SizeConfig.setSp(18),
        fontWeight: FontWeight.w600,
        color: AppColors.color212121,
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      actions: showAction
          ? actions ??
          [
            GestureDetector(
              onTap: onTapAction ??
                      () {
                    Navigator.of(context).pushNamed(RoutePaths.newScanDeviceViewRoute);
                  },
              child: (actionIconPath != null
                  ? SvgPicture.asset(
                actionIconPath!,
                width: SizeConfig.relativeWidth(10.13),
                height: SizeConfig.relativeHeight(4.68),
              )
                  : Assets.svg.icDisconnectWhite.svg(
                width: SizeConfig.relativeWidth(10.13),
                height: SizeConfig.relativeHeight(4.68),
              )
              ).wrapPadding(
                padding: const EdgeInsets.only(right: 18, top: 12, bottom: 5),
              ),
            ),
          ]
          : actions,
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize =>
      Size(double.infinity, SizeConfig.relativeHeight(6.40));
}
