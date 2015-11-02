% Print Triangles
printTriangle([0|_]) :-     write('|   ').
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

% Print Border
printBoarder([]):- write('-\n').
printBoarder([_| NEXT_COLUMNS]):-   write('----'),
									printBoarder(NEXT_COLUMNS).

% Print Row
printRow([]):- write('|\n').
printRow([TRIANGLE | NEXT_TRIANGLES]) :-    printTriangle(TRIANGLE),
										    printRow(NEXT_TRIANGLES).

% Print Board
printBoard([ROW | []]) :-   printBoarder(ROW),
                            printRow(ROW),
                            printBoarder(ROW).
printBoard([ROW | NEXT_ROWS]) :-    NEXT_ROWS \= [],
                                    printBoarder(ROW),
								    printRow(ROW),
								    printBoard(NEXT_ROWS).

% Print player
printPlayer(PLAYER) :-  write('Player '),
                        write(PLAYER),
                        write(':\n').

