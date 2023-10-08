import 'package:bonfire/bonfire.dart';
import 'package:example/shared/enemy/goblin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KnightInterface extends GameInterface {
  static const followerWidgetTestId = 'BUTTON';
  Goblin? enemyControlled;
//TODO: PROCESSO DE CRIAÇÃO DE INTERFACE
  @override
  void onMount() async {
    // await add(BarLifeInterface());

    double j = 0.30;
    await add(
      InterfaceComponent(
        spriteUnselected: Sprite.load('planet_life.png'),
        size: Vector2(Get.height * 0.2, Get.height * 0.2),
        id: 88,
        position: Vector2(Get.width * 0.1, Get.height - Get.height * 0.25),
      ),
    );
    //TODO: BARRA DE STATUS ( ATMOSFERA, OXIGÊNIO, TEMPERATURA, PRESSÃO ATMOSFÉRICA, RADIAÇÃO, GRAVIDADE, MAGNETISMO, ETC) IMPLEMENTAR DEPOIS
    await add(
      InterfaceComponent(
        spriteUnselected: Sprite.load('bar_stats.png'),
        size: Vector2(Get.width * 0.08, Get.height * 0.55),
        id: 88,
        position: Vector2(Get.width * 0.1, Get.height * 0.1),
      ),
    );
    for (int i = 0; i < 6; i++) {
      j = j + 0.055;
      await add(InterfaceComponent(
        spriteUnselected: Sprite.load('blue_button1.png'),
        spriteSelected: Sprite.load('blue_button2.png'),
        size: Vector2(Get.height * 0.1, Get.height * 0.1),
        selectable: true,
        id: i,
        position: Vector2(Get.width * j, Get.height - Get.height * 0.15),
        onTapComponent: (selected) {
          _addFollowerWidgetExample(selected);
        },
      ));

      // print('teste');
    }
    await add(
      InterfaceComponent(
        spriteUnselected: Sprite.load('health_ui_dumont.png'),
        size: Vector2(Get.height * 0.2, Get.height * 0.2),
        id: 89,
        position: Vector2(Get.width * 0.8, Get.height - Get.height * 0.25),
      ),
    );
    super.onMount();
  }

  void changeControllerToVisibleEnemy() {
    if (hasGameRef && !gameRef.camera.isMoving) {
      if (enemyControlled == null) {
        final v = gameRef.visibleComponentsByType<Goblin>();
        if (v.isNotEmpty) {
          enemyControlled = v.first;
          enemyControlled?.controller.enableBehaviors = false;
          gameRef.addJoystickObserver(
            enemyControlled!,
            cleanObservers: true,
            moveCameraToTarget: true,
          );
        }
      } else if (gameRef.player != null) {
        gameRef.addJoystickObserver(
          gameRef.player!,
          cleanObservers: true,
          moveCameraToTarget: true,
        );
        enemyControlled?.controller.enableBehaviors = true;
        enemyControlled = null;
      }
    }
  }

  void _showDialogTest(VoidCallback completed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('AwaitCallbackSceneAction test'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      completed();
                    },
                    child: const Text('CONTINUE'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      gameRef.stopScene();
                    },
                    child: const Text('STOP SCENE'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _startSceneExample() {
    final enemiesVisible = gameRef.visibleEnemies();
    if (gameRef.player != null && enemiesVisible.isNotEmpty) {
      final enemy = enemiesVisible.first;
      gameRef.startScene(
        [
          CameraSceneAction.position(Vector2(800, 800)),
          CameraSceneAction.target(gameRef.player!),
          CameraSceneAction.target(enemy, zoom: 2),
          DelaySceneAction(const Duration(seconds: 2)),
          MoveComponentSceneAction(
            component: enemy,
            newPosition: enemy.position.clone()..add(Vector2(-40, -10)),
            speed: 20,
          ),
          CameraSceneAction.target(gameRef.player!, zoom: 1),
          AwaitCallbackSceneAction(
            completedCallback: (completed) {
              _showDialogTest(completed);
            },
          ),
          MoveComponentSceneAction(
            component: gameRef.player!,
            newPosition: gameRef.player!.position.clone()..add(Vector2(0, -20)),
            speed: 100,
          ),
          MoveComponentSceneAction(
            component: gameRef.player!,
            newPosition: gameRef.player!.position.clone()
              ..add(Vector2(50, -20)),
            speed: 100,
          ),
          CameraSceneAction.target(enemy),
          CameraSceneAction.position(Vector2(200, 200)),
          CameraSceneAction.position(Vector2(0, 200)),
          CameraSceneAction.target(gameRef.player!),
        ],
      );
    }
  }

  void _addFollowerWidgetExample(bool selected) {
    if (!selected && FollowerWidget.isVisible(followerWidgetTestId)) {
      FollowerWidget.remove(followerWidgetTestId);
      return;
    }
    gameRef.player?.let((player) {
      FollowerWidget.show(
        identify: followerWidgetTestId,
        context: context,
        target: player,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showDialogTest(() {
                    FollowerWidget.remove(followerWidgetTestId);
                  });
                  // ignore: avoid_print
                  print('Tapped');
                },
                child: const Text('Opção N'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _showDialogTest(() {
                    FollowerWidget.remove(followerWidgetTestId);
                  });
                  // ignore: avoid_print
                  print('Tapped');
                },
                child: const Text('Opção N'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // ignore: avoid_print
                  print('Tapped');
                  _showDialogTest(() {
                    FollowerWidget.remove(followerWidgetTestId);
                  });
                },
                child: const Text('Opção N'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // ignore: avoid_print
                  print('Tapped');
                },
                child: const Text('Opção N'),
              ),
            ],
          ),
        ),
        align: Offset(Get.width * -0.06, Get.height * -0.025),
      );
    });
  }

  void _animateColorFilter() {
    if (gameRef.colorFilter?.config.color == null) {
      gameRef.colorFilter?.animateTo(
        Colors.red.withOpacity(0.5),
      );
    } else {
      gameRef.colorFilter?.animateTo(Colors.transparent, onFinish: () {
        gameRef.colorFilter?.config.color = null;
      });
    }
  }
}
