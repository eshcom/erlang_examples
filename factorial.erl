-module(factorial).
-export([my_fac/1]).

my_fac(0) -> 1;
my_fac(1) -> 1;
my_fac(N) -> my_fac(N, 1).

my_fac(N, Acc) when N > 1 ->
	my_fac(N - 1, N * Acc);
my_fac(1, Acc) -> Acc.
