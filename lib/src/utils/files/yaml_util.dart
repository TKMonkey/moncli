import 'dart:io';

import 'package:moncli/src/models/node_model.dart';
import 'package:moncli/src/models/yaml/yaml_model.dart';

/// Serializes [yaml] into a String and returns it.
void toYamlString(
  Map yaml,
  List<Node> listNodes,
) {
  var sb = StringBuffer();

  for (var node in listNodes) {
    if (node is KeyNode) {
      var sbk = StringBuffer();
      writeYamlString({node.key: yaml[node.key]}, sbk);

      /// moves text to be inline with [hyphen '-']
      sb.write(sbk.toString().replaceAll(RegExp(r'-\s\n\s*'), '- '));
    } else {
      sb.writeln(node.line);
    }

    File(outputDirectory).writeAsStringSync(sb.toString());
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
    ss..writeln("'${_escapeString(node)}'");

    /// most numbers are found to be strings, and they should be displayed as
    /// such, not as numbers
  } else if (int.tryParse(node) != null || double.tryParse(node) != null) {
    ss..writeln('${_multiLine(_escapeString(node), true, indent)}');

    /// if contains escape sequences, maintain those
  } else if (node.contains('\r') || node.contains('\n') || node.contains('\t')) {
    ss..writeln('${_multiLine(_withEscapes(node), false, indent)}');

    /// if it contains a [colon, ':'] then put it in quotes to not confuse Yaml
  } else if (node.contains('\\')) {
    ss
      ..writeln(
          '${_multiLine(_escapeString(node).replaceAll(r'\', r'\\'), true, indent)}');
  } else {
    ss..writeln('${_multiLine(_escapeString(node), false, indent)}');
  }
}

/// cleanly formats multi-line strings, using 80 character max
String _multiLine(String s, bool quotes, int indent) {
  return s;
  // if (s.isEmpty) {return s;}
  // if (specialCharacters.contains(s[0])) {
  //   quotes = true;
  // }
  // if (s.length <= 80) {
  //   if (quotes) {
  //     if (s.contains("'")) {
  //       return '"$s"';
  //     } else {
  //       return "'$s'";
  //     }
  //   } else {
  //     return s;
  //   }
  // } else {
  //   quotes = s[0] == ' ';
  //   var returnString = '>';
  //   var length = 80;
  //   while (s.length > length) {
  //     var index = s.lastIndexOf(' ', length);
  //     if (index == -1) {
  //       length += 10;
  //     } else {
  //       returnString += '\n${' ' * indent}${s.substring(0, index + 1)}';
  //       s = s.substring(index + 1);
  //       length = 80;
  //     }
  //   }
  //   final strLength = s.length;

  //   if (length > strLength && s.isNotEmpty) {
  //     returnString += '\n${' ' * indent}$s';
  //   }

  //   if (quotes) {
  //     returnString =
  //         returnString.replaceFirst('>-\n${' ' * indent}', ">-\n${' ' * indent}\'");
  //     returnString += "'";
  //   }

  //   return returnString;
  // }
}

String _withEscapes(String s) => s
    .replaceAll('\r', '\\r')
    .replaceAll('\t', '\\t')
    .replaceAll('\n', '\\n')
    .replaceAll('\"', '\\"');

String _escapeString(String s) => s.replaceAll('"', r'\"').replaceAll('\n', r'\n');

void _mapToYamlString(Map node, int indent, StringSink ss, bool isTopLevel) {
  if (!isTopLevel) {
    ss.writeln();
    indent += 2;
  }

  node.forEach((k, v) {
    _writeIndent(indent, ss);
    ss..write(k)..write(': ');
    _writeYamlType(v, indent, ss, false);
  });
}

void _listToYamlString(Iterable node, int indent, StringSink ss, bool isTopLevel) {
  if (!isTopLevel) {
    ss.writeln();
    indent += 2;
  }
  for (var n in node) {
    _writeIndent(indent, ss);
    ss.write('- ');
    _writeYamlType(n, indent, ss, false);
  }
}

void _writeIndent(int indent, StringSink ss) => ss.write(' ' * indent);

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
