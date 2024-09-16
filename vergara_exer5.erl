-module(vergara_exer5).
-export([main/0, test/0, pascal/1, composite/1]).

% function for getting factorial
factorial(N) when N>0 ->
	N*factorial(N-1);
factorial(0) ->
	1.

% calculates the value of a column in a row
combination(N, R) ->
	factorial(N) div (factorial(N-R) * factorial(R)).

% gets the rows of pascal's triangle
listloop(N, 0) ->					% base case when N is 0
	List = [combination(N, 0)];
listloop(N, R) ->					% function call
	List = listloop(N, R-1),		% recursion call
	[combination(N, R)] ++ List.	% appends answer to List
		
% prints pascal's triangle 
pascal(0) ->						% base case
	io:format("[1]~n");				% prints out [1] N is 0
pascal(X) ->
	pascal(X-1),						% recursion call
	io:format("~p~n", [listloop(X,X)]).	% prints out the rows of pascal's triangle


% References:
% https://exercism.org/tracks/erlang/exercises/pascals-triangle
% 

%------------------ composite or not

%function to check if it is prime
isComposite(H)->
    Remainder = (factorial(H-1) + 1) rem H, % n! = n × (n−1)! (Factorial function)
    if             
        Remainder == 0 -> io:fwrite("~p - no~n", [H]);   % if the remainder is 0, it is prime
        Remainder =/= H -> io:fwrite("~p - yes~n", [H])   % if the remainder is not 0, it is composite
    end.

% applies the function in every element in the list
composite(List)when length(List)>0 ->
  [H|T] = List, 					% gets the head and tail of the list
    isComposite(H),					% applies the function in the head

    if
		T == [] -> ok;				% stop when list is empty
		T =/= [] -> composite(T)  	% applies the function again
	end.


% References:
% https://www.toppr.com/guides/python-guide/examples/python-examples/python-program-find-factorial-number/#:~:text=To%20find%20the%20Python%20factorial,negative%20numbers%20is%20not%20defined.
% https://www.programiz.com/python-programming/examples/factorial

%------------------
%test cases from the exercise
test() ->
	io:format ("Test Cases~n"),
	io:format (" Pascal's Triangle ~n"),
    pascal(0),
	pascal(3),
	pascal(5),
	io:format (" Composite or Not ~n"),
	List=[3,6,9,1,2],
	composite(List).

% main function
main() ->
	{ok, [X]} = io:fread("Enter the Nth Row of the Pascal's Triangle: ","~d"),
	pascal(X),
	{ok, List} = io:read("Enter a List: "),
	composite(List).
