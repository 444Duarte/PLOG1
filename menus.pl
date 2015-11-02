:- include('game.pl').
menu_option(1):-write('Number of columns: '),
				read(COLUMNS),
				write('\nNumber of rows: '),
				read(ROWS),
				start(COLUMNS, ROWS).

menu_option(2):-write('/////////////\n'),
				write('//  Rules  //\n'),
				write('/////////////\n\n'),
				write('Players alternate playing adjacent to the existing pattern.\nThe first player to form a four tile triangle with his color on all three tips (and either color in the center) wins.\n'),
				write('\nInsert key any to go back\n'),	
				read(_),start_menu.

menu_option(_):- start_menu.


start_menu:-write('///////////////////////\n'),
			write('//      Spangles     //\n'),
			write('//                   //\n'),
			write('// Choose an option: //\n'),
			write('//  1-Play           //\n'),
			write('//  2-Rules          //\n'),
			write('///////////////////////\n'),
			read(OPTION), write('\n'),
			menu_option(OPTION).