:- use_module(library(random)).

% Generate a random coordinate
getRandomCoord(BOARD, COLUMN, ROW) :-   getNumberRows(BOARD, NROWS),
                                        randomRow(NROWS, R1),
                                        getNumberCols(BOARD, NCOLS),
                                        randomColumn(NCOLS, C1),
                                        (validCoords(BOARD, C1, R1) ->
                                                COLUMN is C1,
                                                ROW is R1;
                                                !,
                                                getRandomCoord(BOARD, COLUMN, ROW)).
% Random column between 0 and number columns
randomColumn(NCOLS, RESULT) :-  MAX_COL is NCOLS - 1,
                                random(0, MAX_COL, RESULT).
% Random row between 0 and number rows
randomRow(NROWS, RESULT) :- MAX_ROW is NROWS - 1,
                            random(0, MAX_ROW, RESULT).

% Make a move in a given position 1.board, 2. X position, 3. Y position, 4.player number
botMakeMove(BOARD, X, Y, PLAYER):-  calcTriangleType(BOARD, X, Y, TYPE),
                                    insertTriangle(X, Y, BOARD, RESULT, [TYPE | PLAYER]).

%Make a random move in a valid position of the board 1.board, 2.player
randomMove(BOARD, PLAYER):- getRandomCoord(BOARD, X, Y),
                            botMakeMove(BOARD, X, Y, PLAYER).

%Print error message when the bot can´t make a play
botErrorMessage:- write('BOT ERROR: Can't make a valid play!).

%Try to finish the game by placing the final triangle tile 1.board, 2.player
botFinishGame(BOARD, PLAYER):-  getFinishCoord(BOARD, X, Y),
                                botMakeMove(BOARD, X, Y, PLAYER).

%Try to negate Enemy finishing move by placing a tile where the enemy player would place his. 1.board, 2.player
botNegateEnemyMove(BOARD, PLAYER):- false.

% Make a play as a bot 1.board, 2. Bot's player number, 3.dificulty
botTurn(BOARD, PLAYER, 1):- botFinishGame(BOARD, PLAYER).
botTurn(BOARD, PLAYER, 1):- botNegateEnemyMove(BOARD, PLAYER).
botTurn(BOARD, PLAYER, 1):- botRandomMove(BOARD, PLAYER).
botTurn(BOARD, PLAYER, 1):- botErrorMessage.


