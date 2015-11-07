:- include('game.pl').

menu_option('1'):-  readBoardSize(COLUMNS, ROWS),
    				startPvP(COLUMNS, ROWS).

menu_option('2'):-  readBoardSize(COLUMNS, ROWS),
                    startPvB(COLUMNS, ROWS).

menu_option('3'):-  readBoardSize(COLUMNS, ROWS),
                    startBvB(COLUMNS, ROWS).

menu_option('4'):-  write('/////////////\n'),
    				write('//  Rules  //\n'),
    				write('/////////////\n\n'),
    				write('Players alternate playing adjacent to the existing pattern.\nThe first player to form a four tile triangle with his color on all three tips (and either color in the center) wins.\n'),
	    			write('\nInsert key any to go back\n'),	
		    		readAnyKey,
                    spangles.

menu_option(OPTION):-   OPTION \= '1',
                        OPTION \= '2',
                        OPTION \= '3',
                        OPTION \= '4',
                        spangles.


spangles :- write('//////////////////////////\n'),
    		write('//        Spangles      //\n'),
    		write('//                      //\n'),
    		write('// Choose an option:    //\n'),
    		write('//  1-Player vs Player  //\n'),
    		write('//  2-Player vs Bot     //\n'),
    		write('//  3-Bot vs Bot        //\n'),
    		write('//  4-Rules             //\n'),
    		write('//                      //\n'),
            write('//////////////////////////\n'),
            prompt(_, 'Option: '),
    		get_char(OPTION),
            get_char(_),
            prompt(_, ''),
    		menu_option(OPTION).
