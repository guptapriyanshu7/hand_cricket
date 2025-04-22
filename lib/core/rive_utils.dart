import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController? getControllerForAnimation(
    Artboard artboard, {
    required String stateMachineName,
  }) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      stateMachineName,
    );
    if (controller != null) {
      artboard.addController(controller);
    }
    return controller;
  }

  static SMINumber? getNumberInput(
    StateMachineController controller,
    String name,
  ) {
    return controller.getNumberInput(name);
  }
}
