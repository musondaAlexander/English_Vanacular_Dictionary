import 'dart:async';

import 'package:offlineengvandictionary/online_dictionary/models/word_description/word_description.dart';

abstract class DictionaryMethods {
  FutureOr<WordDescriptions> getWordDescription(String word);
}
