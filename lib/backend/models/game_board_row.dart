import 'package:tic_tac_toe/backend/utils/enums.dart';

import 'move.dart';

class GameBoardRow {
  late Map<int, Player?> columns;

  GameBoardRow() {
    columns = {
      1: null,
      2: null,
      3: null,
    };
  }

  void setMove(Move move) {
    columns[move.column] = move.player;
  }
}
