:- use_module(library(plunit)).
:- include('validation.pl').
:- include('utilities.pl').

createBoard(
[
[ [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [1|2], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0] ]
]
).

setup(BOARD):- createBoard(BOARD).

% Validation of get triangle
:- begin_tests(getTriangle).
test(BOARD, true) :-    setup(BOARD),
                        getTriangle(BOARD, 1, 1, TYPE, PLAYER),
                        TYPE == 1,
                        PLAYER == 2.

test(BOARD, true) :-    setup(BOARD),
                        getTriangle(BOARD, 4, 4, TYPE, PLAYER),
                        TYPE == 0,
                        PLAYER == 0.

test(BOARD, fail) :-    setup(BOARD),
                        getTriangle(BOARD, 0, 1, TYPE, PLAYER),
                        TYPE == 1,
                        PLAYER == 1.
:- end_tests(getTriangle).

% Validation of movement
:- begin_tests(validCoord).
test(BOARD, fail) :-    setup(BOARD),
                        validCoords(BOARD, 1, 0).

test(BOARD, true) :-    setup(BOARD),
                        validCoords(BOARD, 0, 1).

test(BOARD, true) :-    setup(BOARD),
                        validCoords(BOARD, 2, 1).

test(BOARD, true) :-    setup(BOARD),
                        validCoords(BOARD, 1, 2).

test(BOARD, fail) :-    setup(BOARD),
                        validCoords(BOARD, 1, 1).

test(BOARD, fail) :-    setup(BOARD),
                        validCoords(BOARD, -1, 2).

test(BOARD, fail) :-    setup(BOARD),
                        validCoords(BOARD, 6, 7).

:- end_tests(validCoord).

% Validation of insertion
:- begin_tests(insertion).
test(BOARD, true) :-    setup(BOARD),
                        insertTriangle(1, 2, BOARD, RESULT, [2|1]),
                        getTriangle(RESULT, 1, 2, TYPE, PLAYER),
                        TYPE == 2,
                        PLAYER == 1. 

test(BOARD, true) :-    setup(BOARD),
                        insertTriangle(4, 4, BOARD, RESULT, [1|1]),
                        getTriangle(RESULT, 4, 4, TYPE, PLAYER),
                        TYPE == 1,
                        PLAYER == 1.

test(BOARD, fail) :-    setup(BOARD),
                        insertTriangle(5, 4, BOARD, RESULT, [1|1]),
                        getTriangle(RESULT, 5, 4, TYPE, PLAYER),
                        TYPE == 1,
                        PLAYER == 1.
:- end_tests(insertion).

% Validation number empty cells
:- begin_tests(emptyCells).
test(BOARD, [true(N == 24)]) :-    setup(BOARD),
                        numberEmptyCells(BOARD, N).
test(BOARD, [true(N == 23)]) :-    setup(BOARD),
                        insertTriangle(0, 0, BOARD, RESULT, [1|1]),
                        numberEmptyCells(RESULT, N).
:- end_tests(emptyCells).
