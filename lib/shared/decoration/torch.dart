import 'package:bonfire/bonfire.dart';

import 'package:flutter/material.dart';

import '../../manual_map/dungeon_map.dart';
import '../util/common_sprite_sheet.dart';

class Torch extends GameDecoration with Lighting {
  Torch(Vector2 position)
      : super.withAnimation(
          animation: CommonSpriteSheet.torchAnimated,
          size: Vector2.all(DungeonMap.tileSize),
          position: position,
        ) {
    setupLighting(
      LightingConfig(
        radius: width * 1.5,
        blurBorder: width * 1.5,
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
    );
  }
}
