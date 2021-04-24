class AssetsFile {
  const AssetsFile._({
    required this.fileName,
    required this.parentFolder,
    required this.assetsFolder,
  });

  factory AssetsFile.init(String assetsFolder, String value) {
    final asf = assetsFolder.contains('/') ? assetsFolder : '$assetsFolder/';
    final result = value.split(asf).last.split('/');

    var parentFolder = '';
    for (var i = 0; i < result.length - 1; i++) {
      if (result[i].isEmpty) continue;
      parentFolder += '${result[i]}/';
    }

    return AssetsFile._(
      fileName: result.last,
      parentFolder: parentFolder,
      assetsFolder: assetsFolder,
    );
  }

  final String fileName;
  final String parentFolder;
  final String assetsFolder;

  @override
  String toString() =>
      'fileName: $fileName, parentFolder: $parentFolder, assetsFolder: $assetsFolder';
}
