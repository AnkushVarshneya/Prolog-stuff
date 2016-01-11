/*
SWI-Prolog requires us to declare as dynamic any predicates that may change.
Also retract all existing statements in the knowledge base, for easier restart.
*/

:- dynamic i_am_at/1, at/2, holding/1.
:- retractall(at(_, _)),
    retractall(i_am_at(_)),
    retractall(holding(_)).

/*
start is the first rule we will run when grading your game. Anything you want to be
seen first should go in here. This one just prints out where you currently are in
the world.
*/

start :- look.

/*
World Setup
*/
path(outside_maze, *, room1). % use * to enter maze
path(room1, n, room5). %there is a path from the room1 to the room5 moving north
path(room1, s, room6). %there is a path from the room1 to the room6 moving south
path(room1, e, room2). %there is a path from the room1 to the room2 moving east

path(room2, n, room7). %there is a path from the room2 to the room7 moving north
path(room2, s, room8). %there is a path from the room2 to the room8 moving south
path(room2, e, room3). %there is a path from the room2 to the room3 moving east
path(room2, w, room1). %there is a path from the room2 to the room1 moving west

path(room3, e, room4). %there is a path from the room3 to the room4 moving east
path(room3, w, room2). %there is a path from the room2 to the room2 moving west

path(room4, w, room3). %there is a path from the room4 to the room3 moving west

path(room5, s, room1). %there is a path from the room5 to the room1 moving south

path(room6, n, room1). %there is a path from the room6 to the room1 moving north

path(room7, s, room2). %there is a path from the room7 to the room2 moving south

path(room8, n, room2). %there is a path from the room8 to the room2 moving north
path(room8, e, room9). %there is a path from the room8 to the room9 moving east

path(room9, e, room10).%there is a path from the room9 to the room10 moving east
path(room9, w, room8). %there is a path from the room9 to the room8 moving west


at(room1, object1).    %there is a object1 object in the room1
at(room3, object2).    %there is a object2 object in the room3
at(room5, object3).    %there is a object3 object in the room5
at(room7, object4).    %there is a object4 object in the room7
at(room9, object5).    %there is a object5 object in the room9


i_am_at(outside_maze).            %player's initial location

/*
Verbs
*/

%Move - if the movement is valid, move the player.
%also make sure there is not object in the room thats unpicked
move(Dir) :-
    i_am_at(X),
	not(at(X,_)),
    path(X, Dir, Y),
    retract(i_am_at(X)),
    assert(i_am_at(Y)),
    write('You have moved to '), write(Y), write('.'), nl,
    look,
    !.

%Move - otherwise, tell the player they can't move.
move(_) :-
    write('You cannot move that direction right now.'), nl,
    write('Make sure the direction is valid and you picked up any objects.'), nl.
	
%Pick up object - if already holding the object, can't pick it up!
pickup(X) :-
    holding(X),
    write('You are already holding it!'), nl,
    !.

%Pick up object - if in the right location, pick it up and remove it from the ground.
pickup(X) :-
    i_am_at(Place),
    at(Place, X),
    retract(at(Place, X)),
    assert(holding(X)),
    write('You have picked it up.'), nl,
    !.

%Pick up object - otherwise, cannot pick up the object.
pickup(_) :-
    write('I do not see that here.'), nl.


%Look - describe where in space the player is, list objects at the location
look :-
    i_am_at(X),
    describe(X),
    list_objects_at(X),
    describe_room_exit(X),
    !.

%List objects - these two rules effectively form a loop that go through every object
%                in the location and writes them out.
list_objects_at(X) :-
    at(X, Obj),
    write('There is a '), write(Obj), write(' on the ground.'), nl,
    fail.

list_objects_at(_).

% room description
describe(room1):-
    write('welcome to room1...'), nl,
    write('This is just the beginging, you still have a long way to go...'), nl.

describe(room2):-
    write('welcome to room2'), nl,
    write('You have completed 20% of your journey!'), nl.

describe(room3):-
    write('welcome to room3'), nl,
    write('You have completed 30% of your journey!'), nl.

describe(room4):-
    write('welcome to room4'), nl,
    write('You have completed 40% of your journey!'), nl.

describe(room5):-
    write('welcome to room5'), nl,
    write('You have completed 50% of your journey!'), nl.

describe(room6):-
    write('welcome to room6'), nl,
    write('You have completed 60% of your journey!'), nl.

describe(room7):-
    write('welcome to room7'), nl,
    write('You have completed 70% of your journey!'), nl.

describe(room8):-
    write('welcome to room8'), nl,
    write('You have completed 80% of your journey!'), nl.

describe(room9):-
    write('welcome to room9'), nl,
    write('You have completed 90% of your journey!'), nl.

describe(room10):-
    write('welcome to the room10'), nl,
    write('You have sucsessfully finished the journey!'), nl,
    write('Game Won!!!!'), nl.

% game description
describe(_):-
    write('You have entered a maze....'), nl,
    write('You must go from room to room...'),nl,
    write('Until you get to room10,'), nl,
    write('Where you will have completed the maze'),nl,
    write('you must collect objects to get out of certain rooms'), nl,
    write('and on to the next room....'), nl,
    write('there are 5 hidden objects you must collect to get past the last gate!'), nl.

%description to exit room
describe_room_exit(room1):-
    write('------Exit Instruction------'), nl,
    write('Move "n" to go to room5'), nl,
    write('Move "s" to go to room6'), nl,
    write('Move "e" to go to room2'), nl.

describe_room_exit(room2):-
    write('------Exit Instruction------'), nl,
    write('Move "n" to go to room7'), nl,
    write('Move "s" to go to room8'), nl,
    write('Move "e" to go to room3'), nl,
    write('Move "w" to go to room1'), nl.

describe_room_exit(room3):-
    write('------Exit Instruction------'), nl,
    write('Move "e" to go to room4'), nl,
    write('Move "w" to go to room2'), nl.

describe_room_exit(room4):-
    write('------Exit Instruction------'), nl,

    write('Move "w" to go to room3'), nl.

describe_room_exit(room5):-
    write('------Exit Instruction------'), nl,
    write('Move "s" to go to room1'), nl.

describe_room_exit(room6):-
    write('------Exit Instruction------'), nl,
    write('Move "n" to go to room1'), nl.

describe_room_exit(room7):-
    write('------Exit Instruction------'), nl,
    write('Move "s" to go to room2'), nl.

describe_room_exit(room8):-
    write('------Exit Instruction------'), nl,
    write('Move "n" to go to room2'), nl,
    write('Move "e" to go to room9'), nl.

describe_room_exit(room9):-
    write('------Exit Instruction------'), nl,
    write('Move "e" to go to room10'), nl,
    write('Move "w" to go to room8'), nl.

describe_room_exit(room10):-
    write('-------Maze Completed-------'), nl,
    write('------You won The Game------'), nl.

describe_room_exit(_):-
    write('------Exit Instruction------'), nl,
    write('Move "*" to go to room1'), nl.
