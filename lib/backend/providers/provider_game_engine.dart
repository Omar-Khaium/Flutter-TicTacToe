import 'package:flutter/material.dart';
import 'package:tic_tac_toe/backend/models/move.dart';
import 'package:tic_tac_toe/backend/utils/enums.dart';

import '../models/game_board_row.dart';

class GameEngineProvider extends ChangeNotifier {
  //!--------------------------------------------------------
  //? game properties started

  Map<int, GameBoardRow> gameBoard = {
    1: GameBoardRow(),
    2: GameBoardRow(),
    3: GameBoardRow(),
  };

  Player? currentPlayer;

  GameResult gameResult = GameResult.notStartedYet;

  //? game properties ended
  //!--------------------------------------------------------

  //!--------------------------------------------------------
  //? game life-cycle started
  void startGame() {
    //* * reset gameResult to GameResult.notStartedYet
    initGameResult();

    //* * switch currentPlaer to Player.one
    switchCurrentPlayer();

    //* * reset gameBoard
    resetGameBoard();
  }

  void initGameResult() {
    // * * switching gameResult to GameResult.notStartedYet as game just only begun and no move has been played
    gameResult = GameResult.notStartedYet;
    notifyListeners();
  }

  void switchCurrentPlayer() {
    if (currentPlayer == null) {
      //* * game is just started, as per logic, first move will be played by Player.one
      currentPlayer = Player.one;
      notifyListeners();
    } else {
      //* * switching currentPlayer by toggling the last value
      currentPlayer = currentPlayer == Player.one ? Player.two : Player.one;
      notifyListeners();
    }
  }

  void registerMove(Move move) {
    //* *validated move
    if (isValidMove(move)) {
      gameBoard[move.row]?.setMove(move);

      //* * switch currentPlayer as new move is alredy registered
      switchCurrentPlayer();

      //* evaluate the game as new input is registered
      evaluteGame();
    } else {
      //TODO: if no valid, throw InvalidMoveException
    }
  }

  bool isValidMove(Move move) {
    //* * making sure that this specific block is never played before by getting null on that row and column
    bool isThisMoveNeverPlayerBefore = getMoveData(move.row, move.column) == null;

    //* * this move is only valid if current player is the move's player
    bool thisMoveIsPlayedCurrentPlayer = currentPlayer == move.player;

    //* * if this move is never played before and move's player is the current player, then, surely it's a valid move
    return isThisMoveNeverPlayerBefore && thisMoveIsPlayedCurrentPlayer;
  }

  void evaluteGame() {
    if (isThisWholeRowPlayedByThisPlayer(Player.one, 1) ||
        isThisWholeRowPlayedByThisPlayer(Player.one, 2) ||
        isThisWholeRowPlayedByThisPlayer(Player.one, 3) ||
        isThisWholeColumnPlayedByThisPlayer(Player.one, 1) ||
        isThisWholeColumnPlayedByThisPlayer(Player.one, 2) ||
        isThisWholeColumnPlayedByThisPlayer(Player.one, 3) ||
        isWholeRTLDiagonalColumnPlayedByThisPlayer(Player.one) ||
        isWholeLTRDiagonalColumnPlayedByThisPlayer(Player.one)) {
      gameResult = GameResult.player1Won;
      notifyListeners();
    } else if (isThisWholeRowPlayedByThisPlayer(Player.two, 1) ||
        isThisWholeRowPlayedByThisPlayer(Player.two, 2) ||
        isThisWholeRowPlayedByThisPlayer(Player.two, 3) ||
        isThisWholeColumnPlayedByThisPlayer(Player.two, 1) ||
        isThisWholeColumnPlayedByThisPlayer(Player.two, 2) ||
        isThisWholeColumnPlayedByThisPlayer(Player.two, 3) ||
        isWholeRTLDiagonalColumnPlayedByThisPlayer(Player.two) ||
        isWholeLTRDiagonalColumnPlayedByThisPlayer(Player.two)) {
      gameResult = GameResult.player2Won;
      notifyListeners();
    } else {
      if (moveCount == 9) {
        gameResult = GameResult.draw;
        notifyListeners();
      } else {
        gameResult = GameResult.onging;
        notifyListeners();
      }
    }
  }

  bool isThisWholeRowPlayedByThisPlayer(Player player, int row) =>
      getMoveData(row, 1) == player && getMoveData(row, 2) == player && getMoveData(row, 3) == player;

  bool isThisWholeColumnPlayedByThisPlayer(Player player, int column) =>
      getMoveData(1, column) == player && getMoveData(2, column) == player && getMoveData(3, column) == player;
  bool isWholeRTLDiagonalColumnPlayedByThisPlayer(Player player) =>
      getMoveData(1, 1) == player && getMoveData(2, 2) == player && getMoveData(3, 3) == player;
  bool isWholeLTRDiagonalColumnPlayedByThisPlayer(Player player) =>
      getMoveData(3, 1) == player && getMoveData(2, 2) == player && getMoveData(1, 3) == player;

  void resetGameBoard() {
    //* * just reinitialising gameBoard to its default state
    gameBoard = {
      1: GameBoardRow(),
      2: GameBoardRow(),
      3: GameBoardRow(),
    };

    notifyListeners();
  }
  //? game life-cycle ended
  //!--------------------------------------------------------

  //!--------------------------------------------------------
  //? game behavior started

  Player? getMoveData(int row, int column) => gameBoard[row]?.columns[column];

  int get moveCount {
    List<Player?> moves = [];
    for (var element in gameBoard.values) {
      moves.addAll(element.columns.values.where((element) => element != null).toList());
    }
    return moves.length;
  }
  //? game behavior ended
  //!--------------------------------------------------------
}
