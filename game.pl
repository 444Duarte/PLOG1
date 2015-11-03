:- include('display.pl').
:- include('input.pl').
:- include('validation.pl').
:- include('utilities.pl').

% Start the game  
start:- start(10, 10).
start(COLS, ROWS) :-    createBoard(BOARD, COLS, ROWS),
                        playGame(BOARD).
% Next player (current player - next player)
nextPlayer(1, 2).
nextPlayer(2, 1).

% Game loop
playGame(BOARD) :-  clearConsole, 
                    printBoardIndex(BOARD),
                    PLAYER = 1,
                    printPlayer(PLAYER),
                    readCoord(X, Y),
                    getNumberCols(BOARD, NCOLS),
                    getNumberRows(BOARD, NROWS),
                    (
                            % Invalid coordinates
                            (X @>= NCOLS; X @< 0; Y @>= NROWS; Y @< 0) -> (
                                printInvalidCoord,
                                readAnyKey,
                                !,
                                playGame(BOARD, PLAYER)
                            );
                            % Valid coordinates
                            (
                                insertTriangle(X, Y, BOARD, NEW_BOARD, [1|1]),
                                nextPlayer(PLAYER, NEXT_PLAYER),
                                !,
                                playGame(NEW_BOARD, NEXT_PLAYER)
                            )
                    ).
playGame(BOARD, PLAYER) :-  clearConsole,
                            printBoardIndex(BOARD),
                            nextPlayer(PLAYER, PREVIOUS_PLAYER),
                            (
                                    % Previous player won the game
                                    checkWinner(BOARD, PREVIOUS_PLAYER) -> (
                                        printWinner(PREVIOUS_PLAYER), !
                                    );
                                    % No winner yet
                                    (
                                            % Has available cells to play
                                            hasAvailableCells(BOARD) -> (
                                                printPlayer(PLAYER),
                                                readCoord(X, Y),
                                                % Valid coordinates
                                                validCoords(BOARD, X, Y) -> (
                                                    calcTriangleType(BOARD, X, Y, TYPE),
                                                    insertTriangle(X, Y, BOARD, NEW_BOARD, [TYPE | PLAYER]),
                                                    nextPlayer(PLAYER, NEXT_PLAYER),
                                                    !,
                                                    playGame(NEW_BOARD, NEXT_PLAYER)
                                                );
                                                % Invalid coordinates
                                                (
                                                    printInvalidCoord,
                                                    readAnyKey,
                                                    !,
                                                    playGame(BOARD, PLAYER)        
                                                )
                                            );
                                            % Draw game (no more available cells)
                                            (
                                                printDraw
                                            )
                                    )
                            ).
