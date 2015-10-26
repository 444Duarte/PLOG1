% Initialize the board
initBoard([
[ [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
[ [0|0], [1|2], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0], [0|0] ],
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
printTriangle([0|_]) :- 	write('|   ').
printTriangle([1|1]) :- 	write('| '),
							atom_codes(C,[9651]), 
							write(C),
							write(' ').
printTriangle([1|2]) :- 	write('| '),
							atom_codes(C,[9650]), 
							write(C),
							write(' ').
printTriangle([2|1]) :- 	write('| '),
							atom_codes(C,[9661]), 
							write(C),
							write(' ').
printTriangle([2|2]) :- 	write('| '),
							atom_codes(C,[9660]), 
							write(C),
							write(' ').

% Print row
printRow([]):- write('|\n').
printRow([TRIANGLE | NEXT_TRIANGLES]) :-	printTriangle(TRIANGLE),
											printRow(NEXT_TRIANGLES).

% Print boarder
printColHeader:- write('| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | A | B | C |\n').
printBoarder:- write('------------------------------------------------------\n').

% Print the board
printBoard([]) :- printBoarder.
printBoard([ROW | NEXT_ROWS]) :-  	printBoarder,
									printRow(ROW),
									printBoard(NEXT_ROWS).

% Print players
printPlayer(1) :- write('Player 1\n').
printPlayer(2) :- write('Player 2\n').

% Read coordinates
readCoords(COLUMN, ROW) :- 	prompt(_,'Column? '),
							read(COLUMN),
							prompt(_,'Row? '),
							read(ROW),
							prompt(_, '').

% Has triangle on that coordinate
hasTriangle([_ | PLAYER]) :- PLAYER \= 0.

% Triangle on top
validColumn([COLUMN | _], 0, 1) :- hasTriangle(COLUMN).
validColumn([_ | NEXT_COLUMNS], COLUMN, 1) :- 	C is COLUMN-1,
												validColumn(NEXT_COLUMNS, C, 1).

% Triangle on left
validColumn([COLUMN | _], 1, 0) :- hasTriangle(COLUMN).
validColumn([_ | NEXT_COLUMNS], COLUMN, 0) :- 	C is COLUMN-1,
												validColumn(NEXT_COLUMNS, C, 0).

% Triangle on right
validColumn([COLUMN | _], -1, 0) :- hasTriangle(COLUMN).
validColumn([_ | NEXT_COLUMNS], COLUMN, 0) :- 	C is COLUMN-1,
												validColumn(NEXT_COLUMNS, C, 0).

% Triangle on bottom
validColumn([COLUMN | _], 0, -1) :- hasTriangle(COLUMN).
validColumn([_ | NEXT_COLUMNS], COLUMN, -1) :- 	C is COLUMN-1,
												validColumn(NEXT_COLUMNS, C, -1).
% Valid coordinates
validCoords([ROW | _], COLUMN, 1) :- 	validColumn(ROW, COLUMN, 1).
validCoords([ROW | _], COLUMN, 0) :- 	validColumn(ROW, COLUMN, 0).
validCoords([ROW | _], COLUMN, -1) :- 	validColumn(ROW, COLUMN, -1).
validCoords([_ | NEXT_ROWS], COLUMN, ROW) :- 	R is ROW - 1,
												validCoords(NEXT_ROWS, COLUMN, R).

% Game loop
gameLoop(BOARD, PLAYER) :- 	printPlayer(PLAYER),
							readCoords(COLUMN, ROW),
							validCoords(BOARD, COLUMN, ROW).

% Start the game
start :- initBoard(BOARD), printColHeader, printBoard(BOARD).