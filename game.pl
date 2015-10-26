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
]
).

% Print triangles
printTriangle([0|_]) :- write('|   ').
printTriangle([1|1]) :- 	write('| '),
							name(C,[9651]), 
							write(C),
							write(' ').
printTriangle([1|2]) :- 	write('| '),
							name(C,[9650]), 
							write(C),
							write(' ').
printTriangle([2|1]) :- 	write('| '),
							name(C,[9661]), 
							write(C),
							write(' ').
printTriangle([2|2]) :- 	write('| '),
							name(C,[9660]), 
							write(C),
							write(' ').							

% Print utils
printBoarder([]):- write('-\n').
printBoarder([_| NEXT_COLUMNS]):- 		write('----'),
										printBoarder(NEXT_COLUMNS).
printRow([]):- write('|\n').
printRow([TRIANGLE | NEXT_TRIANGLES]) :-
										printTriangle(TRIANGLE),
										printRow(NEXT_TRIANGLES).

% Print the board
printBoard([ROW|[]]) :-	printBoarder(ROW),
							printRow(ROW),
							printBoarder(ROW). % Last row
printBoard([ROW | NEXT_ROWS]) :-printBoarder(ROW),
								printRow(ROW),
								printBoard(NEXT_ROWS).

								
createBoard(BOARD, COLUMNS, ROWS):- 
									createRow(BOARD, COLUMNS, ROWS).
									
createRow([X|[]], COLS, 1) :- createColumn(X,COLS).
createRow(X, COLS, 0):- createColumn(X,COLS).						
createRow( [X|Y],COLS,ROWS):- 
							createRow(X, COLS, 0),
							N is ROWS-1,
							createRow(Y, COLS, N).

createColumn([[0|0]] ,1).
createColumn([0|0], 0).						
createColumn([X|Y],COLS):- 	
							createColumn(X,0),
							N is COLS-1,
							createColumn(Y, N).
							
% Start the game
start:- initBoard(Board), printBoard(Board).
