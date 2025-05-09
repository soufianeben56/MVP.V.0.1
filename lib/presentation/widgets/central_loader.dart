import 'package:infinity_circuit/exports.dart';

import '../../generated/assets.gen.dart';

class CentralLoader extends StatelessWidget {
  final Widget baseChild;
  final CentralViewState? centralViewState;

  const CentralLoader({
    super.key,
    required this.baseChild,
    this.centralViewState,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        baseChild,
        if (centralViewState == CentralViewState.busy) ...[
          Container(
            color: Colors.white54,
            child: Center(
              child: Assets.lotties.loading.lottie(
                height: SizeConfig.relativeHeight(20),
                width: SizeConfig.relativeHeight(20),
              ),
            ),
          )
        ]
      ],
    ).addGestureTap(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
