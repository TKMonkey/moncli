import 'dart:io';

import 'package:moncli/src/base/constants.dart';
import 'package:moncli/src/models/yaml/line.dart';

mixin YamlPrinterMixin {
  bool firtstFont = false;

  /// Serializes [yaml] into a String and returns it.
  void toYamlString(
    Map yaml,
    List<Line> listLines,
  ) {
    final sb = StringBuffer();

    for (final node in listLines) {
      if (node is KeyLine) {
        final sbk = StringBuffer();
        writeYamlString({node.key: yaml[node.key]}, sbk);

        /// moves text to be inline with [hyphen '-']
        sb.write(sbk.toString().replaceAll(RegExp(r'-\s\n\s*'), '- '));
      } else {
        sb.writeln(node.line);
      }

      File(outputPubPath).writeAsStringSync(sb.toString());
    }
  }

  /// Serializes [node] into a String and writes it to the [sink].
  void writeYamlString(node, StringSink sink) {
    _writeYamlType(node, 0, sink, true);
  }

  void _writeYamlType(node, int indent, StringSink ss, bool isTopLevel) {
    if (node is Map) {
      _mapToYamlString(node, indent, ss, isTopLevel);
    } else if (node is Iterable) {
      _listToYamlString(node, indent, ss, isTopLevel);
    } else if (node is String) {
      _writeYamlString(node, ss, indent + 2);
    } else if (node is double) {
      ss.writeln('!!float $node');
    } else {
      ss.writeln(node);
    }
  }

  /// Provides formatting if [node] is a String and writes to the `sink`.
  void _writeYamlString(
    String node,
    StringSink ss,
    int indent,
  ) {
    /// quotes single length special characters
    if (node.length == 1 && specialCharacters.contains(node)) {
      ss.writeln("'${_escapeString(node)}'");

      /// most numbers are found to be strings, and they should be displayed as
      /// such, not as numbers
    } else if (int.tryParse(node) != null || double.tryParse(node) != null) {
      ss.writeln(_escapeString(node));

      /// if contains escape sequences, maintain those
    } else if (node.contains('\r') || node.contains('\n') || node.contains('\t')) {
      ss.writeln(_withEscapes(node));

      /// if it contains a [colon, ':'] then put it in quotes to not confuse Yaml
    } else if (node.contains('\\')) {
      ss.writeln(_escapeString(node).replaceAll(r'\', r'\\'));
    } else {
      ss.writeln(_escapeString(node));
    }
  }

  String _withEscapes(String s) => s
      .replaceAll('\r', '\\r')
      .replaceAll('\t', '\\t')
      .replaceAll('\n', '\\n')
      .replaceAll('\"', '\\"');

  String _escapeString(String s) => s.replaceAll('"', r'\"').replaceAll('\n', r'\n');

  void _mapToYamlString(Map node, int indent, StringSink ss, bool isTopLevel) {
    int newIndet = indent;
    if (!isTopLevel) {
      ss.writeln();
      newIndet += 2;
    }

    node.forEach((k, v) {
      if (k == 'fonts' && v is List && !firtstFont) {
        ss.writeln();
        firtstFont = true;
      }
      _writeIndent(newIndet, ss);
      ss..write(k)..write(': ');
      _writeYamlType(v, newIndet, ss, false);
    });
  }

  void _listToYamlString(Iterable node, int indent, StringSink ss, bool isTopLevel) {
    int newIndet = indent;
    if (!isTopLevel) {
      ss.writeln();
      newIndet += 2;
    }
    for (final n in node) {
      _writeIndent(newIndet, ss);
      ss.write('- ');
      _writeYamlType(n, newIndet, ss, false);
    }
  }

  void _writeIndent(int indent, StringSink ss) => ss.write(' ' * indent);
}

const specialCharacters = [
  ':',
  '{',
  '}',
  '[',
  ']',
  ',',
  '&',
  '*',
  '#',
  '?',
  '|',
  '-',
  '<',
  '>',
  '=',
  '!',
  '%',
  '@',
  ')',
];
