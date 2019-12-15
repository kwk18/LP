prefix("вы").
prefix("у").
prefix("из").
prefix("о").
okonch("ила", gen("Ж"), n("ед")).
okonch("ил", gen("М"), n("ед")).
okonch("или", gen("мн"), n("мн")).
okonch("ило", gen("СР"), n("ед")).
suffix("ова").
suffix("онн").
suffix("ан").
suffix("ин").
suffix("енн").
suffix("ива").



an_morf(Word,morf(Prefix_,root(Rest),Suf,Okonch,Gender,Num)):-
isPrefix(Word,Prefix_,WordOne),
isEnd(WordOne,Okonch,Gender,Num,WordTwo),
isSuffix(WordTwo,Suf,Rest), !.

isPrefix(Word,prefix(Prefix_),Rest):-
prefix(Prefix_),
concat(Prefix_,Rest,Word).
isPrefix(Rest,prefix(""),Rest).

isRoot(Word,root(Root),Rest):-
root_(Root),
concat(Root,Rest,Word).

isSuffix(Word,suf(Suffiks),Rest):-
suffix(Suf),
concat(WordOne,Suf,Word),
isSuffix(WordOne,suf(Suffiks1),Rest),
concat(Suffiks1,Suf,Suffiks),!.
isSuffix(Word,suf(""),Word).

isEnd(Word,okonch(Okonch),Gender,Num,Rest):-
okonch(Okonch,Gender,Num),
concat(Rest,Okonch,Word).
isEnd(Word,okonch(""),gender("muzh"),num("ed"),Word).
