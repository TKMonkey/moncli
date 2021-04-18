class PackageModel {
  const PackageModel(
    this.name, {
    this.isDev = false,
    this.version = '',
    this.isValid = true,
  });

  final String name;
  final bool isDev;
  final String version;
  final bool isValid;

  PackageModel copyWith({
    String? name,
    bool? isDev,
    String? version,
    bool? isValid,
  }) =>
      PackageModel(
        name ?? this.name,
        isDev: isDev ?? this.isDev,
        version: version ?? this.version,
        isValid: isValid ?? this.isValid,
      );
}
