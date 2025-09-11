#! /usr/bin/env escript
%%! -noshell
main(_) ->
    All = read_all([]),
    case string:trim(All) of
        <<>> -> io:format(standard_error, "No input provided~n", []), halt(1);
        _ -> ok
    end,
    Lines0 = [ string:trim(L) || L <- re:split(All, "\r?\n", [{return, list}]), string:trim(L) =/= "" ],
    case Lines0 of
        [] -> io:format(standard_error, "Empty input~n", []), halt(1);
        _ -> ok
    end,
    Tokens = string:tokens(hd(Lines0), " "),
    HX = lists:nth(1, Tokens),
    HY = lists:nth(2, Tokens),
    MX = list_to_integer(HX), MY = list_to_integer(HY),
    Scents0 = sets:new(),
    Out = run_pairs(tl(Lines0), MX, MY, Scents0, []),
    lists:foreach(fun(X) -> io:format("~s~n", [X]) end, lists:reverse(Out)),
    io:format("~n").

read_all(Acc) ->
    case io:get_line(standard_io, '') of
        eof -> lists:flatten(lists:reverse(Acc));
        {ok, Line} -> read_all([Line | Acc]);
        Line -> read_all([Line | Acc])
    end.

run_pairs([Pos,Instr|Rest], MX, MY, Scents, Acc) ->
    [SX,SY,SD] = string:tokens(Pos, " "),
    X = list_to_integer(SX), Y = list_to_integer(SY), D = hd(SD),
    {X1,Y1,D1,Lost,Sc1} = run_instr(Instr, X, Y, D, MX, MY, Scents),
    Line = io_lib:format("~B ~B ~c~s", [X1,Y1,D1, case Lost of true -> " LOST"; false -> "" end]),
    run_pairs(Rest, MX, MY, Sc1, [lists:flatten(Line)|Acc]);
run_pairs(_, _, _, _Sc, Acc) -> Acc.

left($N)->$W; left($W)->$S; left($S)->$E; left($E)->$N.
right($N)->$E; right($E)->$S; right($S)->$W; right($W)->$N.
step($N)->{0,1}; step($E)->{1,0}; step($S)->{0,-1}; step($W)->{-1,0}; step(_)->{0,0}.
inside(X,Y,MX,MY) -> 0 =< X andalso X =< MX andalso 0 =< Y andalso Y =< MY.

run_instr([], X, Y, D, _, _, Sc) -> {X,Y,D,false,Sc};
run_instr(_, X, Y, D, _, _, Sc) when is_list(Sc), false -> {X,Y,D,false,Sc};
run_instr([C|Cs], X, Y, D, MX, MY, Sc) ->
    case C of
        $L -> run_instr(Cs, X, Y, left(D), MX, MY, Sc);
        $R -> run_instr(Cs, X, Y, right(D), MX, MY, Sc);
        $F -> {DX,DY} = step(D), NX = X+DX, NY = Y+DY,
              case inside(NX,NY,MX,MY) of
                  true -> run_instr(Cs, NX, NY, D, MX, MY, Sc);
                  false -> Key = {X,Y,D},
                           case sets:is_element(Key, Sc) of
                               true -> run_instr(Cs, X, Y, D, MX, MY, Sc);
                               false -> {X,Y,D,true, sets:add_element(Key, Sc)}
                           end
              end;
        _ -> run_instr(Cs, X, Y, D, MX, MY, Sc)
    end.

