check(son, Parent, Child) :-
        parent(Parent, Child),
    sex(Child, m).

check(daughter, Parent, Child) :-
    parent(Parent, Child),
    sex(Child, f).
    
check(husband, Wife, Husband) :-
    parent(Husband, X),
    sex(Husband, m),
    parent(Wife, X),
    sex(Wife, f).

check(wife, Husband, Wife) :-
    parent(Husband, X),
    sex(Husband, m),
    parent(Wife, X),
    sex(Wife, f).

check(father, Child, Father) :-
    parent(Father, Child),
        sex(Father, m).

check(mother, Child, Mother) :-
        parent(Mother, Child),
        sex(Mother, f).

check(brother, Child1, Child2) :-
    parent(P, Child1),!,
    parent(P, Child2),
    Child1 \= Child2,
    sex(Child2, m).
    
check(sister, Child1, Child2) :-
    parent(P, Child1),!,
    parent(P, Child2),
    Child1 \= Child2,
    sex(Child2, f). 
    
relative(Relation, X1, X2) :-
    check(Relation, X1, X2),!. 

move(X,Y):-
    check(_,X,Y).
    
prolong([X|T],[Y,X|T]):-
    move(X,Y),
    not(member(Y,[X|T])).
    
bfs([[Finish|Tail]|_],Finish,[Finish|Tail]). 
bfs([TempWay|OtherWays],Finish,Way):-  
    findall(W,prolong(TempWay,W),Ways),  
    append(OtherWays,Ways,NewWays), !,
    bfs(NewWays,Finish,Way).

    
find_relation([_], Pr, Pr).
find_relation([X,Y|T], Pr, Relation) :-
    check(Relate, X, Y),
    find_relation([Y|T], [Relate|Pr], Relation).

relative(Relation, X1, X2) :-
    bfs([[X1]], X2, R),
    reverse(R, Rel),
    write(Rel), nl,
    find_relation(Rel, [], Relation1),
    reverse(Relation1, Relation).
