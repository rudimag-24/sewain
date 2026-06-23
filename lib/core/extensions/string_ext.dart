extension StringExt on String {
  /// hello_world = Hello World
  String get toTitleCase {
    List<String> words = split('_');

    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    return capitalizedWords.join(' ');
  }
}