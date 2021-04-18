class PubSpec {
  PubSpec({
    required this.devDependencies,
    required this.dependencies,
    required this.dependencyOverrides,
    required this.name,
  });

  final String name;
  final Map dependencies;
  final Map devDependencies;
  final Map dependencyOverrides;

  PubSpec copy({
    Map? devDependencies,
    Map? dependencies,
    String? name,
    Map? dependencyOverrides,
  }) {
    return PubSpec(
      devDependencies: devDependencies ?? this.devDependencies,
      dependencies: dependencies ?? this.dependencies,
      dependencyOverrides: dependencyOverrides ?? this.dependencyOverrides,
      name: name ?? this.name,
    );
  }
}
