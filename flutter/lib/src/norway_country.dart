import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'norway_colors.dart';

/// Norway as a `PlateCountry`: the blue nationality stripe with the flag. The
/// `N` beneath it is a [PlateLabel] on the spec, so [captionLines] is empty.
/// The diplomatic plate has no stripe and sets `noPanel`.
abstract final class NorwayCountry {
  static const PlateDrawing _flag = PlateDrawing(22, 16, <PlateShape>[
    PlateRectShape(0, 0, 22, 16, Color(0xFFBA0C2F)),
    PlateRectShape(6, 0, 4, 16, Color(0xFFFFFFFF)),
    PlateRectShape(0, 6, 22, 4, Color(0xFFFFFFFF)),
    PlateRectShape(7, 0, 2, 16, Color(0xFF00205B)),
    PlateRectShape(0, 7, 22, 2, Color(0xFF00205B)),
  ]);

  static const PlateCountry norway = PlateCountry(
    code: 'no',
    panelColor: NorwayColors.stripeBlue,
    panelTextColor: NorwayColors.stripeInk,
    flagAspectRatio: 22 / 16,
    flag: _flag,
  );
}
