import 'package:flutter_test/flutter_test.dart';
import 'package:norway_plate/norway_plate.dart';
import 'package:plate_core/plate_core.dart';

void main() {
  test('a full series names the county', () {
    expect(NorwayRegions.lookup('AA'), 'Østfold');
    expect(NorwayRegions.lookup('BL'), 'Akershus');
  });

  test(
    'a lone letter spanning counties, a split code and nothing name nothing',
    () {
      for (final String code in <String>['', 'B', 'EX', 'QQ']) {
        expect(NorwayRegions.lookup(code), isNull, reason: code);
      }
    },
  );

  test('the private plate follows the letters typed and deleted', () {
    final PlateController c = PlateController(spec: NorwayPlates.private);
    expect(c.regionCaption, isNull);
    c.setGroup('letters', 'B');
    expect(c.regionCaption, isNull);
    c.setGroup('letters', 'BL');
    expect(c.regionCaption, 'Akershus');
    c.setGroup('letters', 'B');
    expect(c.regionCaption, isNull);
  });

  test('the diplomatic plate has no caption', () {
    final PlateController c = PlateController(spec: NorwayPlates.diplomatic);
    expect(c.regionCaption, isNull);
  });
}
