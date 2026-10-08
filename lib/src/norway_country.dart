import 'package:plate_core/plate_core.dart';

import 'norway_colors.dart';

/// Norway as a `PlateCountry`: the blue nationality stripe with the flag. The
/// `N` beneath it is a [PlateLabel] on the spec, so [captionLines] is empty.
/// The diplomatic plate has no stripe and sets `noPanel`.
///
/// The flag is the SVG asset (Wikimedia Commons `Flag_of_Norway.svg`).
abstract final class NorwayCountry {
  static const PlateCountry norway = PlateCountry(
    code: 'no',
    captionLines: <String>[],
    panelColor: NorwayColors.stripeBlue,
    panelTextColor: NorwayColors.stripeInk,
    flagAspectRatio: 22 / 16,
    flag: SvgPlateAsset(
      'assets/flags/Flag_of_Norway.svg',
      package: 'norway_plate',
    ),
  );
}
