// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/backend/models/move.dart';
import 'package:tic_tac_toe/backend/providers/provider_game_engine.dart';
import 'package:tic_tac_toe/backend/utils/enums.dart';

void main() {
  test("game engine test", () {
    final GameEngineProvider sut = GameEngineProvider();

    expect(sut.gameResult, GameResult.notStartedYet);
    expect(sut.currentPlayer, isNull);

    sut.startGame();
    expect(sut.currentPlayer, Player.one);
    expect(sut.gameResult, GameResult.notStartedYet);
    expect(sut.moveCount, 0);

    sut.registerMove(Move(player: Player.one, row: 2, column: 2));
    expect(sut.currentPlayer, Player.two);
    expect(sut.getMoveData(2, 2), isNotNull);
    expect(sut.getMoveData(2, 2), Player.one);
    expect(sut.moveCount, 1);
    expect(sut.gameResult, GameResult.onging);
  });
}
