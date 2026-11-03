import 'package:norway_plate/norway_plate.dart';
import 'package:plate_core/testing.dart';

void main() {
  plateGoldens('no', NorwayCountry.norway, <String, PlateGoldenCase>{
    'private': (NorwayPlates.private, NorwayThemes.private, 'EL|14325'),
    'diplomatic': (
      NorwayPlates.diplomatic,
      NorwayThemes.diplomatic,
      'CD|53|094',
    ),
  }, separator: '|');
}
