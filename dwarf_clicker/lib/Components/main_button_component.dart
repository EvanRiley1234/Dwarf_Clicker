import 'package:dwarf_clicker/constants/globals.dart';
import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';

//mainbutton component used for the main gold button, increases player gold on click
class MainButton extends SpriteComponent
    with TapCallbacks, HasGameRef<DwarfClicker> {
  @override
  bool onTapDown(TapDownEvent event) {
    try {
      gameRef.gold = gameRef.gold + (1 * gameRef.tapMultiplier);
      FlameAudio.play(Globals.onTapSound, volume: gameRef.soundVolume);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
