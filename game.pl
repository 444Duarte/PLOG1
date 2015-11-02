:- include('unit-tests.pl').
:- include('display.pl').
:- include('input.pl').
:- include('validation.pl').

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
	
% Start the game  
start:- start(10, 10).
start(COLS, ROWS) :-    createBoard(BOARD, COLS, ROWS),
                        printBoard(BOARD),
                        playGame(BOARD, 1).

playGame(BOARD, PLAYER) :-  printPlayer(PLAYER).
