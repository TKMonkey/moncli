import 'dart:async';

import 'package:moncli/src/base/base_command.dart';
import 'package:moncli/src/utils/utils.dart';
import 'order.dart';

class OrderSubCommand extends CommandBase {
  @override
  final name = 'order';

  @override
  final description = 'Order packages in pubspec.yaml';

  @override
  String get invocation => yellow('moncli order');

  @override
  PubCommandUtils get commandUtils => PubCommandUtils();

  @override
  Future<void> run() async {
    commandUtils
      ..existsPubspec()
      ..runAndUpdate(order());
  }
}
