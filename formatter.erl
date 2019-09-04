-module(formatter).
-export([my_bitstr/1]).

my_bitstr(Str) ->
	RangeList = lists:foldl(fun gen_range_list/2, [], str_to_arr(Str)),
	NewStr = string:join(lists:foldl(fun gen_format_range_list/2, [], RangeList), ","),
	list_to_binary(NewStr).

str_to_arr(Str) ->
	lists:sort([list_to_integer(X) ||
		X <- string:tokens(binary_to_list(Str), ",")]).
	
gen_range_list(CurrElem, []) ->
	[[CurrElem]];
gen_range_list(CurrElem, [[PrevElem | TailRange] | Stack])
		when CurrElem == PrevElem + 1 ->
	if length(TailRange) == 0 ->
		[[CurrElem, PrevElem] | Stack];
	true ->
		[[CurrElem | TailRange] | Stack]
	end;
gen_range_list(CurrElem, Stack) ->
	[[CurrElem] | Stack].

gen_format_range_list([Elem], Acc) ->
	[integer_to_list(Elem) | Acc];
gen_format_range_list([LastElem, FirstElem], Acc) ->
	[string:join([integer_to_list(FirstElem), integer_to_list(LastElem)], "-") | Acc].

