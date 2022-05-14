import 'package:get/get.dart';
import 'package:social_increase/utils/languages/arabic.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
        },
        'ar_SA': getArabic()
      };
}
