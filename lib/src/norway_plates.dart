import 'dart:math';

import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'norway_colors.dart';
import 'norway_country.dart';
import 'norway_regions.dart';

/// Plate units measured off references flattened to 520×110 (4 px per unit).
///
/// Stripe (`Skilt_elbil`): blue x 0–51.75, so the section ends at 52 under the
/// frame; flag x 7.8–44.8, y 16–44 (22:16); white `N` x 17–36, y 73–90 (cap 17).
///
/// Regular plate (`Skilt_elbil`, `Norwegian_number_plate`): letters centred
/// 115.2 and 168.5 (pitch 53.3); five digits at 250.5 + 54.2 i (the `1`'s ink
/// sits right of its cell, so the centres come from `3 2 5` at 359.0, 414.1,
/// 466.9); ink y 20–94.5 (74.5 tall).
///
/// Diplomatic (`CD_license_plate_of_Norway`): `CD` centred 57.8 and 118.0; five
/// digits at 232.1, 289.6, 347.9, 404.9, 461.6 (pitch 57.4); ink y 14–95.
///
/// Ink is about 75 tall on a 110 plate; matching it would need a ~135 box, so
/// every box is the canvas height and the ink lands near 58 (78% of reference).
abstract final class _Layout {
  static const double width = 520, height = 110;
  static const double stripeEnd = 52;

  static const double box = 110, top = 0;

  static const double flagLeft = 7.8, flagTop = 16, flagWidth = 37;
  static const double flagHeight = 28;
  static const double nLeft = 6, nTop = 69.5, nWidth = 40, nHeight = 24;
  static const double nGlyph = 33;

  static const double letterCx = 115.2, letterPitch = 53.3;
  static const double lastDigitCx = 467.3, digitPitch = 54.2;

  static const double dipLetterCx = 57.8, dipLetterPitch = 60.2;
  static const double dipDigitCx = 232.1, dipDigitPitch = 57.4;
}

/// Groups `letters`, `number` on a regular plate; `code`, `embassy`, `number`
/// on a diplomatic one.
///
/// [privateFor] gives the four-digit form (motorcycles, trailers). [electric]
/// is the same design with an `EL`-style prefix, so it is [private].
///
/// Embassy code 44 is refused on the diplomatic spec by [israel] with reason
/// `COUNTRY NOT FOUND`.
///
/// Not implemented, for lack of a measured reference: the black, orange,
/// green, red and export classes the prose lists, and the 1913–1971 single
/// letter plates (a historical series; its photo is CHECK-fitted and shows a
/// dark plate with a bottom band and a roundel).
abstract final class NorwayPlates {
  static const String notFound = 'COUNTRY NOT FOUND';

  static const PlateRestriction israel = PlateRestriction(
    group: 'embassy',
    values: <String>['44'],
    reason: notFound,
  );

  static final PlateSpec private = privateFor(5);

  /// [digits] is 4 or 5.
  static PlateSpec privateFor(int digits) {
    if (digits < 4 || digits > 5) {
      throw ArgumentError.value(digits, 'digits', 'Four or five');
    }
    return _spec(
      id: 'no.private.$digits',
      stripe: true,
      slots: <PlateSlot>[
        _group(NorwayAlphabets.letters, 2, _Layout.letterCx, _Layout.letterPitch),
        _group(
          NorwayAlphabets.digits,
          digits,
          _Layout.lastDigitCx - (digits - 1) * _Layout.digitPitch,
          _Layout.digitPitch,
        ),
      ],
      groups: <PlateTextGroup>[
        const PlateTextGroup(<int>[0], key: 'letters'),
        const PlateTextGroup(<int>[1], key: 'number'),
      ],
    );
  }

  static final PlateSpec electric = private;

  static final PlateSpec diplomatic = _spec(
    id: 'no.diplomatic',
    slots: <PlateSlot>[
      _group(NorwayAlphabets.diplomaticLetters, 2, _Layout.dipLetterCx, _Layout.dipLetterPitch),
      _group(NorwayAlphabets.digits, 2, _Layout.dipDigitCx, _Layout.dipDigitPitch),
      _group(
        NorwayAlphabets.digits,
        3,
        _Layout.dipDigitCx + 2 * _Layout.dipDigitPitch,
        _Layout.dipDigitPitch,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'code'),
      PlateTextGroup(<int>[1], key: 'embassy'),
      PlateTextGroup(<int>[2], key: 'number'),
    ],
    restrictions: const <PlateRestriction>[israel],
  );

  static List<PlateSpec> get all => <PlateSpec>[private, diplomatic];

  static PlateSlot _group(PlateAlphabet alphabet, int count, double firstCx, double pitch) =>
      PlateSlot(
        alphabet: alphabet,
        box: PlateBox(firstCx - pitch / 2, _Layout.top, count * pitch, _Layout.box),
        length: count,
        spacing: max(0, pitch - 0.6 * 0.72 * _Layout.box),
      );

  static PlateSpec _spec({
    required String id,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    bool stripe = false,
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
  }) => PlateSpec(
    id: id,
    country: NorwayCountry.norway,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: stripe
        ? const PlatePanel(
            box: PlateBox(_Layout.flagLeft, _Layout.flagTop, _Layout.flagWidth, _Layout.flagHeight),
            padding: EdgeInsets.zero,
          )
        : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
    noPanel: !stripe,
    background: stripe
        ? const PlateSection.columns(<PlatePart>[
            PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.stripeEnd),
            PlatePart(PlateSection.plain),
          ])
        : PlateSection.plain,
    slots: slots,
    labels: <PlateLabel>[
      if (stripe)
        const PlateLabel(
          text: 'N',
          box: PlateBox(_Layout.nLeft, _Layout.nTop, _Layout.nWidth, _Layout.nHeight),
          glyphHeight: _Layout.nGlyph,
          color: NorwayColors.stripeInk,
        ),
    ],
    textGroups: groups,
    resolveRegion: NorwayRegions.captionOf,
    restrictions: restrictions,
  );
}
