%% @author vinod
%% @doc @todo Add description to erlstring.


-module(erlstring).

-export([new/0,
		 concat/2,
		 to_string/1,
		 len/1
		]).


%% Exported Functions

new() ->
	{0, 0, nil, nil}.

concat(Tree, String) ->
	insert(Tree, String).

to_string(Tree) ->
	to_list(Tree).

len({_H,Len,_LT, _RT}) ->
	Len.

%% Internal Functions


insert({0, 0, nil, nil}, Val) ->
	get_leaf_node(Val, length(Val));
	
insert({H, L, LT, nil}, Val) ->
	ValL = length(Val),
	{H, L + ValL, LT, get_leaf(Val, ValL)};

insert( Root, Val) ->
	insert_new(Root, Val, length(Val)).

% Return false when the parent and child have subsequent height 
create_new(_R = {H, _L, _LT, _RT = {CH, _CHL, _CLT, _CRT} }, _Val, _VL ) when H == (CH + 1) ->
	false;
create_new(R, Val, VL) ->
	create_new_node(R, Val, VL).


create_new_node(R = {_H, _L, _LT, _RT = {_LL, _Leaf } }, Val, VL ) ->
	get_node(R, get_leaf_node(Val, VL));
create_new_node(R = {H, _L, _LT, _RT = {CH, _CHL, _CLT, _CRT} }, Val, VL ) when H == (CH + 1) ->
	get_node(R, get_leaf_node(Val, VL));
create_new_node(_R = {H, L, LT, RT }, Val, VL ) ->
	{H, L+VL, LT, get_node(RT, get_leaf_node(Val, VL))} .
			  
		  

insert_right(_R = { H, L, LT, nil}, Val, VL ) ->
	{H, L+VL, LT, get_leaf(Val, VL)};
insert_right({ _H, _L, _LT, _RT = {_LL, _Leaf}}, _Val, _VL) ->
	false;
insert_right(R = { H, L, LT, RT }, Val, VL) ->
	case insert_right(RT, Val, VL) of
		false ->
			create_new(R, Val, VL);
		NewRT ->
			{H,L+VL, LT, NewRT}
	end.

insert_new(R , Val, VL) ->
	case insert_right(R, Val, VL) of
		false ->
			create_new_node(R, Val, VL);
		NewRT ->
			NewRT
	end.

get_node(Root = {H, L, _LT, _RT} , N = {_, NL, _,_}) ->
	{H +1, L+NL, Root, N}.



get_leaf_node(Val, L) ->
	{1, L, get_leaf(Val, L), nil}.

get_leaf(Val, L) ->
	{L, Val}.


% Left + Right Tree

to_list({0, 0, nil,nil}) -> [];
to_list(Tree) -> 
	to_list(Tree, []).
	
to_list(nil, Acc) -> Acc;
to_list({_L, Leaf}, Acc) -> Leaf ++ Acc;
to_list({_H, _L, LT, RT}, Acc) -> 
	RTVal = to_list(RT, Acc),
	to_list(LT, RTVal).
