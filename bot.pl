:- use_module(library('random')).

% Random column between 0 and number columns
randomColumn(NCOLS, RESULT):-   MAX_COL is NCOLS - 1,
                                random(0, MAX_COL, RESULT).
% Random row between 0 and number rows
randomRow(NROWS, RESULT):-  MAX_ROW is NROWS - 1,
                            random(0, MAX_ROW, RESULT).

% Generate a random coordinate
getRandomCoord(BOARD, COLUMN, ROW):-getNumberRows(BOARD, NROWS),
                                    randomRow(NROWS, R1),
                                    getNumberCols(BOARD, NCOLS),
                                    randomColumn(NCOLS, C1),
                                    ((validCoords(BOARD, C1, R1), COLUMN is C1, ROW is R1) ; getRandomCoord(BOARD, COLUMN, ROW)). 
                                    
% Check for a possible winning position                            
getFinishCoord(BOARD, PLAYER, X, Y):-   getNumberRows(BOARD, NROWS),
                                        getNumberCols(BOARD, NCOLS),
                                        findFinishRow(BOARD, PLAYER, NCOLS,NROWS, X, Y, 0).

findFinishRow(BOARD, PLAYER, NCOLS, NROWS, X, Y, 0):- findFinishRow(BOARD, PLAYER, NCOLS, NROWS, X, Y, 1).
findFinishRow(BOARD, PLAYER, NCOLS,NROWS, X, Y,ROW):-   ROW > 0,
                                                        ROW < NROWS,
                                                        ROWN is ROW+1,
                                                        (findFinishRow(BOARD, PLAYER, NCOLS, NROWS, X,Y, ROWN) ; findFinishCols(BOARD, PLAYER, NCOLS, X, Y, 0 ,ROW)).

findFinishCols(BOARD, PLAYER, NCOLS, X, Y, 0, ROW):- findFinishCols(BOARD, PLAYER, NCOLS, X, Y, 1, ROW).
findFinishCols(BOARD, PLAYER, NCOLS, X, Y, COL, ROW):-  COL > 0,
														COL < NCOLS,
                                                        getTriangle(BOARD, COL, ROW,VALUE),
                                                        VALUE \= [0|0],
                                                        possibleFinishCell(BOARD, PLAYER, X, Y, COL, ROW)
														.


possibleFinishCell(BOARD, PLAYER, X, Y, COL, ROW):- COL1 is COL-1,
                                                    getTriangle(BOARD, COL1, ROW, [TP_LEFT|PL_LEFT]),          %FINISH CELL DOWN OR FINISH CELL UP
                                                    PL_LEFT == PLAYER,
                                                    COL2 is COL+1,
                                                    getTriangle(BOARD, COL2, ROW, [TP_RIGHT|PL_RIGHT]),
                                                    PL_RIGHT == PLAYER,
                                                    ((TP_LEFT == 2, ROWN is ROW+1, getTriangle(BOARD, COL, ROW+1, VALUE), VALUE == [0|0], X is COL, Y is ROW+1) 
                                                    ;(TP_RIGHT == 1,ROWN is ROW-1, getTriangle(BOARD, COL, ROWN, VALUE), VALUE == [0|0], X is COL, Y is ROW-1)
                                                    ;fail
                                                    ).


possibleFinishCell(BOARD, PLAYER, X, Y, COL, ROW):- COL1 is COL-1,
                                                    getTriangle(BOARD, COL1, ROW, [TP_LEFT|PL_LEFT]),          %FINISH CELL RIGHT
                                                    PL_LEFT == PLAYER,
                                                    ((TP_LEFT == 2, (ROWN is ROW+1,getTriangle(BOARD, COL, ROWN, VALUE), VALUE == [TP_LEFT|PL_LEFT]))
                                                    ;(TP_LEFT == 1, (ROWN is ROW-1, getTriangle(BOARD, COL, ROWN, VALUE), VALUE == [TP_LEFT|PL_LEFT]))
                                                    ;fail
                                                    ),
                                                    COL2 is COL+1,
                                                    getTriangle(BOARD, COL2, ROW, VALUE1),
                                                    VALUE1 == [0|0],
                                                    X is COL+1,
                                                    Y is ROW.

possibleFinishCell(BOARD, PLAYER, X, Y, COL, ROW):- COL1 is COL+1,
                                                    getTriangle(BOARD, COL1, ROW, [TP_RIGHT|PL_RIGHT]),          %FINISH CELL LEFT
                                                    PL_RIGHT == PLAYER,
                                                    ((TP_RIGHT == 2, (ROWN is ROW+1, getTriangle(BOARD, COL, ROWN, VALUE),VALUE == [TP_RIGHT|PL_RIGHT]))
                                                    ;(TP_RIGHT == 1, ROWN is ROW-1,getTriangle(BOARD, COL, ROWN, VALUE), VALUE == [TP_RIGHT|PL_RIGHT])
                                                    ;fail
                                                    ),
                                                    COL2 is COL-1,
                                                    getTriangle(BOARD, COL2, ROW, VALUE1),
                                                    VALUE1 == [0|0],
                                                    X is COL-1,
                                                    Y is ROW.



% Make a move in a given position 1.board, 2. X position, 3. Y position, 4.player number
botMakeMove(BOARD, RESULT, X, Y, PLAYER):-  calcTriangleType(BOARD, X, Y, TYPE),
                                            insertTriangle(X, Y, BOARD, RESULT, [TYPE | PLAYER]).

%Make a random move in a valid position of the board 1.board, 2.player
botRandomMove(BOARD, RESULT, PLAYER):- getRandomCoord(BOARD, X, Y),
										botMakeMove(BOARD, RESULT, X, Y, PLAYER).

%Print error message when the bot can´t make a play
botErrorMessage:- write('BOT ERROR: Unable to make a valid play\n').

%Try to finish the game by placing the final triangle tile 1.board, 2.player
botFinishGame(BOARD, RESULT, PLAYER):-  getFinishCoord(BOARD, PLAYER, X, Y),
										botMakeMove(BOARD, RESULT, X, Y, PLAYER).

%Try to negate Enemy finishing move by placing a tile where the enemy player would place his. 1.board, 2.player
botNegateEnemyMove(BOARD, RESULT, 1):-  getFinishCoord(BOARD, 2, X, Y),
										botMakeMove(BOARD, RESULT, X, Y, 1).

botNegateEnemyMove(BOARD, RESULT, 2):-  getFinishCoord(BOARD, 1, X, Y),
                                botMakeMove(BOARD, RESULT, X, Y, 2).								

% Make a play as a bot 1.board, 2. Bot's player number, 3.dificulty
botTurn(BOARD, RESULT, PLAYER, 1):- botRandomMove(BOARD, RESULT, PLAYER).
botTurn(BOARD, BOARD,_, 1):- botErrorMessage.


botTurn(BOARD, RESULT, PLAYER, 2):- botFinishGame(BOARD, RESULT, PLAYER),
                                    write('Bot finished the game\n').
botTurn(BOARD, RESULT, PLAYER, 2):- write('Bot unable to finish the game!\n'),
                                    botNegateEnemyMove(BOARD, RESULT, PLAYER).
botTurn(BOARD, RESULT, PLAYER, 2):- write('Bot unable to negate the move!\n'),
                                    botRandomMove(BOARD, RESULT, PLAYER).
botTurn(_,_,_, 2):- botErrorMessage.


