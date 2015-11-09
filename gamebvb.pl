% Bot vs Bot Game Loop
initialPlayBvB(BOARD) :-   clearConsole,
                        printBoardIndex(BOARD),
                        PLAYER = 1,
                        printPlayer(PLAYER),
                        getNumberCols(BOARD, NCOLS),
                        randomColumn(NCOLS, X),
                        getNumberRows(BOARD, NROWS),
                        randomRow(NROWS, Y),
                        X < NCOLS, X >= 0,
                        Y < NROWS, Y >= 0,
                        insertTriangle(X, Y, BOARD, NEW_BOARD, [1|1]),
                        nextPlayer(PLAYER, NEXT_PLAYER),
                        playBvB(NEW_BOARD, NEXT_PLAYER).
% Invalid coordinates
initialPlayBvB(BOARD) :-   printInvalidCoord,
                        readAnyKey,
                        !, 
                        initialPlayBvB(BOARD).

% One player has won
playBvB(BOARD, PLAYER) :-  nextPlayer(PLAYER, PREVIOUS_PLAYER),
                        checkWinner(BOARD, PREVIOUS_PLAYER),
                        clearConsole,
                        printBoardIndex(BOARD),
                        printWinner(PREVIOUS_PLAYER), !.
% No one won yet, has playable cells
playBvB(BOARD, PLAYER) :-  hasAvailableCells(BOARD),
                        clearConsole,
                        printBoardIndex(BOARD),
                        printPlayer(PLAYER),
                        makeMoveBvB(BOARD, NEW_BOARD, PLAYER),
                        nextPlayer(PLAYER, NEXT_PLAYER),
                        !,
                        playBvB(NEW_BOARD, NEXT_PLAYER).
% Draw
playrBvB(_, _) :- printDraw. 

% Player make a move
makeMoveBvB(BOARD, RESULT, PLAYER) :-   getRandomCoord(BOARD, X, Y),
                                calcTriangleType(BOARD, X, Y, TYPE),
                                insertTriangle(X, Y, BOARD, RESULT, [TYPE | PLAYER]).

% Invalid movement coordinates
makeMoveBvB(BOARD, _, PLAYER) :-   printInvalidCoord,
                                readAnyKey,
                                !,
                                playBvB(BOARD, PLAYER).
