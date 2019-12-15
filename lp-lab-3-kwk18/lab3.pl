:- use_module(library(statistics)).

move([n,B,C,D,E,F],[B,n,C,D,E,F]).
move([n,B,C,D,E,F],[D,B,C,n,E,F]).
move([A,n,C,D,E,F],[A,C,n,D,E,F]). 
move([A,n,C,D,E,F],[n,A,C,D,E,F]).
move([A,n,C,D,E,F],[A,E,C,D,n,F]).
move([A,B,n,D,E,F],[A,n,B,D,E,F]).
move([A,B,n,D,E,F],[A,B,F,D,E,n]).
move([A,B,C,n,E,F],[n,B,C,A,E,F]).
move([A,B,C,n,E,F],[A,B,C,E,n,F]).
move([A,B,C,D,n,F],[A,n,C,D,B,F]).
move([A,B,C,D,n,F],[A,B,C,n,D,F]).
move([A,B,C,D,n,F],[A,B,C,D,F,n]).
move([A,B,C,D,E,n],[A,B,C,D,n,E]).
move([A,B,C,D,E,n],[A,B,n,D,E,C]).

get_answer([X]):-write(X),!.
get_answer([A,B|Tail]):-
	get_answer([B|Tail]),
	nl,
	write(A).
 
prolong([X|T],[Y,X|T]):-
	move(X,Y),
	not(member(Y,[X|T])).
	
bfs([[Finish|Tail]|_],Finish,[Finish|Tail]). 
bfs([TempWay|OtherWays],Finish,Way):-  
    findall(W,prolong(TempWay,W),Ways),  
    append(OtherWays,Ways,NewWays), 
    bfs(NewWays,Finish,Way).

dfs([Finish | Tail], Finish, [Finish | Tail]).
dfs(TempWay, Finish, Way):-
	prolong(TempWay, NewWay),
    dfs(NewWay, Finish, Way).
	
generate_d(1).
generate_d(N):-generate_d(M), N is M + 1.

id([Finish | Tail], Finish, [Finish | Tail], 0).
id(TempWay, Finish, Way, N):-
    N > 0,
    prolong(TempWay, NewWay),
    N1 is N - 1,
    id(NewWay, Finish, Way, N1).

get_bfs(Start,Finish):- 
	statistics(walltime, _),
	bfs([[Start]],Finish,Way),
	statistics(walltime, [_ | [ExecutionTime]]),
	get_answer(Way),
	write('Time '), write(ExecutionTime), write(' msec.'), nl.
get_dfs(Start,Finish):- 
	statistics(walltime, _),
	dfs([Start], Finish, Way), 
	statistics(walltime, [_ | [ExecutionTime]]),
	get_answer(Way),
	write('Time '), write(ExecutionTime), write(' msec.'), nl.
	
get_id(A,B) :-
    statistics(walltime, _),
    generate_d(DL),
    id([A],B,P,DL),
    statistics(walltime, [_ | [ExecutionTime]]),
	get_answer(P),
    write('Time '), write(ExecutionTime), write(' msec.'), nl.
	

	
