import 'dart:math';

import 'package:dwarf_clicker/constants/globals.dart';
import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

//random power up component that doubles gold
class coin_component extends SpriteComponent
    with TapCallbacks, HasGameRef<DwarfClicker> {
  final double _spriteHeight = 50;
  int timer = 0;
  final Random _random = Random();
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //load the sprite at a random position on screen
    sprite = await gameRef.loadSprite(Globals.dwarfCoin);
    height = width = _spriteHeight;
    position = _getRandomPosiition();
    anchor = Anchor.center;
  }

  //get a random position on screen
  Vector2 _getRandomPosiition() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();

    return Vector2(x, y);
  }

  //on tpa double gold and remove from game
  @override
  void onTapDown(TapDownEvent event) {
    gameRef.gold = gameRef.gold * 2;
    removeFromParent();
  }

  //if not clicked in time dissapear ~5 seconds
  @override
  void update(double dt) {
    super.update(dt);
    timer += 1;
    if (timer >= 300) {
      removeFromParent();
    }
  }
}
