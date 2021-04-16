%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:37
%%%-------------------------------------------------------------------
-module(emqx_module_prometheus).
-author("root").

-export([on_module_create/2, on_module_update/4,
  on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<69, 77, 81, 32, 88, 32, 80, 114, 111, 109, 101, 116,
    104, 101, 117, 115, 32, 65, 103, 101, 110, 116>>,
    zh =>
    <<69, 77, 81, 32, 88, 32, 80, 114, 111, 109, 101, 116,
      104, 101, 117, 115, 32, 65, 103, 101, 110, 116>>},
  destroy => on_module_destroy, name => prometheus,
  params =>
  #{interval =>
  #{default => <<49, 53, 115>>,
    description =>
    #{en =>
    <<80, 114, 111, 109, 101, 116, 104, 101,
      117, 115, 32, 80, 117, 115, 104, 32, 73,
      110, 116, 101, 114, 118, 97, 108>>,
      zh =>
      <<229, 190, 128, 230, 153, 174, 231, 189,
        151, 231, 177, 179, 228, 191, 174, 230,
        150, 175, 230, 156, 141, 229, 138, 161,
        230, 142, 168, 233, 128, 129, 230, 149,
        176, 230, 141, 174, 231, 154, 132, 233,
        151, 180, 233, 154, 148, 229, 128,
        188>>},
    order => 2,
    title =>
    #{en =>
    <<80, 117, 115, 104, 32, 73, 110, 116, 101,
      114, 118, 97, 108>>,
      zh =>
      <<230, 142, 168, 233, 128, 129, 233, 151,
        180, 233, 154, 148>>},
    type => string},
    url =>
    #{default =>
    <<104, 116, 116, 112, 58, 47, 47, 49, 50, 55, 46,
      48, 46, 48, 46, 49, 58, 57, 48, 57, 49>>,
      description =>
      #{en =>
      <<80, 114, 111, 109, 101, 116, 104, 101,
        117, 115, 32, 80, 117, 115, 104, 71, 97,
        116, 101, 119, 97, 121, 32, 85, 82, 76>>,
        zh =>
        <<230, 153, 174, 231, 189, 151, 231, 177,
          179, 228, 191, 174, 230, 150, 175, 32,
          80, 117, 115, 104, 71, 97, 116, 101, 119,
          97, 121, 32, 230, 156, 141, 229, 138,
          161, 231, 154, 132, 32, 85, 82, 76>>},
      order => 1,
      title =>
      #{en =>
      <<80, 117, 115, 104, 71, 97, 116, 101, 119,
        97, 121, 32, 85, 82, 76>>,
        zh =>
        <<80, 117, 115, 104, 71, 97, 116, 101, 119,
          97, 121, 32, 85, 82, 76>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<69, 77, 81, 32, 88, 32, 80, 114, 111, 109, 101, 116,
    104, 101, 117, 115, 32, 65, 103, 101, 110, 116>>,
    zh =>
    <<69, 77, 81, 32, 88, 32, 80, 114, 111, 109, 101, 116,
      104, 101, 117, 115, 32, 65, 103, 101, 110, 116>>},
  type => devops, update => on_module_update}).


on_module_create(_ModuleId,
    #{<<"url">> := Url0, <<"interval">> := Interval0}) ->
  Interval =
    cuttlefish_duration:parse(binary_to_list(Interval0)),
  _ = application:ensure_all_started(prometheus),
  Url = case Url0 of
          <<>> -> undefined;
          _ -> binary_to_list(Url0)
        end,
  {ok, Pid} = emqx_prometheus:start_link(Url, Interval),
  #{<<"pid">> => Pid}.

on_module_update(_ModuleId, Context, Config, Config) ->
  Context;
on_module_update(ModuleId, Context, _Config,
    NewConfig) ->
  on_module_destroy(ModuleId, Context),
  on_module_create(ModuleId, NewConfig).

on_module_destroy(_ModuleId, #{<<"pid">> := Pid}) ->
  gen_server:stop(Pid), ok.

on_module_status(_ModuleId, _) -> #{is_alive => true}.
