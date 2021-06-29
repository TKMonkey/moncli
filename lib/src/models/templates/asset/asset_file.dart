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
    final tokenizer = outputPath.split('/');

    final path = "${_joinWithoutLast(splitText: tokenizer, separator: "/")}/";
    final splitFileName = tokenizer.last.split('.');
    final nameFile = _joinWithoutLast(splitText: splitFileName, separator: ".");
    final type = splitFileName.last;

    final outputVar =
        '${_getAffixValue(prefix, tokenizer, type, isPrefix: true)}$nameFile${_getAffixValue(postFix, tokenizer, type)}';

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
  String toString() =>
      'AssetsFile(path: $path, outputVar: $outputVar, outputPath: $outputPath)';
}

String _joinWithoutLast(
        {required List<String> splitText, required String separator}) =>
    splitText.sublist(0, splitText.length - 1).join(separator);

String _getAffixValue(
  String str,
  List<String> tokenizer,
  String type, {
  bool isPrefix = false,
}) {
  String endStr = str;

  if (str == 'folder_name') {
    endStr = (tokenizer
          ..removeWhere((element) => element.contains('.'))
          ..toList())
        .last;
  } else if (str == 'type_file') {
    endStr = type;
  }

  return str.isEmpty
      ? ''
      : isPrefix
          ? "${endStr}_"
          : "_$endStr";
}
