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
