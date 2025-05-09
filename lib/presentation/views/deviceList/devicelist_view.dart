import 'package:infinity_circuit/exports.dart';
import 'package:infinity_circuit/generated/assets.gen.dart';
import 'package:infinity_circuit/service/routing/arguments/device_list_arguments.dart';
import 'package:lottie/lottie.dart';

import 'devicelist_viewmodel.dart';

class DeviceListView extends StatelessWidget {
  final List<DeviceListArguments> devicesList;

  const DeviceListView({super.key, required this.devicesList});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeviceListViewModel>.reactive(
      viewModelBuilder: () => DeviceListViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.colorF4F4F4,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                icon: Assets.svg.icBackArrow.svg(
                  // Left back arrow icon
                  width: SizeConfig.relativeWidth(10.13),
                  height: SizeConfig.relativeHeight(4.68),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            centerTitle: true, // Center the title
            title: Text(
              'Geräteliste', // Replace with your title
              style: TextStyle(
                fontSize: 22,
                color: AppColors.color212121, // Title color
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Assets.svg.icBack.svg(
                    // Right back arrow icon
                    width: SizeConfig.relativeWidth(10.13),
                    height: SizeConfig.relativeHeight(4.68),
                  ),
                  onPressed: () {
                    model.onTapRefreshScan();
                  },
                ),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: CentralLoader(
              centralViewState: model.viewState,
              baseChild: _getBody(context, model),
            ),
          ),
        );
      },
      onViewModelReady: (viewModel) => viewModel.onInit(),
    );
  }

  Widget _getBody(BuildContext context, DeviceListViewModel model) {
    final devices = model.isFromRefresh ? model.deviceList : devicesList;

    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: devices.isEmpty
          ? _emptyDeviceListPlaceholder() // Show placeholder if list is empty
          : Column(
              children: [
                SizedBox(height: SizeConfig.relativeHeight(3.57)),
                Expanded(
                  child: ListView.separated(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];

                      return homeContainers(
                        name: device.title,
                        id: device.deviceId,
                        svgGenImage: Assets.svg.icConnect1,
                        onTap: () {
                          UserPreference.putString(
                              PrefKeys.deviceId, device.deviceId);
                          model.connectAndDiscoverServices(device.deviceId);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: SizeConfig.relativeHeight(1.48));
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _emptyDeviceListPlaceholder() {
    return Center(
      child: Lottie.asset(
        Assets.lotties.bluetoothJson
            .path, // Use the path to your Lottie JSON file
        height: SizeConfig.relativeHeight(16.87),
        width: SizeConfig.relativeHeight(36.53),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget homeContainers({
    required String name,
    required String id,
    required SvgGenImage svgGenImage,
    Function()? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.relativeHeight(1.48),
          horizontal: SizeConfig.relativeWidth(4.00)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black.withOpacity(0.3), width: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextWidget(
                  text: name,
                  color: AppColors.color212121,
                  fontSize: SizeConfig.setSp(16),
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  width: 200,
                  child: CommonTextWidget(
                    text: id,
                    color: AppColors.color212121.withOpacity(0.60),
                    fontSize: SizeConfig.setSp(12),
                  ),
                ),
              ],
            ),
          ),
          // Spacer(),
          svgGenImage.svg().wrapPadding(padding: EdgeInsets.only(right: 10)),
          CommonAppButton(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(3.33),
                vertical: SizeConfig.relativeHeight(0.74)),
            onTap: onTap ?? () {},
            title: "Verbinden",
            normalFontSize: SizeConfig.setSp(12),
            width: null,
          ),
        ],
      ),
    ).wrapPadding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.relativeWidth(5.87),
      ),
    );
  }
}

class DeviceListModel {
  final String id;
  final String name;
  //final int connectivity;
  final SvgGenImage svgGenImage;
  final double height;
  final double width;

  DeviceListModel(
      this.id, this.name, this.svgGenImage, this.height, this.width);
}
