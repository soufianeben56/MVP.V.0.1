import '../../../generated/assets.gen.dart';
import '../../../presentation/views/measurement_graph/CustomGraphViewModel.dart';

class MeasurementGraphArguments {
  final AssetGenImage? assetGenImage;
  final double? imgWidth;
  final double? imgHeight;
  final Experiment? experiment;

  MeasurementGraphArguments({
    this.assetGenImage,
    this.imgWidth,
    this.imgHeight,
    this.experiment,
  });
}
