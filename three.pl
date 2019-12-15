mother_in_law(Husband, X) :-
	parent(Husband, Y),
    sex(Husband, m),
	parent(Wife, Y),
	sex(Wife, f),
	parent(X, Wife),!,
	sex(X, f).
