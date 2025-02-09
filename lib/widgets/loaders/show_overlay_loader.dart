import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shah_investment/constants/colors.dart';

showOverlayLoader(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // CustomLoaderOverlayManager.showOverlay(context);
    return Loader.show(
      context,
      progressIndicator: const SpinKitPulsingGrid(
        color: PickColors.primaryColor,
      ),
    );
  });
}

hideOverlayLoader() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // CustomLoaderOverlayManager.hideOverlay();
    return Loader.hide();
  });
}

// class CustomLoaderOverlayWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black54,
//       child: Center(
//         child: SpinKitPulsingGrid(
//           color: PickColors.primaryColor,
//         ),
//       ),
//     );
//   }
// }

// class CustomLoaderOverlayManager {
//   static OverlayEntry? _overlayEntry;

//   static void showOverlay(BuildContext context) {
//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 0,
//         left: 0,
//         right: 0,
//         bottom: 0,
//         child: CustomLoaderOverlayWidget(),
//       ),
//     );

//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   static void hideOverlay() {
//     if (_overlayEntry != null) {
//       _overlayEntry!.remove();
//     }
//   }
// }
