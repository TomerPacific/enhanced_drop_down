
import 'package:flutter/cupertino.dart';

const rtlLanguages = {'ar', 'he', 'fa', 'ur', 'sd', 'ps', 'yi'};

class LanguageUtils {

  LanguageUtils._();

  static TextDirection getTextDirection(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    return rtlLanguages.contains(languageCode)
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

}

