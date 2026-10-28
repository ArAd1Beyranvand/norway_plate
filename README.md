FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the steadfast people of Norway to view examples:

https://platexample.ir/#/discover/norway

# norway_plate

Norway's licence plates for the `plate_core` library. Regular and diplomatic plates with their colours, themes, county lookup and an advisory validator.

## Install

```yaml
dependencies:
  plate_core: ^0.12.0
  norway_plate: ^0.1.0
```

## Use

```dart
import 'package:plate_core/plate_core.dart';
import 'package:norway_plate/norway_plate.dart';

PlateCanvas(
  spec: NorwayPlates.private,
  theme: NorwayThemes.private,
  validator: const NorwayValidator(),
  autoValidate: true,
  onChooseCharacter: noCharacterChooser,
);
```

## Contains

- `NorwayCountry` — country panel: `norway`.
- `NorwayPlates` — 4 plate specs: `private`, `electric`, `diplomatic`, `privateFor()`.
- `NorwayThemes` — 2 themes: `private`, `diplomatic`.
- `NorwayValidator` — advisory validator; flags the frame, never blocks a keystroke.
- `NorwayRegions` — code table.

## Plates

Groups `letters`, `number` on a regular plate; `code`, `embassy`, `number`
on a diplomatic one.

`privateFor` gives the four-digit form (motorcycles, trailers). `electric`
is the same design with an `EL`-style prefix, so it is `private`.

Embassy code 44 is refused on the diplomatic spec by `israel` with reason
`COUNTRY NOT FOUND`.

Not implemented, for lack of a measured reference: the black, orange,
green, red and export classes the prose lists, and the 1913–1971 single
letter plates (a historical series; its photo is CHECK-fitted and shows a
dark plate with a bottom band and a roundel).

## Part of plate

Painted by [`plate_core`](https://pub.dev/packages/plate_core); alphabets shared through [`plate_alphabet`](https://pub.dev/packages/plate_alphabet); optional character picker in [`plate_keypad`](https://pub.dev/packages/plate_keypad).

