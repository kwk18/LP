% Task 2: Relational Data
%Вариант 2 , данные - four.pl

% The line below imports the data
:- ['four.pl'].

%1.Напечатать средний балл для каждого предмета:

%Сумма всех оценок по предмету:
sumOfGrades([],0).
sumOfGrades([grade(X,Y)|L],N):-
sumOfGrades(L,M),
N is Y + M.

%Средний балл по каждому предмету:
aMark(Subject,Mark):-
subject(Subject,Y),
length(Y, L),
sumOfGrades(Y, S),
Mark is S / L.

%2.Для каждой группы, найти количество не сдавших студентов:


%3.Найти количество несдавших по каждому предмету:

numDidNotPass([],0).
numDidNotPass([grade(X,Y)|L],N):-
Y < 3, !,
numDidNotPass(L,M),
N is M + 1.
numDidNotPass([_|L],N):-
numDidNotPass(L,N).

didNotPassSub(S,N):-
subject(S,Y),
numDidNotPass(Y,N).
