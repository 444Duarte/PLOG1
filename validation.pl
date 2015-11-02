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
