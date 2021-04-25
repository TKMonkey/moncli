class AssetsFile {
  const AssetsFile._({
    required this.path,
    required this.outputVar,
    required this.outputPath,
  });

  factory AssetsFile.init(
    String assetsFolder,
    String element,
    String prefix,
    String postFix,
  ) {
    final asf = assetsFolder.endsWith('/') ? assetsFolder : '$assetsFolder/';
    final outputPath = asf + element.split(asf).last;
    final tokeneizer = outputPath.split('/');

    final path = tokeneizer.sublist(0, tokeneizer.length - 1).join('/');
    final nameFile = tokeneizer.last.split('.');
    final type = nameFile.last;

    final outputVar =
        '${getFixValue(prefix, tokeneizer, type)}${nameFile.first}${getFixValue(postFix, tokeneizer, type)}';

    return AssetsFile._(
      path: path,
      outputVar: outputVar,
      outputPath: outputPath,
    );
  }

  final String path;
  final String outputVar;
  final String outputPath;

  @override
  String toString() => 'path: $path, outputVar: $outputVar, outputPath: $outputPath';
}

String getFixValue(
  String str,
  List<String> tokeneizer,
  String type, {
  bool prefix = false,
}) {
  String endStr = str;

  if (str == 'folder_name') {
    endStr = (tokeneizer
          ..removeWhere((element) => element.contains('.'))
          ..toList())
        .last;
  } else if (str == 'type_file') {
    endStr = type;
  }

  return str.isEmpty
      ? ''
      : prefix
          ? '_$endStr'
          : '$endStr"_"';
}
