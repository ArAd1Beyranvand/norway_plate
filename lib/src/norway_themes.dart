import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'norway_colors.dart';

/// One ink on one field. The regular plate has a thin printed frame (about
/// 1.5 of 110 in the photographs); the diplomatic photo shows none.
abstract final class NorwayThemes {
  /// Regular plate: black on white.
  static final PlateTheme private = _theme(
    NorwayColors.white,
    NorwayColors.black,
    border: 0.015,
  );

  /// `CD`: yellow on blue.
  static final PlateTheme diplomatic = _theme(
    NorwayColors.diplomaticBlue,
    NorwayColors.diplomaticInk,
    border: 0,
  );
}

PlateTheme _theme(Color field, Color ink, {required double border}) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      inactive: NorwayColors.inactive,
      borderWidthRatio: border,
      plateRadiusRatio: 0.06,
    );
