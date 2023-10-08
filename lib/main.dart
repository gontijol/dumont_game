import 'package:bonfire/bonfire.dart';
import 'package:dumont_game/shared/player/knight_controller.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'dumont/game.dart';
import 'shared/enemy/goblin_controller.dart';
import 'shared/interface/bar_life_controller.dart';
import 'shared/npc/critter/critter_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }

  BonfireInjector().putFactory((i) => KnightController());
  BonfireInjector().putFactory((i) => GoblinController());
  BonfireInjector().putFactory((i) => CritterController());
  BonfireInjector().put((i) => BarLifeController());

  runApp(
    const MaterialApp(
      home: Menu(),
    ),
  );
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                    child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Opacity(
                        opacity: 0.25,
                        child: Image.asset(
                          'assets/images/hs8336.png',
                          width: Get.width * 0.25,
                          height: Get.width * 0.25,
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: Image.asset(
                          'assets/images/arrow.png',
                          width: Get.width * 0.05,
                          height: Get.width * 0.05,
                        ),
                      ),
                      Image.asset(
                        'assets/images/tw3337.png',
                        width: Get.width * 0.25,
                        height: Get.width * 0.25,
                      ),
                      Image.asset(
                        'assets/images/arrow.png',
                        width: Get.width * 0.05,
                        height: Get.width * 0.05,
                      ),
                      Opacity(
                        opacity: 0.25,
                        child: Image.asset(
                          'assets/images/mx2090.png',
                          width: Get.width * 0.25,
                          height: Get.width * 0.25,
                        ),
                      ),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 40,
                ),
                SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      // _buildButton(context, 'Simple example', () {
                      //   _navTo(context, const SimpleExampleGame());
                      // }),
                      // const SizedBox(
                      //   height: 10,
                      // ),

                      _buildButton(context, 'INICIAR', () async {
                        _navTo(context, const GameDumont());
                        AudioPlayer audioPlayer = AudioPlayer();
                        await audioPlayer.setAsset('audio/ambient.mp3');
                        await audioPlayer.play();
                        await audioPlayer.setLoopMode(LoopMode.all);
                      }),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // _buildButton(context, 'Random Map', () {
                      //   _navTo(
                      //     context,
                      //     RandomMapGame(
                      //       size: Vector2(150, 150),
                      //     ),
                      //   );
                      // }),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // _buildButton(context, 'Tiled Map', () {
                      //   _navTo(context, const GameTiledMap());
                      // }),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // _buildButton(context, 'Top down game', () {
                      //   _navTo(context, const TopDownGame());
                      // }),
                      // const SizedBox(
                      //   height: 10,
                      // ),

                      // if (!kIsWeb) ...[
                      //   const SizedBox(
                      //     height: 10,
                      //   ),
                      //   _buildButton(context, 'Dynamic spriteSheet', () async {
                      //     _navTo(context, const LPCGame());
                      //   }),
                      // ]
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, VoidCallback onTap) {
    return SizedBox(
      width: Get.width * 0.25,
      height: Get.height * 0.05,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF0b0828)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }

  void _navTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
