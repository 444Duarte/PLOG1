% Input Methods
clearConsole :- clearConsole(50).
clearConsole(0).
clearConsole(LINES) :- nl,
                N1 is LINES-1,
                clear(N1).

readCoord(X, Y) :-  prompt(_, 'X: '),
                    get_char(X_CHAR),
                    get_char(_),
                    name(X_CHAR, [X_INT_CHAR]),
                    X_INT is X_INT_CHAR-48,
                    (X_INT < 10 ->
                            X = X_INT;
                            X_INT_2 is X_INT - 7,
                            X = X_INT_2),
                    prompt(_, 'Y: '),
                    get_char(Y_CHAR),
                    get_char(_),
                    name(Y_CHAR, [Y_INT_CHAR]),
                    Y_INT is Y_INT_CHAR-48,
                    (Y_INT < 10 ->
                            Y = Y_INT;
                            Y_INT_2 is Y_INT - 7,
                            Y = Y_INT_2),
                    prompt(_, '').

readAnyKey :-   get_char(_).
