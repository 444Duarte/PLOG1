:- include('display.pl').
:- include('input.pl').
:- include('validation.pl').
:- include('utilities.pl').

% Start the game  
start:- start(10, 10).
start(COLS, ROWS) :-    createBoard(BOARD, COLS, ROWS),
                        playGame(BOARD, 1).
% Next player (current player - next player)
nextPlayer(1, 2).
nextPlayer(2, 1).

% Game loop
playGame(BOARD, PLAYER) :-  !,
                            printBoard(BOARD),
                            printPlayer(PLAYER),
                            readCoord(X,Y),
                            (validCoords(BOARD,X,Y) == true ->
                                    insertTriangle(X, Y, BOARD, NEW_BOARD, [1|PLAYER]),
                                    nextPlayer(PLAYER, NEXT_PLAYER),
                                    playGame(NEW_BOARD, NEXT_PLAYER);

                                    write('Invalid position! Press any key to try again...'), nl,
                                    readAnyKey,
                                    playGame(BOARD, PLAYER)).
