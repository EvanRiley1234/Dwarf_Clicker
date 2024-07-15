import 'package:dwarf_clicker/games/dwarf_clicker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionsMenu extends StatelessWidget {
  final DwarfClicker game;
  const OptionsMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    //string for html page with documentation which works on pc but not emulator for some odd reason
    //as such documentation is going to be submitted with project
    String url =
        "https://people.rit.edu/ecr3000/235/DocumentationHTML/pdf_page.html";
    //const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      child: Center(
        child: Container(
          //listview contianer
          padding: const EdgeInsets.all(10.0),
          height: 500,
          width: 300,
          decoration: const BoxDecoration(
            color: blackTextColor,
            borderRadius: BorderRadius.all(
              Radius.elliptical(20, 20),
            ),
          ),
          //exit button
          child: ListView(children: <Widget>[
            Card(
              child: ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: Text('Exit', style: GoogleFonts.gemunuLibre()),
                onTap: () {
                  //removes overlay to exit
                  game.overlays.remove('OptionsMenu');
                },
              ),
            ),
            //clears prefs incase player wants to restart their game
            Card(
              child: ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: Text('Clear Data', style: GoogleFonts.gemunuLibre()),
                onTap: () {
                  game.prefs.clear();
                },
              ),
            ),
            //shows documentation but website doesn't work appropriatly in the emulator browser
            Card(
              child: ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: Text('View Documentation',
                    style: GoogleFonts.gemunuLibre()),
                onTap: () async {
                  if (!await launchUrl(Uri.parse(url))) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
