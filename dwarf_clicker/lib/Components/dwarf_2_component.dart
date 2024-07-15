import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:dwarf_clicker/constants/globals.dart';

//animation component for the game
class Dwarf2Animations extends SpriteAnimationComponent
    with HasGameRef<DwarfClicker> {
  bool isVisible = false;
  int timer = 0;

  @override
  Future<void> onLoad() async {
    //get the sprite sheet and size of each step
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(Globals.dwarfMinerSprite),
      srcSize: Vector2(64, 32),
    );
    final spriteSize = Vector2(400, 200);

    //create the actual animation
    final animation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.125, to: 8);

    //create the component to be put into the flutter flame game
    final component1 = SpriteAnimationComponent(
      animation: animation,
      scale: Vector2(0.4, 0.4),
      position: Vector2(15, 380),
      size: spriteSize,
    );

    //add the component
    add(component1);
  }
}
