class Line {
  final String line;

  const Line(this.line);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Line && runtimeType == other.runtimeType && line == other.line;

  @override
  int get hashCode => line.hashCode;
}
