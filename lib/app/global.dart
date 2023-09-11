/// vars with changeable values
class GlobalVars {
  Map<String, String>? headers = {
    'Accept': 'application/json',
    // 'lang': selectedLang!,
    'lang': "ar",
    // 'Content-Type': 'application/json',
  };
  String? oldLang;

  String? androidRelease;
}

String? selectedLang;
