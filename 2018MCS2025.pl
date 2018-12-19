%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%	Name		:	Konark Verma	%
%	Roll number	:	2018MCS2025		%
%	COL-765 	: 	ILFP			%
%	Assignment 	: 	4 				%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(500, xfx, -->).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dcg(A-->B, (A1:-B1)) 	:- 	nounPhrase(A, X, Y, _, A1), 
							verbPhrase(B, X, Y, _, B2), 
							fun(B2, _, B1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nounPhrase((F, L), A, B, _, R) 	:- 	!, nonvar(F), 
									check_list(L), 
									func(F, A, B, _, R), 
									append(L, A, B).

nounPhrase(F, A, B, _, R) 		:- 	nonvar(F), 
									func(F, A, B, _, R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

verbPhrase((F, L), A, B, _, R) 	:- 	!, verbPhrase(F, A, R1, _, R2), 
									verbPhrase(L, R1, B, _, R3), 
									and(R2, R3, R).

verbPhrase(!, A, A, _, !) 		:- 	!.

verbPhrase(L, R1, R, _, true) 	:- 	check_list(L), !, 
									append(L, R, R1).

verbPhrase(A, B, C, _, R) 	 	:- 	func(A, B, C, _, R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_list([]) 			:- 	!.
check_list([_|_]) 		:- 	!.

and(true, P, P) 		:- 	!.
and(P, true, P) 		:- 	!.
and(P, Q, (P, Q)).

func(X, M, N, _, R) 	:- 	X =..[F | A], 
							append(A, [M, N], B), 
							R =..[F | B].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fun1(A, (A, R), _, R) 	:- 	var(A), !.

fun1((A, B), C, _, R) 	:- 	!, fun1(A, C, _, R1), 
							fun1(B, R1, _, R).

fun1(A, (A, R), _, R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fun(A, _, A) 		:- 	var(A), !.

fun((A, B), _, C) 	:- 	!, fun1(A, C, _, R), 
						fun(B, _, R).
fun(A, _, A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

readFile(Infile, Data)	:- 	open(Infile, read, File), 
				         	readData(File, Data), 
				         	close(File).
				         	 
readData(Stream,[])		:-	at_end_of_stream(Stream),!. 
    
readData(Stream,[X|L])	:-	read(Stream,X), 
         					readData(Stream,L).

writeData(Outfile, Text) 	:- 	open(Outfile, append, Stream), 
								write(Stream, Text),
								write(Stream, '.'),
								nl(Stream),
								close(Stream).

main([],_):-!.

main([H|T], Outfile)	:-	dcg(H,Y), writeData(Outfile,Y), main(T, Outfile).

start(Infile, Outfile) 	:- 	readFile(Infile, Data), main(Data, Outfile).