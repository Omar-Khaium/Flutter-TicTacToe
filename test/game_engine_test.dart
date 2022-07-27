import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/backend/models/move.dart';
import 'package:tic_tac_toe/backend/providers/provider_game_engine.dart';
import 'package:tic_tac_toe/backend/utils/enums.dart';

void main() {
  test("game engine test", () {
    final GameEngineProvider sut = GameEngineProvider();

    expect(sut.gameResult, GameResult.notStartedYet);
    expect(sut.currentPlayer, isNull);

    //!   1 2 3
    //! 1 . . .
    //! 2 . . .
    //! 3 . . .
    sut.startGame();
    expect(sut.currentPlayer, Player.one);
    expect(sut.gameResult, GameResult.notStartedYet);
    expect(sut.moveCount, 0);

    //!   1 2 3
    //! 1 . . .
    //! 2 . X .
    //! 3 . . .
    sut.registerMove(Move(player: Player.one, row: 2, column: 2));
    expect(sut.currentPlayer, Player.two);
    expect(sut.getMoveData(2, 2), isNotNull);
    expect(sut.getMoveData(2, 2), Player.one);
    expect(sut.moveCount, 1);
    expect(sut.gameResult, GameResult.onging);

    //!   1 2 3
    //! 1 . . .
    //! 2 O X .
    //! 3 . . .
    sut.registerMove(Move(player: Player.two, row: 2, column: 1));
    expect(sut.currentPlayer, Player.one);
    expect(sut.getMoveData(2, 1), isNotNull);
    expect(sut.getMoveData(2, 1), Player.two);
    expect(sut.moveCount, 2);
    expect(sut.gameResult, GameResult.onging);

    //!   1 2 3
    //! 1 X . .
    //! 2 O X .
    //! 3 . . .
    sut.registerMove(Move(player: Player.one, row: 1, column: 1));
    expect(sut.currentPlayer, Player.two);
    expect(sut.getMoveData(1, 1), isNotNull);
    expect(sut.getMoveData(1, 1), Player.one);
    expect(sut.moveCount, 3);
    expect(sut.gameResult, GameResult.onging);

    //!   1 2 3
    //! 1 X . .
    //! 2 O X .
    //! 3 . . O
    sut.registerMove(Move(player: Player.two, row: 3, column: 3));
    expect(sut.currentPlayer, Player.one);
    expect(sut.getMoveData(3, 3), isNotNull);
    expect(sut.getMoveData(3, 3), Player.two);
    expect(sut.moveCount, 4);
    expect(sut.gameResult, GameResult.onging);

    //!   1 2 3
    //! 1 X . X
    //! 2 O X .
    //! 3 . . O
    sut.registerMove(Move(player: Player.one, row: 1, column: 3));
    expect(sut.currentPlayer, Player.two);
    expect(sut.getMoveData(1, 3), isNotNull);
    expect(sut.getMoveData(1, 3), Player.one);
    expect(sut.moveCount, 5);
    expect(sut.gameResult, GameResult.onging);

    //!   1 2 3
    //! 1 X . X
    //! 2 O X .
    //! 3 O . O
    sut.registerMove(Move(player: Player.two, row: 3, column: 1));
    expect(sut.currentPlayer, Player.one);
    expect(sut.getMoveData(3, 1), isNotNull);
    expect(sut.getMoveData(3, 1), Player.two);
    expect(sut.moveCount, 6);
    expect(sut.gameResult, GameResult.onging);

    //!   1 2 3
    //! 1 X X X
    //! 2 O X .
    //! 3 O . O
    sut.registerMove(Move(player: Player.one, row: 1, column: 2));
    expect(sut.currentPlayer, Player.two);
    expect(sut.getMoveData(1, 2), isNotNull);
    expect(sut.getMoveData(1, 2), Player.one);
    expect(sut.moveCount, 7);
    expect(sut.gameResult, GameResult.player1Won);
  });
}
