% Player vs Bot Game Loop
initialPlayPvB(BOARD) :-   clearConsole,
                        printBoardIndex(BOARD),
                        PLAYER = 1,
                        printPlayer(PLAYER),
                        readCoord(X, Y),
                        getNumberCols(BOARD, NCOLS),
                        getNumberRows(BOARD, NROWS),
                        X < NCOLS, X >= 0,
                        Y < NROWS, Y >= 0,
                        insertTriangle(X, Y, BOARD, NEW_BOARD, [1|1]),
                        nextPlayer(PLAYER, NEXT_PLAYER),
                        playPvB(NEW_BOARD, NEXT_PLAYER).
% Invalid coordinates
initialPlayPvB(BOARD) :-   printInvalidCoord,
                        readAnyKey,
                        !, 
                        initialPlayPvB(BOARD).

% One player has won
playPvB(BOARD, PLAYER) :-  nextPlayer(PLAYER, PREVIOUS_PLAYER),
                        checkWinner(BOARD, PREVIOUS_PLAYER),
                        clearConsole,
                        printBoardIndex(BOARD),
                        printWinner(PREVIOUS_PLAYER), !.
% No one won yet, has playable cells
playPvB(BOARD, PLAYER) :-  hasAvailableCells(BOARD),
                        clearConsole,
                        printBoardIndex(BOARD),
                        printPlayer(PLAYER),
                        makeMovePvB(BOARD, NEW_BOARD, PLAYER),
                        nextPlayer(PLAYER, NEXT_PLAYER),
                        !,
                        playPvB(NEW_BOARD, NEXT_PLAYER).
% Draw
playPvB(_, _) :- printDraw. 

% Player make a move
makeMovePvB(BOARD, RESULT, 2) :-   getRandomCoord(BOARD, X, Y),
                                calcTriangleType(BOARD, X, Y, TYPE),
                                insertTriangle(X, Y, BOARD, RESULT, [TYPE | 2]).
makeMovePvB(BOARD, RESULT, 1) :-   readCoord(X, Y),
                                validCoords(BOARD, X, Y),
                                calcTriangleType(BOARD, X, Y, TYPE),
                                insertTriangle(X, Y, BOARD, RESULT, [TYPE | 1]).
% Invalid movement coordinates
makeMovePvB(BOARD, _, PLAYER) :-   printInvalidCoord,
                                readAnyKey,
                                !,
                                playPvB(BOARD, PLAYER).
