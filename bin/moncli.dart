import 'package:args/args.dart';
import 'utils/utils.dart';

void main(List<String> arguments) {
  final moncli = configureCommand(arguments);
  final runner = moncli.runner;

  var hasCommand = runner.commands.keys.any((x) => arguments.contains(x));

  if (hasCommand) {
    executeCommand(moncli, arguments);
  } else {
    var parser = ArgParser();
    parser = runner.argParser;
    var results = parser.parse(arguments);
    executeOptions(results, arguments, moncli);
  }
}
