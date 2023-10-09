import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:dumont_game/dumont/lpc/lpc_player.dart';
import 'package:dumont_game/map/dungeon_map.dart';
import 'package:dumont_game/shared/interface/dumont_interface.dart';
import 'package:dumont_game/shared/player/knight.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'lpc/lpc_sprite_sheet_loader.dart';

class GameDumont extends StatelessWidget {
  final int map;

  const GameDumont({Key? key, this.map = 2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        DungeonMap.tileSize = max(constraints.maxHeight, constraints.maxWidth) /
            (kIsWeb ? 55 : 22);
        return BonfireWidget(
          joystick: Joystick(
            keyboardConfig: KeyboardConfig(
              keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
              enable: true,
              acceptedKeys: [
                LogicalKeyboardKey.space,
              ],
            ),
            directional: JoystickDirectional(
              spriteBackgroundDirectional: Sprite.load(
                'joystick_background.png',
              ),
              spriteKnobDirectional: Sprite.load('joystick_knob.png'),
              size: 100,
              isFixed: false,
            ),
            actions: [
              // JoystickAction(
              //   actionId: PlayerAttackType.attackMelee,
              //   sprite: Sprite.load('joystick_atack.png'),
              //   align: JoystickActionAlign.BOTTOM_RIGHT,
              //   size: 80,
              //   margin: const EdgeInsets.only(bottom: 50, right: 50),
              // ),
              // JoystickAction(
              //   actionId: PlayerAttackType.attackRange,
              //   sprite: Sprite.load('joystick_atack_range.png'),
              //   spriteBackgroundDirection: Sprite.load(
              //     'joystick_background.png',
              //   ),
              //   enableDirection: true,
              //   size: 50,
              //   margin: const EdgeInsets.only(bottom: 50, right: 160),
              // )
            ],
          ),
          player: LPCPlayer(
            position: Vector2(Get.height * 0.5, Get.height * 0.55),
            customStatus: const CustomStatus(
              hair: LPCHairEnum.longknot,
              body: LPCBodyEnum.light,
              withFeet: true,
              withLeg: true,
            ),
          ),
          interface: KnightInterface(),
          map: WorldMapByTiled(
            'tiled/top_down/map.json',
          ),

          lightingColorGame: Colors.black.withOpacity(0.2),

          // initialActiveOverlays: const [
          //   'barLife',
          //   'miniMap',
          // ],
          cameraConfig: CameraConfig(
            zoom: 2.9,
            smoothCameraEnabled: true,
            smoothCameraSpeed: 2,
          ),
        );
      },
    );
  }
}
