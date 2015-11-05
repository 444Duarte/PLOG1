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
