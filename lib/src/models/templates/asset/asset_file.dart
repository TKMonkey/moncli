class AssetsFile {
  const AssetsFile._({
    required this.fileName,
    required this.type,
    required this.parentFolder,
    required this.assetsFolder,
  });

  factory AssetsFile.init(String assetsFolder, String value) {
    final asf = assetsFolder.contains('/') ? assetsFolder : '$assetsFolder/';
    final result = value.split(asf).last.split('/')
      ..removeWhere((element) => element.isEmpty);

    final parentFolder = result.sublist(0, result.length - 1).join('/');

    final fn = result.last;
    final type = fn.split('.').last;
    return AssetsFile._(
      fileName: fn,
      type: type,
      parentFolder: parentFolder,
      assetsFolder: assetsFolder,
    );
  }

  final String fileName;
  final String type;
  final String parentFolder;
  final String assetsFolder;

  @override
  String toString() =>
      'fileName: $fileName, type: $type, parentFolder: $parentFolder, assetsFolder: $assetsFolder';
}
