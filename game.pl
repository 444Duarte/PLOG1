:- include('display.pl').
:- include('input.pl').
:- include('validation.pl').
:- include('utilities.pl').

% Create the board
createBoard(BOARD, COLUMNS, ROWS):- 
									createRow(BOARD, COLUMNS, ROWS).
									
createRow([X|[]], COLS, 1) :- 
                            createColumn(X,COLS).
createRow(X, COLS, 0):- 
                            createColumn(X,COLS).						
createRow( [X|Y],COLS,ROWS):- 
							createRow(X, COLS, 0),
							N is ROWS-1,
							createRow(Y, COLS, N).

createColumn([[0|0]] ,1).
createColumn([0|0], 0).						
createColumn([X|Y],COLS):- 	
							createColumn(X,0),
							N is COLS-1,
							createColumn(Y, N).


% Start the game  
start:- start(10, 10).
start(COLS, ROWS) :-    createBoard(BOARD, COLS, ROWS),
                        playGame(BOARD).
% Next player (current player - next player)
nextPlayer(1, 2).
nextPlayer(2, 1).

% Game loop
playGame(BOARD) :-  printBoard(BOARD),
                    printPlayer(1),
                    readCoord(X, Y),
                    insertTriangle(X, Y, BOARD, NEW_BOARD, [1|1]),
                    nextPlayer(1, NEXT_PLAYER),
                    playGame(NEW_BOARD, NEXT_PLAYER).
playGame(BOARD, PLAYER) :-  !,
                            printBoardIndex(BOARD),
                            printPlayer(PLAYER),
                            readCoord(X,Y),
                            (validCoords(BOARD,X,Y) ->
                                    calcTriangleType(BOARD, X, Y, TYPE),
                                    insertTriangle(X, Y, BOARD, NEW_BOARD, [TYPE|PLAYER]),
                                    nextPlayer(PLAYER, NEXT_PLAYER),
                                    playGame(NEW_BOARD, NEXT_PLAYER);

                                    write('Invalid position! Press any key to try again...'), nl,
                                    readAnyKey,
                                    playGame(BOARD, PLAYER)).
