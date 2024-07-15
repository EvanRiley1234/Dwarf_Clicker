import 'dart:math';

import 'package:dwarf_clicker/Components/background_components.dart';
import 'package:dwarf_clicker/Components/coin_component.dart';
import 'package:dwarf_clicker/Components/dwarf_1_component.dart';
import 'package:dwarf_clicker/Components/dwarf_2_component.dart';
import 'package:dwarf_clicker/Components/dwarf_3_component.dart';
import 'package:dwarf_clicker/Components/gold_component.dart';
import 'package:dwarf_clicker/Components/main_button_component.dart';
import 'package:dwarf_clicker/Components/options_menu_button_component.dart';
import 'package:dwarf_clicker/Components/upgrade_menu_button_component.dart';
import 'package:dwarf_clicker/constants/globals.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DwarfClicker extends FlameGame {
  //generla use variables (name tupically explains them)
  double gold = 0;
  double tapMultiplier = 1;
  double passiveGold = 0;
  bool playPickaxe = false;
  double soundVolume = 1.0;
  int timer = 0;
  int saveTimer = 0;
  late String goldString;

  //button variables to adding to the game
  MainButton mainButton = MainButton();
  UpgradeMenuButton upgradeButton = UpgradeMenuButton();
  OptionsMenuButton optionsButton = OptionsMenuButton();

  //array used for upgrade pricing
  List<double> prices = [10, 50, 200, 1500, 7500, 20000];
  //for loading default rpices
  List<double> pricesDefault = [10, 50, 200, 1500, 7500, 20000];

  //array for number of times an upgrade has been purchased
  List<int> purchases = [0, 0, 0, 0, 0, 0];

  //prefernces variable
  late SharedPreferences prefs;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //most everything for prefernces loading
    prefs = await SharedPreferences.getInstance();

    //save total gold
    gold = prefs.getDouble("totalGold") ?? 0;

    //update saved prices for passive mulitpliers
    for (int i = 0; i < prices.length; i++) {
      prices[i] = prefs.getDouble("prices" + i.toString()) ?? 0;
    }
    for (int i = 0; i < purchases.length; i++) {
      purchases[i] = prefs.getInt("purchases" + i.toString()) ?? 0;
    }

    //update for tap multiplier upgrades
    //no need to check if empty because if empty nothing changes
    tapMultiplier += purchases[0];
    tapMultiplier += purchases[3] * 10;

    //set prices to default if they are at 0 purchases
    for (int i = 0; i < purchases.length; i++) {
      if (purchases[i] == 0) {
        prices[i] = pricesDefault[i];
      }
    }

    //adding main components to the game
    add(BackgroundComponent());

    mainButton
      ..sprite = await loadSprite(Globals.mainButtonSprite)
      ..size = Vector2(150, 150)
      ..position = Vector2(125, 320);
    add(mainButton);

    upgradeButton
      ..sprite = await loadSprite(Globals.menuButtonSprite)
      ..size = Vector2(100, 100)
      ..position = Vector2(0, 705);
    add(upgradeButton);

    optionsButton
      ..sprite = await loadSprite(Globals.settingsImage)
      ..size = Vector2(100, 50)
      ..position = Vector2(290, 755);
    add(optionsButton);

    add(totalGold());

    removeSplash();

    //check for animations and sounds and add them if appropriate (at bottom so not underneath the other screen components)
    //also adds the proper amount of passive gold needed based on save data
    if (purchases[1] >= 1) {
      passiveGold += purchases[1];
      add(Dwarf1Animations());
      playPickaxe = true;
    }
    if (purchases[2] >= 1) {
      passiveGold += purchases[2] * 10;
      add(Dwarf2Animations());
    }
    if (purchases[4] >= 1) {
      passiveGold += purchases[4] * 100;
      add(Dwarf3Animations()..flipHorizontally());
    }
    if (purchases[5] >= 1) {
      passiveGold += purchases[5] * 1000;
    }

    //background music
    FlameAudio.loopLongAudio(Globals.gameAmbience, volume: soundVolume);
  }

  //function to wait about 3 seconds to remove the splash screen from the app
  void removeSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  //game update function
  @override
  void update(double dt) {
    super.update(dt);
    timer += 1;
    saveTimer += 1;
    //use timer to randomly generate double gold power up coins
    //chance increases the longe rit has been since the last coin appeared
    if (Random().nextInt(1000000) < timer) {
      add(coin_component());
      timer = 0;
    }
    //save the gasme approx every minute
    if (saveTimer >= 3600) {
      //save players current gold
      prefs.setDouble("totalGold", gold);
      //remember current prices of the players upgrades
      for (int i = 0; i < prices.length; i++) {
        prefs.setDouble("prices" + i.toString(), prices[i]);
      }
      //remember how much of each upgrade has been purchased
      for (int i = 0; i < purchases.length; i++) {
        prefs.setInt("purchases" + i.toString(), purchases[i]);
      }
      saveTimer = 0;
    }
  }
}
