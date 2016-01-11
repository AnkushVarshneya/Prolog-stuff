%flatten list before getting the occurrences
occurrences_of(X, List, Z) :- flatten_list(List, FList),
                              occurrences(X, FList, Z).

%ends the recursion as we finished going through the list
occurrences(_, [], 0).

%recursive step

%if head is same as X then increase count by one
occurrences(X, [X|T], Z) :- occurrences_of(X, T, N), Z is 1+N.

%if head is not the same as X search on tail
occurrences(X, [X1|T], Z) :- X1\=X, occurrences_of(X, T, Z).

%ends the recursion
flatten_list([], []).

%recursive step

%flaten head and tail and concat the results
%flaten the head and tail then concat the results
flatten_list([X|T1], L2) :- flatten_list(X, Xf),
                            flatten_list(T1, T1f),
                            conc(Xf, T1f, L2).

%if head is not a list then continue to flaten the tail
flatten_list([X|T1], [X|T2]) :- X \= [],
                                X \=[_|_],
                                flatten_list(T1, T2).

% must cut after first call to pow, else this will go on forever
power(X, Y, Z) :- pow(X, Y, Z), !.
                                        
%ends the recursion as any thing to the power of 0 is one
pow(0, _, 0).
pow(_, 0, 1).
%recursive step decrease index and increase power
pow(Number, Index, Power) :- pow(Number, I, P),
                             Index is I + 1,
							 Power is P * Number.

%concat from traditional notes
conc([ ], L, L). 
conc([H | T1], L2, [H | T3]) :- conc(T1, L2, T3).