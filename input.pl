% Input Methods
clearConsole :- clearConsole(50).
clearConsole(0).
clearConsole(LINES) :- nl,
                N1 is LINES-1,
                clear(N1).

readCoord(X, Y) :- prompt(_, 'X: '),
                   read(X),
                   prompt(_, 'Y: '),
                   read(Y),
                   prompt(_, '').

readAnyKey :-   read(_).