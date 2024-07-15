import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

//simple ontap event for adding options menu to the overlays for building the options button component in dwarf_clicker.dart
class OptionsMenuButton extends SpriteComponent
    with TapCallbacks, HasGameRef<DwarfClicker> {
  @override
  void onTapDown(TapDownEvent event) {
    gameRef.overlays.add('OptionsMenu');
  }
}
