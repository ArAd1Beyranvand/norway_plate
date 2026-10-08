import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

/// Judges a Norwegian plate. A regular plate is two letters and four or five
/// digits (`AB 12345`); a diplomatic plate is `CD`, a two-digit mission code
/// and a three-digit sequence. Reports, never bars a keystroke; the one
/// refusal is the restriction the diplomatic spec carries.
class NorwayValidator extends GatedPlateValidator {
  const NorwayValidator();

  @override
  String get gateGroup => 'number';

  static const String reasonLetters =
      'The prefix is two letters (no G, I, M, O, Q).';
  static const String reasonNumber = 'The number is four or five digits.';
  static const String reasonCode = 'The prefix is CD.';
  static const String reasonEmbassy = 'The mission code is two digits.';
  static const String reasonCar = 'The sequence is three digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String code = entry.group('code');
    if (code.isNotEmpty) {
      if (code != 'CD') return const PlateValidation.invalid(reasonCode);
      if (!isDigitsOfLength(entry.group('embassy'), 2)) {
        return const PlateValidation.invalid(reasonEmbassy);
      }
      if (!isDigitsOfLength(entry.group('number'), 3)) {
        return const PlateValidation.invalid(reasonCar);
      }
      return const PlateValidation.valid();
    }
    if (!RegExp(
      r'^[ABCDEFHJKLNPRSTUVWXYZ]{2}$',
    ).hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    final String number = entry.group('number');
    if (!isDigits(number) || number.length < 4 || number.length > 5) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}
