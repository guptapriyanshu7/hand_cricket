import 'package:rive/rive.dart';

class RiveUtils {
  // add the state machine controller to the artboard and return it
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

  // get the number input from name
  static SMINumber? getNumberInput(
    StateMachineController controller,
    String name,
  ) {
    return controller.getNumberInput(name);
  }
}
