import 'package:dwarf_clicker/constants/globals.dart';
import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:flame/components.dart';

//only loads the background sprite used for the game
class BackgroundComponent extends SpriteComponent
    with HasGameRef<DwarfClicker> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.backgroundSprite);
    size = gameRef.size;
  }
}
