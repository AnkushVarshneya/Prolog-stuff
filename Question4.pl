/*
 facts
 note: father, mother, difference are rules
 (this is allowed as culearn post:
 https://culearn.carleton.ca/moodle/mod/forum/discuss.php?d=87676
 male, female, parent, spouse are the only rules
 note: ex spouses are not concidered spouses
 so your blood-uncles's ex is not your aunt
 and your blood-aunts's ex is not your uncle
 */


male(granpa1).
male(granpa2).
male(dad).
male(sdad).
male(uncle1).
male(uncle2).
male(uncle2-1).
male(mcousin1).
male(hbrother).
male(me).

female(granma1).
female(granma2).
female(mom).
female(smom).
female(aunt1).
female(aunt2).
female(aunt1-1).
female(fcousin1).
female(hsister).
female(sister).

parent(granpa1,dad).
parent(granpa1,uncle1).
parent(granpa1,aunt1).
parent(granma1,dad).
parent(granma1,uncle1).
parent(granma1,aunt1).
parent(granpa2,mom).
parent(granpa2,uncle2).
parent(granpa2,aunt2).
parent(granma2,mom).
parent(granma2,uncle2).
parent(granma2,aunt2).
parent(dad,me).
parent(dad,sister).
parent(dad,hbrother).
parent(mom,me).
parent(mom,sister).
parent(mom,hsister).
parent(smom,hbrother).
parent(sdad,hsister).
parent(uncle1, mcousin1).
parent(aunt1-1, mcousin1).
parent(uncle2-1, fcousin1).
parent(aunt2, fcousin1).

spouse(granpa1, granma1).
spouse(granma1, gradpa1).
spouse(granpa2, granma2).
spouse(granma2, gradpa2).
spouse(mom,dad).
spouse(dad,mom).
spouse(uncle1,aunt1-1).
spouse(aunt1-1,uncle1).
spouse(aunt2,uncle2-1).
spouse(uncle2-1,aunt2).

/* X is a mother */
is_mother(X) :- mother_of(X, _).

/* X is a father */
is_father(X) :- father_of(X, _).

/* X is an aunt of Y */
aunt(X, Y) :- female(X), sibling(X, Z), parent(Z, Y).
aunt(X, Y) :- female(X), half_sibling(X, Z), parent(Z, Y).
aunt(X, Y) :- female(X), spouse(X, W),
	                 sibling(W, Z), parent(Z, Y).
aunt(X, Y) :- female(X), spouse(X, W),
			 half_sibling(W, Z), parent(Z, Y).

/* X is an aunt of Y */
uncle(X, Y) :- male(X), sibling(X, Z), parent(Z, Y).
uncle(X, Y) :- male(X), half_sibling(X, Z), parent(Z, Y).
uncle(X, Y) :- male(X), spouse(X, W),
	                sibling(W, Z), parent(Z, Y).
uncle(X, Y) :- male(X), spouse(X, W),
	                half_sibling(W, Z), parent(Z, Y).

/* X is a sister of Y */
sister_of(X,Y) :- female(X), sibling(X, Y).
sister_of(X,Y) :- female(X), half_sibling(X, Y).

/* X is a brother of Y */
brother_of(X,Y) :- male(X), sibling(X, Y).
brother_of(X,Y) :- male(X), half_sibling(X, Y).

/* X is a grandfather of Y */
grandfather_of(X, Y) :- father_of(X, P), parent(P, Y).

/* X is a grandmother of Y */
grandmother_of(X, Y) :- mother_of(X, P), parent(P, Y).

/* X is a grandchild of Y */
grandchild(X, Y) :- parent(Y, P), parent(P, X).

/* X is a father of Y */
father_of(X, Y) :- male(X), parent(X, Y).

/* X is a mother of Y */
mother_of(X, Y) :- female(X), parent(X, Y).

/* X is a sibling of Y,
   i.e they have the same parents */
sibling(X, Y) :- difference(X ,Y),
	        mother_of(M, X), mother_of(M, Y),
		father_of(F, X), father_of(F, Y).

/*they have same mother but different fathers or
  same father, different mothers
  ie. they only have one parent in common, but not both*/
half_sibling(X, Y) :- difference(X, Y),
	              mother_of(M, X), mother_of(M, Y),
	              father_of(I, X), father_of(J, Y),
		      difference(I, J).
half_sibling(X, Y) :- difference(X, Y),
	              father_of(F, X), father_of(F, Y),
		      mother_of(K, X), mother_of(L, Y),
		      difference(K, L).


/* X is related to Y
  1. X is Y's parent or related to Y's parent
  2. X is Y's aunt or related to Y's aunt
  3. X is Y's uncle or related to Y's uncle
  4. X is Y's spouse or related to Y's spouse
  5. case 1-4 with X/Y swapped ie Y is related to X

*/
related(X, Y) :- parent(X, Y).
related(X, Y) :- parent(X, Z), related(Z, Y).

related(X, Y) :- aunt(X, Y).
related(X, Y) :- aunt(X, Z), related(Z, Y).

related(X, Y) :- uncle(X, Y).
related(X, Y) :- uncle(X, Z), related(Z, Y).

related(X, Y) :- spouse(X, Y).
related(X, Y) :- spouse(X, Z), related(Z, Y).

related(X, Y) :- related(Y, X).


/* X is an ancestor of Y */
ancestor(X, Y) :- parent(X,Y).
ancestor(X, Y) :- parent(X,Z),ancestor(Z,Y).

/* X is a descendant of Y, i.e reverse ancestor*/
descendant(X, Y) :- ancestor(Y, X).

/* are X and Y diffrent? */
difference(X, Y) :- (X \==Y).

























