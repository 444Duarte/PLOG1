% Triangle on the right
validCoords(BOARD, COLUMN, ROW) :-  C1 is COLUMN + 1,
                                    getTriangle(BOARD, C1, ROW, [_ | PLAYER]),
                                    PLAYER \= 0.
% Triangle on the left
validCoords(BOARD, COLUMN, ROW) :-  C1 is COLUMN - 1,
                                    getTriangle(BOARD, C1, ROW, [_ | PLAYER]),
                                    PLAYER \= 0.
% Triangle on the top
validCoords(BOARD, COLUMN, ROW) :-  R1 is ROW - 1,
                                    getTriangle(BOARD, COLUMN, R1, [TYPE | PLAYER]),
                                    TYPE == 1,
                                    PLAYER \= 0.
% Triangle on the bottom
validCoords(BOARD, COLUMN, ROW) :-  R1 is ROW + 1,
                                    getTriangle(BOARD, COLUMN, R1, [TYPE | PLAYER]),
                                    TYPE == 2,
                                    PLAYER \= 0.
% Check if a player is winner (we assume triangles are already with the right type (▼ ▲ ) 
%  ▲ 
% ▲▽▲  player has played the left corner triangle
isWinner(BOARD, PLAYER, COLUMN, ROW) :- getTriangle(BOARD, COLUMN, ROW, [TYPE | PLAYER]),
                                        TYPE == 1,
                                        C1 is COLUMN + 1,
                                        getTriangle(BOARD, C1, ROW, [_ | P1]), % get middle triangle
                                        P1 \= 0, % middle piece can't be empty
                                        C2 is C1 + 1,
                                        getTriangle(BOARD, C2, ROW, [_ | PLAYER]), % get right corner triangle, player must be the same
                                        R1 is ROW - 1,
                                        getTriangle(BOARD, C1, R1, [_ | PLAYER]). % get top triangle, player must be the same
%  ▲ 
% ▲▼▲  player has played the middle triangle
isWinner(BOARD, PLAYER, COLUMN, ROW) :- getTriangle(BOARD, COLUMN, ROW, [TYPE | PLAYER]),
                                        TYPE == 2,
                                        C1 is COLUMN - 1,
                                        getTriangle(BOARD, C1, ROW, [_ | PLAYER]), % get left corner triangle
                                        C2 is COLUMN + 1,
                                        getTriangle(BOARD, C2, ROW, [_ | PLAYER]), % get right corner triangle, player must be the same
                                        R1 is ROW - 1,
                                        getTriangle(BOARD, COLUMN, R1, [_ | PLAYER]). % get top triangle, player must be the same
%  ▲ 
% ▲▽▲  player has played the right corner triangle
isWinner(BOARD, PLAYER, COLUMN, ROW) :- getTriangle(BOARD, COLUMN, ROW, [TYPE | PLAYER]),
                                        TYPE == 1,
                                        C1 is COLUMN - 1,
                                        getTriangle(BOARD, C1, ROW, [_ | P1]), % get middle triangle
                                        P1 \= 0, % middle piece can't be empty
                                        C2 is C1 - 1,
                                        getTriangle(BOARD, C2, ROW, [_ | PLAYER]), % get left corner triangle, player must be the same
                                        R1 is ROW - 1,
                                        getTriangle(BOARD, C1, R1, [_ | PLAYER]). % get top triangle, player must be the same 
%  ▲ 
% ▲▽▲  player has played the top corner triangle
isWinner(BOARD, PLAYER, COLUMN, ROW) :- getTriangle(BOARD, COLUMN, ROW, [TYPE | PLAYER]),
                                        TYPE == 1,
                                        R1 is ROW + 1,
                                        getTriangle(BOARD, COLUMN, R1, [_ | P1]), % get middle triangle
                                        P1 \= 0, % middle piece can't be empty
                                        C1 is COLUMN - 1,
                                        getTriangle(BOARD, C1, R1, [_ | PLAYER]), % get left corner triangle, player must be the same
                                        C2 is COLUMN + 1,
                                        getTriangle(BOARD, C2, R1, [_ | PLAYER]). % get right corner triangle, player must be the same 
% ▼△▼
%  ▼   player has played the left corner triangle
isWinner(BOARD, PLAYER, COLUMN, ROW) :- getTriangle(BOARD, COLUMN, ROW, [TYPE | PLAYER]),
                                        TYPE == 2,
                                        C1 is COLUMN + 1,
                                        getTriangle(BOARD, C1, ROW, [_ | P1]), % get middle triangle
                                        P1 \= 0, % middle piece can't be empty
                                        C2 is C1 + 1,
                                        getTriangle(BOARD, C2, ROW, [_ | PLAYER]), % get right corner triangle, player must be the same
                                        R1 is ROW + 1,
                                        getTriangle(BOARD, C1, R1, [_ | PLAYER]). % get bottom triangle, player must be the same
% ▼▲▼
%  ▼   player has played the middle triangle
isWinner(BOARD, PLAYER, COLUMN, ROW) :- getTriangle(BOARD, COLUMN, ROW, [TYPE | PLAYER]),
                                        TYPE == 1,
                                        C1 is COLUMN - 1,
                                        getTriangle(BOARD, C1, ROW, [_ | PLAYER]), % get left corner triangle
                                        C2 is COLUMN + 1,
                                        getTriangle(BOARD, C2, ROW, [_ | PLAYER]), % get right corner triangle, player must be the same
                                        R1 is ROW + 1,
                                        getTriangle(BOARD, COLUMN, R1, [_ | PLAYER]). % get bottom triangle, player must be the same
% ▼△▼
%  ▼   player has played the right corner triangle
isWinner(BOARD, PLAYER, COLUMN, ROW) :- getTriangle(BOARD, COLUMN, ROW, [TYPE | PLAYER]),
                                        TYPE == 2,
                                        C1 is COLUMN - 1,
                                        getTriangle(BOARD, C1, ROW, [_ | P1]), % get middle triangle
                                        P1 \= 0, % middle piece can't be empty
                                        C2 is C1 - 1,
                                        getTriangle(BOARD, C2, ROW, [_ | PLAYER]), % get left corner triangle, player must be the same
                                        R1 is ROW + 1,
                                        getTriangle(BOARD, C1, R1, [_ | PLAYER]). % get bottom triangle, player must be the same
% ▼△▼
%  ▼   player has played the bottom triangle
isWinner(BOARD, PLAYER, COLUMN, ROW) :- getTriangle(BOARD, COLUMN, ROW, [TYPE | PLAYER]),
                                        TYPE == 2,
                                        R1 is ROW - 1,
                                        getTriangle(BOARD, COLUMN, R1, [_ | P1]), % get middle triangle
                                        P1 \= 0, % middle piece can't be empty
                                        C1 is COLUMN - 1,
                                        getTriangle(BOARD, C1, R1, [_ | PLAYER]), % get left corner triangle, player must be the same
                                        C2 is COLUMN + 1,
                                        getTriangle(BOARD, C2, R1, [_ | PLAYER]). % get right corner triangle, player must be the same


% Check if a player is winner                            
checkWinner(BOARD,PLAYER):- checkWinnerRow(BOARD, 0, BOARD, PLAYER).

checkWinnerRow(_, _, [], _):- false.
checkWinnerRow(BOARD, ROW, [CURR_ROW|NEXT_ROW], PLAYER):-   ((R is ROW+1, checkWinnerRow(BOARD, R, NEXT_ROW, PLAYER)) ;
                                                             startCheckWinnerCol(BOARD, ROW, CURR_ROW, PLAYER)).


startCheckWinnerCol(BOARD, ROW , [FIRST_ROW|SECOND_ROW], PLAYER):- checkWinnerCol(BOARD, 1, ROW, FIRST_ROW, SECOND_ROW, PLAYER).


%
checkWinnerCol(_, _, _, _, [_|[]], _):- false.

checkWinnerCol(BOARD, COL, ROW, _, [CURR_CELL|NEXT_CELL], PLAYER):-     C is COL+1,
                                                                        checkWinnerCol(BOARD, C, ROW, CURR_CELL, NEXT_CELL, PLAYER).
checkWinnerCol(BOARD, COL, ROW, PREVIOUS_CELL, [_|NEXT_CELL], PLAYER):- checkWinnerCell(BOARD, COL, ROW, PREVIOUS_CELL, NEXT_CELL, PLAYER).

checkWinnerCell(BOARD,COL, ROW, [_|PLAYER_LEFT], [[_|PLAYER_RIGHT]|_], PLAYER):-  PLAYER_LEFT =\= 0,
                                                                              PLAYER_LEFT == PLAYER_RIGHT,
                                                                              R is ROW+1,
                                                                              getTriangle(BOARD, COL, R, [TYPE|PLAYER]),
                                                                              [TYPE|PLAYER] \= [],
                                                                              PLAYER == PLAYER_LEFT,
                                                                              TYPE == 2.

checkWinnerCell(BOARD,COL, ROW, [_|PLAYER_LEFT], [[_|PLAYER_RIGHT]|_], PLAYER):-  ROW > 0,
                                                                              PLAYER_LEFT =\= 0,
                                                                              PLAYER_LEFT =:= PLAYER_RIGHT,
                                                                              R is ROW-1,
                                                                              getTriangle(BOARD, COL, R, [TYPE|PLAYER]),
                                                                              PLAYER =:= PLAYER_LEFT,
                                                                              TYPE =:= 1.
