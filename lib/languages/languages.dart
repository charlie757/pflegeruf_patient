class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // '':'',
      };
}

abstract class Translations {
  Map<String, Map<String, String>> get keys;
}
