import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stack_RPG/stack_rpg_game.dart';
import 'package:stack_RPG/components/world/map.dart';

enum Type { card, character, item, goal }

abstract class Card extends PositionComponent with CollisionCallbacks {
  // Card characteristic
  Type type;
  double width;
  double height;
  final double round = 50.0;
  int positionX;
  int positionY;
  late Map? map;

  final _defaultColor = Colors.orange;

  bool addable = false; // can be used by another card.

  // Card constructor
  Card({
    this.type = Type.card,
    this.width = 1000.0,
    this.height = 1000.0,
    this.positionX = 0,
    this.positionY = 0,
    this.map,
  }) : super(
            size: Vector2(width, height),
            position: new Vector2(
              StackRPGGame.landGap + positionX * (width + StackRPGGame.landGap),
              StackRPGGame.landGap +
                  positionY * (height + StackRPGGame.landGap),
            ));

  @override
  Future<void> onLoad() async {
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;
    RectangleHitbox hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
  }

  void moveUpBy1() {
    positionY -= 1;
    position[1] -= height + StackRPGGame.landGap;
  }

  void moveDownBy1() {
    positionY += 1;
    position[1] += height + StackRPGGame.landGap;
  }

  void moveLeftBy1() {
    positionX -= 1;
    position[0] -= width + StackRPGGame.landGap;
  }

  void moveRightBy1() {
    positionX += 1;
    position[0] += width + StackRPGGame.landGap;
  }

  List<int> getPosition() {
    return [positionX, positionY];
  }

  void setMap(Map map) {
    this.map = map;
  }

  Map getMap() {
    return map!;
  }
}
