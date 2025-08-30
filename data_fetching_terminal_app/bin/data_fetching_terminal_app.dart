import 'package:data_fetching_terminal_app/controllers/arg_parser_controller.dart';

void main(List<String> arguments) {
  final controller = ArgParserController(arguments: arguments);

  controller.initController();
}
