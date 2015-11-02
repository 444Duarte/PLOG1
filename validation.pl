% Get a triangle in a column. 1. row, 2. column number, 3. type, 4. player
getTriangleCol([[TYPE | PLAYER] | _], 0, TYPE, PLAYER).
getTriangleCol([_ | NCOLS], COLUMN, TYPE, PLAYER) :-    COLUMN \= 0,
                                                        C1 is COLUMN - 1,
                                                        getTriangleCol(NCOLS, C1, TYPE, PLAYER).
% Get a triangle in a board. 1. board, 2. column number, 3. row number, 4. type, 5. player      
getTriangle([ROW | _], COLUMN, 0, TYPE, PLAYER) :- getTriangleCol(ROW, COLUMN, TYPE, PLAYER).
getTriangle([_ | NROWS], COLUMN, ROW, TYPE, PLAYER) :-  ROW \= 0,
                                                        R1 is ROW - 1,
                                                        getTriangle(NROWS, COLUMN, R1, TYPE, PLAYER).

% Valid coordinates
% Triangle on the right
validCoords(BOARD, COLUMN, ROW) :-  C1 is COLUMN + 1,
                                    getTriangle(BOARD, C1, ROW, _, PLAYER),
                                    PLAYER \= 0.
% Triangle on the left
validCoords(BOARD, COLUMN, ROW) :-  C1 is COLUMN - 1,
                                    getTriangle(BOARD, C1, ROW, _, PLAYER),
                                    PLAYER \= 0.
% Triangle on the top
validCoords(BOARD, COLUMN, ROW) :-  R1 is ROW - 1,
                                    getTriangle(BOARD, COLUMN, R1, TYPE, PLAYER),
                                    TYPE == 1,
                                    PLAYER \= 0.
% Triangle on the bottom
validCoords(BOARD, COLUMN, ROW) :-  R1 is ROW + 1,
                                    getTriangle(BOARD, COLUMN, R1, TYPE, PLAYER),
                                    TYPE == 2,
                                    PLAYER \= 0.
