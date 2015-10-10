% Initialize the board
initBoard([
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ]
]).

% Print triangles
printTriangle([0|_]) :- write('|  ').
printTriangle([1|_]) :- write('|/\\').
printTriangle([2|_]) :- write('|\\/').

% Print utils
printBoarder:- write('----------------------------------------\n').
printRow([]):- write('|\n').
printRow([TRIANGLE | NEXT_TRIANGLES]) :-
										printTriangle(TRIANGLE),
										printRow(NEXT_TRIANGLES).

% Print the board
printBoard([]) :- printBoarder.
printBoard([ROW | NEXT_ROWS]) :-  
								printBoarder,
								printRow(ROW),
								printBoard(NEXT_ROWS).

% Start the game
start:- initBoard(Board), printBoard(Board).
