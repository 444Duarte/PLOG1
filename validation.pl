% Has triangle on that coordinate (@type 1 or 2 depending on triangle orientation)
hasTriangle([TYPE | PLAYER], TYPE) :- PLAYER \= 0.

% Triangle on top
validColumn([COLUMN | _], 0, 1) :- hasTriangle(COLUMN, 1).
validColumn([_ | NEXT_COLUMNS], COLUMN, 1) :- 	COLUMN \= 0,
                                                C is COLUMN-1,
												validColumn(NEXT_COLUMNS, C, 1).

% Triangle on left
validColumn([COLUMN | _], 1, 0) :- hasTriangle(COLUMN, _).

% Triangle on right
validColumn([COLUMN | _], -1, 0) :- hasTriangle(COLUMN, _).
validColumn([_ | NEXT_COLUMNS], COLUMN, 0) :-   C is COLUMN-1,
												validColumn(NEXT_COLUMNS, C, 0).

% Triangle on bottom
validColumn([COLUMN | _], 0, -1) :- hasTriangle(COLUMN, 2).
validColumn([_ | NEXT_COLUMNS], COLUMN, -1) :- 	COLUMN \= 0,
                                                C is COLUMN-1,
												validColumn(NEXT_COLUMNS, C, -1).
% Valid coordinates
validCoords([ROW | _], COLUMN, 1) :- 	validColumn(ROW, COLUMN, 1).
validCoords([ROW | _], COLUMN, 0) :- 	validColumn(ROW, COLUMN, 0).
validCoords([ROW | _], COLUMN, -1) :- 	validColumn(ROW, COLUMN, -1).
validCoords([_ | NEXT_ROWS], COLUMN, ROW) :- 	R is ROW - 1,
												validCoords(NEXT_ROWS, COLUMN, R).
