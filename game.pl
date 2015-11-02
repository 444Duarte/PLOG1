:- include('display.pl').
:- include('input.pl').
:- include('validation.pl').

% Create the board
createBoard([], _, 0).
createBoard([ROW | NEXT_ROWS], COLUMNS, ROWS):-     ROWS \= 0,
                                                    createRow(ROW, COLUMNS),
                                                    R1 is ROWS - 1,
                                                    createBoard(NEXT_ROWS, COLUMNS, R1).
									
createRow([], 0).
createRow([COLUMN | NEXT_COLUMNS], COLUMNS) :-  COLUMNS \= 0,
                                                C1 is COLUMNS - 1,
                                                createColumn(COLUMN),
                                                createRow(NEXT_COLUMNS, C1).
createColumn([0,0]).

% Start the game  
start:- start(10, 10).
start(COLS, ROWS) :-    createBoard(BOARD, COLS, ROWS),
                        playGame(BOARD, 1).

% Next player (current player - next player)
nextPlayer(1, 2).
nextPlayer(2, 1).

% Insert triangle - 1. column, 2. row, 3. result row, 4. value [triangle, player]
insertTriangleCol(0, [_ | NCOLUMNS], [[T | P] | NCOLUMNS], [T | P]).
insertTriangleCol(C, [COL | NCOLUMNS], [COL | RESULT_NCOLUMNS], VALUE) :-   C \= 0,
                                                                            C1 is C - 1,
                                                                            insertTriangleCol(C1, NCOLUMNS, RESULT_NCOLUMNS, VALUE).
% Insert triangle - 1. column, 2. row, 3. board, 4. result board, 5. value [triangle, player]
insertTriangle(C, 0, [ROW | NROW], [RESULT_ROW | NROW], VALUE) :- insertTriangleCol(C, ROW, RESULT_ROW, VALUE). 
insertTriangle(C, R, [ROW | NROW], [ROW | RESULT_NROW], VALUE) :-   R \= 0,
                                                                    R1 is R - 1,
                                                                    insertTriangle(C, R1, NROW, RESULT_NROW, VALUE).

% Game loop
playGame(BOARD, PLAYER) :-  !,
                            printBoard(BOARD),
                            printPlayer(PLAYER),
                            readCoord(X,Y),
                            validCoords(BOARD,X,Y),
                            nextPlayer(PLAYER, NEXT_PLAYER),
                            playGame(BOARD, NEXT_PLAYER).
playGame(BOARD, PLAYER) :-  write('Invalid position! Press any key to try again....'), nl,
                            readAnyKey,
                            playGame(BOARD, PLAYER).
