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

    final path = "${_joinWithouthLast(splitText: tokenizer, separator: "/")}/";
    final splitFileName = tokenizer.last.split('.');
    final nameFile =
        _joinWithouthLast(splitText: splitFileName, separator: ".");
    final type = splitFileName.last;

    final outputVar =
        '${getFixValue(prefix, tokenizer, type, prefix: true)}$nameFile${getFixValue(postFix, tokenizer, type)}';

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

String _joinWithouthLast(
        {required List<String> splitText, required String separator}) =>
    splitText.sublist(0, splitText.length - 1).join(separator);

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
          ? "${endStr}_"
          : "_$endStr";
}
