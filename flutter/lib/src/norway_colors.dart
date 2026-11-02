import 'package:flutter/widgets.dart';

/// The colours of the Norwegian plates, sampled from the flattened references
/// (modal pixel of the region, balanced against the field of the same photo).
///
/// The white field and black ink are the clean `2012_format` render
/// (`FCFCFC`, `151515`); the photographs carry their lighting (`DCE0DC`,
/// `1C140C`). The nationality stripe `005CC0` is sampled from `Skilt_elbil`
/// (the other photo's `867ABA` is a purple cast of its lighting). The
/// diplomatic field `3EBDFF` and its yellow ink `F8E746` are from the
/// balanced flat of the CD photo.
abstract final class NorwayColors {
  static const Color white = Color(0xFFFCFCFC);
  static const Color black = Color(0xFF151515);
  static const Color stripeBlue = Color(0xFF005CC0);
  static const Color stripeInk = Color(0xFFFFFFFF);

  static const Color diplomaticBlue = Color(0xFF3EBDFF);
  static const Color diplomaticInk = Color(0xFFF8E746);

  static const Color inactive = Color(0xFFB0B0B0);
}
