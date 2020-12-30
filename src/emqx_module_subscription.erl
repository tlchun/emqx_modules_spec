%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:38
%%%-------------------------------------------------------------------
-module(emqx_module_subscription).
-author("root").


-export([on_module_create/2, on_module_update/4, on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<77, 81, 84, 84, 32, 83, 117, 98, 115, 99, 114, 105,
    112, 116, 105, 111, 110>>,
    zh =>
    <<77, 81, 84, 84, 32, 228, 187, 163, 231, 144, 134,
      232, 174, 162, 233, 152, 133>>},
  destroy => on_module_destroy, name => subscription,
  params =>
  #{subscription_opts =>
  #{default => [],
    description =>
    #{en =>
    <<83, 117, 98, 115, 99, 114, 105, 112, 116,
      105, 111, 110, 32, 79, 112, 116, 115>>,
      zh =>
      <<232, 174, 162, 233, 152, 133, 233, 128,
        137, 233, 161, 185>>},
    items =>
    #{default => #{},
      schema =>
      #{nl =>
      #{default => 0,
        description =>
        #{en =>
        <<77, 81, 84, 84, 32, 84,
          111, 112, 105, 99, 32,
          78, 111, 32, 76, 111,
          99, 97, 108>>,
          zh =>
          <<77, 81, 84, 84, 32, 84,
            111, 112, 105, 99, 32,
            78, 111, 32, 76, 111,
            99, 97, 108>>},
        enum => [0, 1], order => 3,
        title =>
        #{en => <<78, 76>>,
          zh => <<78, 76>>},
        type => number},
        qos =>
        #{default => 0,
          description =>
          #{en =>
          <<77, 81, 84, 84, 32, 84,
            111, 112, 105, 99, 32,
            81, 111, 83>>,
            zh =>
            <<77, 81, 84, 84, 32,
              230, 156, 141, 229,
              138, 161, 232, 180,
              168, 233, 135, 143>>},
          enum => [0, 1, 2], order => 2,
          title =>
          #{en => <<81, 111, 83>>,
            zh =>
            <<230, 156, 141, 229,
              138, 161, 232, 180,
              168, 233, 135, 143>>},
          type => number},
        rap =>
        #{default => 0,
          description =>
          #{en =>
          <<77, 81, 84, 84, 32, 84,
            111, 112, 105, 99, 32,
            82, 101, 116, 97, 105,
            110, 32, 65, 115, 32,
            80, 117, 98, 108, 105,
            115, 104, 101, 100>>,
            zh =>
            <<77, 81, 84, 84, 32, 84,
              111, 112, 105, 99, 32,
              82, 101, 116, 97, 105,
              110, 32, 65, 115, 32,
              80, 117, 98, 108, 105,
              115, 104, 101, 100>>},
          enum => [0, 1], order => 4,
          title =>
          #{en => <<82, 65, 80>>,
            zh => <<82, 65, 80>>},
          type => number},
        rh =>
        #{default => 0,
          description =>
          #{en =>
          <<77, 81, 84, 84, 32, 84,
            111, 112, 105, 99, 32,
            82, 101, 116, 97, 105,
            110, 32, 72, 97, 110,
            100, 108, 105, 110,
            103>>,
            zh =>
            <<77, 81, 84, 84, 32, 84,
              111, 112, 105, 99, 32,
              82, 101, 116, 97, 105,
              110, 32, 72, 97, 110,
              100, 108, 105, 110,
              103>>},
          enum => [0, 1], order => 5,
          title =>
          #{en => <<82, 72>>,
            zh => <<82, 72>>},
          type => number},
        topic =>
        #{default => <<>>,
          description =>
          #{en =>
          <<77, 81, 84, 84, 32, 84,
            111, 112, 105, 99>>,
            zh =>
            <<77, 81, 84, 84, 32,
              228, 184, 187, 233,
              162, 152>>},
          order => 1,
          title =>
          #{en =>
          <<84, 111, 112, 105,
            99>>,
            zh =>
            <<228, 184, 187, 233,
              162, 152>>},
          type => string}},
      type => object},
    order => 1,
    title =>
    #{en =>
    <<83, 117, 98, 115, 99, 114, 105, 112, 116,
      105, 111, 110, 32, 79, 112, 116, 115>>,
      zh =>
      <<232, 174, 162, 233, 152, 133, 233, 128,
        137, 233, 161, 185>>},
    type => array}},
  status => on_module_status,
  title =>
  #{en =>
  <<77, 81, 84, 84, 32, 83, 117, 98, 115, 99, 114, 105,
    112, 116, 105, 111, 110>>,
    zh =>
    <<77, 81, 84, 84, 32, 228, 187, 163, 231, 144, 134,
      232, 174, 162, 233, 152, 133>>},
  type => module, update => on_module_update}).

-vsn("4.2.2").

on_module_create(_ModuleId,
    #{<<"subscription_opts">> := SubOpts0}) ->
  SubOpts = lists:map(fun (Map) ->
    {Topic, Opts} = maps:take(<<"topic">>, Map),
    {Topic, unsafe_atom_key_map(Opts)}
                      end,
    SubOpts0),
  emqx:hook('client.connected',
    {emqx_mod_subscription, on_client_connected,
      [SubOpts]}),
  #{}.

on_module_update(_ModuleId, Context, Config, Config) ->
  Context;
on_module_update(ModuleId, Context, _Config,
    NewConfig) ->
  on_module_destroy(ModuleId, Context),
  on_module_create(ModuleId, NewConfig).

on_module_destroy(_ModuleId, #{}) ->
  emqx:unhook('client.connected',
    {emqx_mod_subscription, on_client_connected}),
  ok.

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

unsafe_atom_key_map(BinKeyMap) when is_map(BinKeyMap) ->
  maps:fold(fun (K, V, Acc) when is_binary(K) ->
    Acc#{binary_to_atom(K, utf8) => unsafe_atom_key_map(V)};
    (K, V, Acc) when is_list(K) ->
      Acc#{list_to_atom(K) => unsafe_atom_key_map(V)};
    (K, V, Acc) when is_atom(K) ->
      Acc#{K => unsafe_atom_key_map(V)}
            end,
    #{}, BinKeyMap);
unsafe_atom_key_map(ListV) when is_list(ListV) ->
  [unsafe_atom_key_map(V) || V <- ListV];
unsafe_atom_key_map(Val) -> Val.

