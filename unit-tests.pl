:- use_module(library(plunit)).
:- include('validation.pl').

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
:- end_tests(validCoord).

% Validation of insertion
:- begin_tests(insertion).
test(BOARD, true) :-    setup(BOARD),
                        insertTriangle(1, 2, BOARD, RESULT, [2|1]),
                        getTriangle(RESULT, 1, 2, TYPE, PLAYER),
                        TYPE == 2,
                        PLAYER == 1. 
:- end_tests(insertion).
