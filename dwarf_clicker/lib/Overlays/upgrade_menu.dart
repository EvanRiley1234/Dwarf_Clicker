import 'package:dwarf_clicker/Components/dwarf_1_component.dart';
import 'package:dwarf_clicker/Components/dwarf_2_component.dart';
import 'package:dwarf_clicker/Components/dwarf_3_component.dart';
import 'package:flutter/material.dart';
import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:google_fonts/google_fonts.dart';

class UpgradeMenu extends StatelessWidget {
  //reference to game to use throughout menu
  final DwarfClicker game;
  const UpgradeMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    return Material(
      child: Center(
        //main container holding all of the upgrade cards
        child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 500,
            width: 300,
            decoration: const BoxDecoration(
              color: blackTextColor,
              borderRadius: BorderRadius.all(
                Radius.elliptical(20, 20),
              ),
            ),
            //list of upgrades and exit button for the game
            child: ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: Text('Exit', style: GoogleFonts.gemunuLibre()),
                    onTap: () {
                      game.overlays.remove('UpgradeMenu');
                    },
                  ),
                ),
                //first upgrade to increase gold per click
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.update),
                    title: Text('Sharper Steel - ' + game.prices[0].toString(),
                        style: GoogleFonts.gemunuLibre()),
                    subtitle: const Text('Increase gold per click'),
                    onTap: () {
                      //checks if player has enough gold to purchase
                      if (game.gold >= game.prices[0]) {
                        //if they have enough gold subtract it
                        game.gold = game.gold - game.prices[0];
                        //increase tpa mulltiplier since its a click upgrade
                        game.tapMultiplier += 1;
                        //increase the price of the upgrade
                        game.prices[0] =
                            (game.prices[0] * 1.5).round().toDouble();
                        //update how many times it has been purchased for purpose of saving the game
                        game.purchases[0] += 1;
                      }
                      //updatre screen
                      update();
                    },
                  ),
                ),
                //second upgrade to increase passive gold also adds an animation and enables the sound effect that goes with it
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.update),
                    title: Text('Helping Hands - ' + game.prices[1].toString(),
                        style: GoogleFonts.gemunuLibre()),
                    subtitle: const Text('Earn gold passively'),
                    onTap: () {
                      //check to see if upgrade can be purchased
                      if (game.gold >= game.prices[1]) {
                        //check if its the first pruchase and if so add animation and enable sound effect
                        if (game.prices[1] == game.pricesDefault[1]) {
                          game.add(Dwarf1Animations());
                          game.playPickaxe = true;
                        }
                        //subtract prices from total gold
                        game.gold = game.gold - game.prices[1];
                        //increase passive gold
                        game.passiveGold += 1;
                        //update price of upgrade
                        game.prices[1] =
                            (game.prices[1] * 1.5).round().toDouble();
                        //increase number of purchases for saving purposes
                        game.purchases[1] += 1;
                      }
                      //update screen
                      update();
                    },
                  ),
                ),
                //third upgrade also for passive gold, also has an animation see upgrade [1] for notes on on tap
                Card(
                  child: ListTile(
                    leading: Icon(Icons.update),
                    title: Text('More Miners - ' + game.prices[2].toString(),
                        style: GoogleFonts.gemunuLibre()),
                    subtitle: const Text('Earn 10 more gold passively'),
                    onTap: () {
                      if (game.gold >= game.prices[2]) {
                        if (game.prices[2] == game.pricesDefault[2]) {
                          game.add(Dwarf2Animations());
                        }
                        game.gold = game.gold - game.prices[2];
                        game.passiveGold += 10;
                        game.prices[2] =
                            (game.prices[2] * 1.5).round().toDouble();
                        game.purchases[2] += 1;
                      }
                      update();
                    },
                  ),
                ),
                //fourth upgrade to increase gold per click see upgrade [0] for notes on on tap
                Card(
                  child: ListTile(
                    leading: Icon(Icons.update),
                    title: Text('Heftier hafts- ' + game.prices[3].toString(),
                        style: GoogleFonts.gemunuLibre()),
                    subtitle: const Text('Earn 10 more gold per click'),
                    onTap: () {
                      if (game.gold >= game.prices[3]) {
                        game.gold = game.gold - game.prices[3];
                        game.tapMultiplier += 10;
                        game.prices[3] =
                            (game.prices[3] * 1.5).round().toDouble();
                        game.purchases[3] += 1;
                      }
                      update();
                    },
                  ),
                ),
                //fifth upgrade to increase passive gold see upgrade [1] for notes on on tap
                Card(
                  child: ListTile(
                    leading: Icon(Icons.update),
                    title: Text(
                        'Dwarven Digging - ' + game.prices[4].toString(),
                        style: GoogleFonts.gemunuLibre()),
                    subtitle: const Text('Earn 100 more gold passively'),
                    onTap: () {
                      if (game.gold >= game.prices[4]) {
                        if (game.prices[4] == game.pricesDefault[4]) {
                          game.add(Dwarf3Animations());
                        }
                        game.gold = game.gold - game.prices[4];
                        game.passiveGold += 100;
                        game.prices[4] =
                            (game.prices[4] * 1.5).round().toDouble();
                        game.purchases[4] += 1;
                      }
                      update();
                    },
                  ),
                ),
                //sixth upgrade to increase passive gold and a troll see upgrade [1] for notes on on tap
                Card(
                  child: ListTile(
                    leading: Icon(Icons.update),
                    title: Text('A Cave Troll! - ' + game.prices[5].toString(),
                        style: GoogleFonts.gemunuLibre()),
                    subtitle: const Text('But he is friendly'),
                    onTap: () {
                      if (game.gold >= game.prices[5]) {
                        game.gold = game.gold - game.prices[5];
                        game.passiveGold += 1000;
                        game.prices[5] =
                            (game.prices[5] * 1.5).round().toDouble();
                        game.purchases[5] += 1;
                      }
                      update();
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  //update screen so the number on buttons refresh
  void update() {
    game.overlays.remove('UpgradeMenu');
    game.overlays.add('UpgradeMenu');
  }
}
