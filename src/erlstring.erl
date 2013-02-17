%% @author vinod
%% @doc @todo Add description to erlstring.


-module(erlstring).

-export([new/0,
		 concat/2,
		 to_string/1
		]).


%% Exported Functions

new() ->
	{0, nil, nil}.

concat(Tree, String) ->
	insert(Tree, String).

to_string(Tree) ->
	to_list(Tree).


%% Internal Functions


insert({0, nil, nil}, Val) ->
	get_leaf_node(Val);
	
insert({H, LT, nil}, Val) ->
	{H, LT,get_leaf(Val)};

insert( Root, Val) ->
	insert_new(Root, Val).

create_new(_R = {H, _LT, _RT = {CH, _CLT, _CRT} }, _Val ) when H == (CH + 1) ->
	false;
create_new(R, Val) ->
	create_new_node(R, Val).


create_new_node(R = {_H, _LT, _RT = {_L, _Leaf } }, Val ) ->
	get_node(R, get_leaf_node(Val));
create_new_node(R = {H, _LT, _RT = {CH, _CLT, _CRT} }, Val ) when H == (CH + 1) ->
	get_node(R, get_leaf_node(Val));
create_new_node(_R = {H, LT, RT }, Val ) ->
	{H, LT, get_node(RT, get_leaf_node(Val))} .
			  
		  

insert_right(_R = { H, LT, nil}, Val ) ->
	{H, LT, get_leaf(Val)};
insert_right({ _H, _LT, _RT = {_L, _Leaf}}, _Val) ->
	false;
insert_right(R = { H, LT, RT }, Val) ->
	case insert_right(RT, Val) of
		false ->
			create_new(R, Val);
		NewRT ->
			{H,LT, NewRT}
	end.

insert_new(R , Val) ->
	case insert_right(R, Val) of
		false ->
			create_new_node(R, Val);
		NewRT ->
			NewRT
	end.

get_node(Root = {H, _LT, _RT} , N) ->
	{H +1, Root, N}.



get_leaf_node(Val) ->
	{1, get_leaf(Val), nil}.

get_leaf(Val) ->
	{length(Val), Val}.


% Left + Right Tree

to_list({0,nil,nil}) -> [];
to_list(Tree) -> 
	to_list(Tree, []).
	
to_list(nil, Acc) -> Acc;
to_list({_L, Leaf}, Acc) -> Leaf ++ Acc;
to_list({_H, LT, RT}, Acc) -> 
	RTVal = to_list(RT, Acc),
	to_list(LT, RTVal).
