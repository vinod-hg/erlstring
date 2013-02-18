%% @author vinod
%% @doc @todo Add description to erlstring_test.


-module(erlstring_test).

-compile(export_all).



test(No) ->
	%{T2, _} = timer:tc(?MODULE, tests, [No]),	
	{T1,_R} = timer:tc(?MODULE, testr, [No]),
	io:format("erlstring : ~p ~n", [_R]),
	%{T3,_} = timer:tc(erlstring, to_string, [R]),
	io:format("erlstring time: ~p ~n", [T1]).
	%io:format("string time: ~p~n", [T2]).

test1(No) ->
	io:format("Rope: ~p~n", [timer:tc(?MODULE, testr, [No])]),
	io:format("String: ~p~n", [timer:tc(?MODULE, tests, [No])]).

testr(No) ->
	R = 
	lists:foldl(fun(Count, R) ->
				R0 = erlstring:concat(R, integer_to_list(Count)),
				R1 = erlstring:concat(R0, "Hello"),
				R2 = erlstring:concat(R1, " "),
				erlstring:concat(R2, "World!")
				end, erlstring:new(), lists:seq(1, No bsr 2)),
	erlstring:to_string(R).

tests(No) ->
	lists:foldl(fun(Count, R) ->
				R0 = string:concat(R, integer_to_list(Count)),
				R1 = string:concat(R0, "Hello"),
				R2 = string:concat(R1, " "),
				string:concat(R2, "World!")
				end, "", lists:seq(1,No bsr 2)).

test_simple() ->
	R0 = erlstring:new(),
	erlstring:concat(R0, "Hello").



