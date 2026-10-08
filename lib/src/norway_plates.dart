import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'norway_colors.dart';
import 'norway_country.dart';

/// Where the ink sits, in plate units. Every reference is flattened to the
/// 520×110 the article gives (4 px per unit) and projected onto each axis.
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
/// Ink is about 75 tall on a 110 plate; a box that tall would need ~135, so
/// every box is the full canvas height and the ink lands near 58, about 78% of
/// reference.
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

/// The Norwegian plates. Groups `letters`, `number` on a regular plate;
/// `code`, `embassy`, `number` on a diplomatic one.
///
/// [private] is `AB 12345`, black on white with the blue nationality stripe;
/// [privateFor] gives the four-digit form (motorcycles, trailers). [electric]
/// is the same design with an `EL`-style prefix, so it is [private]. The
/// [diplomatic] plate (`CD 53 094`) pairs with [NorwayThemes.diplomatic].
///
/// Embassy code 44 is Israel's in the article's table and is refused with
/// [NorwayPlates.israel] on the diplomatic spec, reason `COUNTRY NOT FOUND`,
/// in the controller, input machine, validator and canvas.
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

  /// A regular plate with [digits] (4 or 5) digits.
  static PlateSpec privateFor(int digits) {
    if (digits < 4 || digits > 5) {
      throw ArgumentError.value(digits, 'digits', 'Four or five');
    }
    return _spec(
      id: 'no.private.$digits',
      stripe: true,
      slots: <PlateSlot>[
        ..._group(
          NorwayAlphabets.letters,
          2,
          _Layout.letterCx,
          _Layout.letterPitch,
        ),
        ..._group(
          NorwayAlphabets.digits,
          digits,
          _Layout.lastDigitCx - (digits - 1) * _Layout.digitPitch,
          _Layout.digitPitch,
        ),
      ],
      groups: <PlateTextGroup>[
        const PlateTextGroup(<int>[0, 1], key: 'letters'),
        PlateTextGroup(<int>[
          for (int i = 0; i < digits; i++) 2 + i,
        ], key: 'number'),
      ],
    );
  }

  static final PlateSpec electric = private;

  static final PlateSpec diplomatic = _spec(
    id: 'no.diplomatic',
    slots: <PlateSlot>[
      ..._group(
        NorwayAlphabets.diplomaticLetters,
        2,
        _Layout.dipLetterCx,
        _Layout.dipLetterPitch,
      ),
      ..._group(
        NorwayAlphabets.digits,
        5,
        _Layout.dipDigitCx,
        _Layout.dipDigitPitch,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1], key: 'code'),
      PlateTextGroup(<int>[2, 3], key: 'embassy'),
      PlateTextGroup(<int>[4, 5, 6], key: 'number'),
    ],
    restrictions: const <PlateRestriction>[israel],
  );

  static List<PlateSpec> get all => <PlateSpec>[private, diplomatic];

  static List<PlateSlot> _group(
    PlateAlphabet alphabet,
    int count,
    double firstCx,
    double pitch,
  ) => plateRegister(
    alphabet: alphabet,
    count: count,
    left: firstCx - pitch / 2,
    top: _Layout.top,
    width: pitch,
    height: _Layout.box,
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
            box: PlateBox(
              _Layout.flagLeft,
              _Layout.flagTop,
              _Layout.flagWidth,
              _Layout.flagHeight,
            ),
            padding: EdgeInsets.zero,
          )
        : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
    noPanel: !stripe,
    background: stripe
        ? const PlateSection.columns(<PlatePart>[
            PlatePart(
              PlateSection.fill(PlateFill.panel),
              end: _Layout.stripeEnd,
            ),
            PlatePart(PlateSection.plain),
          ])
        : PlateSection.plain,
    slots: slots,
    labels: <PlateLabel>[
      if (stripe)
        const PlateLabel(
          text: 'N',
          box: PlateBox(
            _Layout.nLeft,
            _Layout.nTop,
            _Layout.nWidth,
            _Layout.nHeight,
          ),
          glyphHeight: _Layout.nGlyph,
          color: NorwayColors.stripeInk,
        ),
    ],
    textGroups: groups,
    restrictions: restrictions,
  );
}
