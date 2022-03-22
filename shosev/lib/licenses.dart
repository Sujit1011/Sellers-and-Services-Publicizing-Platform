import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void lisences () {
  // Google Fonts License, as suggested in https://pub.dev/packages/google_fonts
  LicenseRegistry.addLicense(() async* {
    final nunitoSansLicense = await rootBundle.loadString('assets/fonts/Nunito_Sans/OFL.txt');
    final hindLicense = await rootBundle.loadString('assets/fonts/Hind/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], nunitoSansLicense + hindLicense);
  });
}