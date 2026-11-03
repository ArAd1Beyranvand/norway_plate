import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';
import 'package:norway_plate/norway_plate.dart';

void main() => runApp(
  PlateExampleApp(spec: NorwayPlates.private, theme: NorwayThemes.private),
);
