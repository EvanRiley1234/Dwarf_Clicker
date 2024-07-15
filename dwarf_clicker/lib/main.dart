import 'package:dwarf_clicker/Overlays/options_menu.dart';
import 'package:dwarf_clicker/Overlays/upgrade_menu.dart';
import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //main app start uses overlay builder for the two menus in game
  runApp(GameWidget<DwarfClicker>.controlled(
    gameFactory: DwarfClicker.new,
    overlayBuilderMap: {
      'UpgradeMenu': (_, game) => UpgradeMenu(game: game),
      'OptionsMenu': (_, game) => OptionsMenu(game: game)
    },
  ));
}
