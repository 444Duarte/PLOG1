% Create the board
createBoard(BOARD, COLUMNS, ROWS):- 
									createRow(BOARD, COLUMNS, ROWS).
									
createRow([X|[]], COLS, 1) :- 
                            createColumn(X,COLS).
createRow(X, COLS, 0):- 
                            createColumn(X,COLS).						
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
	
% Print triangles
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

% Print utils
printBoarder([]):- write('-\n').
printBoarder([_| NEXT_COLUMNS]):-   write('----'),
									printBoarder(NEXT_COLUMNS).

% Print Row
printRow([]):- write('|\n').
printRow([TRIANGLE | NEXT_TRIANGLES]):-	printTriangle(TRIANGLE),
										printRow(NEXT_TRIANGLES).

% Print the board
printBoard(N, [ROW|[]]) :-	printBoarder([_|ROW]),
							printIndexRow(N),
							printRow(ROW),
							printBoarder([_|ROW]). % Last row
printBoard(N,[ROW | NEXT_ROWS]) :-  printBoarder([_|ROW]),
									printIndexRow(N),
								    printRow(ROW),
								    NEXT is N+1,
								    printBoard(NEXT, NEXT_ROWS).

%Print index
printBoardIndex([ROW | NEXT_ROWS]):-write('    '),
									printBoarder(ROW),
									write('    '),
									printIndexCol(0, ROW),		
									printBoarder([_|ROW]),
							    	printIndexRow(0),
							    	printRow(ROW),
							    	printBoard(1,NEXT_ROWS).

printIndexCol(_,[]):- write('|\n').
printIndexCol(N, [_|NEXT_COLUMNS]):-N<10,		
									write('| '),
									CHAR is N+48,
									name(C,[CHAR]),
									write(C),
									write(' '),
									NEXT is N+1,
									printIndexCol(NEXT, NEXT_COLUMNS). 

printIndexCol(N, [_|NEXT_COLUMNS]):-write('| '),
									CHAR is N+48+7,
									name(C,[CHAR]),
									write(C),
									write(' '),
									NEXT is N+1,
									printIndexCol(NEXT, NEXT_COLUMNS).
printIndexRow(N):-	N<10,
					write('| '),
					CHAR is N+48,
					name(C,[CHAR]),
					write(C),
					write(' ').

printIndexRow(N):-	write('| '),
					CHAR is N+48+7,
					name(C,[CHAR]),
					write(C),
					write(' ').



% Start the game  
start(COLS, ROWS) :-    createBoard(BOARD, COLS, ROWS),
                        initBoard(BOARD),
                        printBoard(BOARD).
start:- start(10, 10).


menu_option(1):-	write('Number of columns: '),
					read(COLUMNS),
					write('\nNumber of rows: '),
					read(ROWS),
					createBoard(BOARD, COLUMNS,ROWS),
					printBoardIndex(BOARD).


menu_option(2):- 	write('/////////////\n'),
					write('//  Rules  //\n'),
					write('/////////////\n\n'),
					write('Players alternate playing adjacent to the existing pattern.\nThe first player to form a four tile triangle with his color on all three tips (and either color in the center) wins.\n'),
					write('\nInsert key any to go back\n'),	
					read(A),start_game(A).

menu_option(A):- start_game(A).


start_game(_) :- 	write('///////////////////////\n'),
					write('//      Spangles     //\n'),
					write('//                   //\n'),
					write('// Choose an option: //\n'),
					write('//  1-Play           //\n'),
					write('//  2-Rules          //\n'),
					write('///////////////////////\n'),
					read(OPTION), write('\n'),
					menu_option(OPTION).
