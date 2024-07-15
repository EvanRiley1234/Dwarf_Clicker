import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:dwarf_clicker/constants/globals.dart';
import 'package:google_fonts/google_fonts.dart';

//handles the string component in the topleft of the game in addition to adding passive gold
class totalGold extends PositionComponent with HasGameRef<DwarfClicker> {
  //variables used below
  late String goldString;
  int timer = 0;
  late TextComponent _goldTextComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //text component at top left of screen
    _goldTextComponent = TextComponent(
      text: "Gold: " + gameRef.gold.toString(),
      position: Vector2(40, 40),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.white.color,
          fontSize: 30,
          fontFamily: GoogleFonts.gemunuLibre().fontFamily,
        ),
      ),
    );

    add(_goldTextComponent);
  }

  //update method for increasing passive gold
  @override
  void update(double dt) {
    super.update(dt);
    if (timer >= 60) {
      //update gold every second
      gameRef.gold = game.gold + gameRef.passiveGold;
      //also since animations should be allowed play pickaxe sound effect every second if the animation is present
      if (gameRef.playPickaxe == true) {
        print('play audio');
        FlameAudio.play(Globals.dwarfMinerAudio, volume: gameRef.soundVolume);
      }
      timer = 0;
    } else {
      timer += 1;
    }
    //update the string
    goldString = gameRef.gold.toString();
    _goldTextComponent.text = "Gold: $goldString";
  }
}
