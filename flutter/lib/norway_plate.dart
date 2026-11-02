/// Norway's licence plates for the `plate_core` library.
///
/// Regular and diplomatic plates with their colours, themes, county lookup and
/// an advisory validator.
library;

// TODO(py): [D5] one module `plates.countries.norway`; assets via importlib.resources.
// TODO(ts): [D5] one subpath export `./countries/norway`; tree-shakable.
// TODO(kt): [D5] package `countries.norway` in the countries module.
export 'src/norway_colors.dart';
export 'src/norway_country.dart';
export 'src/norway_plates.dart';
export 'src/norway_regions.dart';
export 'src/norway_themes.dart';
export 'src/norway_validators.dart';
export 'package:plate_alphabet/plate_alphabet.dart' show NorwayAlphabets;
