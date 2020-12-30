%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:37
%%%-------------------------------------------------------------------
-module(emqx_module_presence).
-author("root").

-export([on_module_create/2, on_module_update/4,
  on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<67, 108, 105, 101, 110, 116, 32, 80, 114, 101, 115,
    101, 110, 99, 101>>,
    zh =>
    <<229, 174, 162, 230, 136, 183, 231, 171, 175, 228,
      184, 138, 228, 184, 139, 231, 186, 191, 233, 128,
      154, 231, 159, 165>>},
  destroy => on_module_destroy, name => presence,
  params =>
  #{qos =>
  #{default => 0,
    description =>
    #{en =>
    <<80, 114, 101, 115, 101, 110, 99, 101, 32,
      77, 101, 115, 115, 97, 103, 101, 32, 81,
      111, 83>>,
      zh =>
      <<228, 184, 138, 228, 184, 139, 231, 186,
        191, 230, 182, 136, 230, 129, 175, 230,
        156, 141, 229, 138, 161, 232, 180, 168,
        233, 135, 143>>},
    enum => [0, 1, 2], order => 1,
    title =>
    #{en =>
    <<80, 114, 101, 115, 101, 110, 99, 101, 32,
      77, 101, 115, 115, 97, 103, 101, 32, 81,
      111, 83>>,
      zh =>
      <<228, 184, 138, 228, 184, 139, 231, 186,
        191, 230, 182, 136, 230, 129, 175, 230,
        156, 141, 229, 138, 161, 232, 180, 168,
        233, 135, 143>>},
    type => number}},
  status => on_module_status,
  title =>
  #{en => <<80, 114, 101, 115, 101, 110, 99, 101>>,
    zh =>
    <<228, 184, 138, 228, 184, 139, 231, 186, 191, 233,
      128, 154, 231, 159, 165>>},
  type => module, update => on_module_update}).

-vsn("4.2.2").

on_module_create(_ModuleId, #{<<"qos">> := QoS}) ->
  Env = [{qos, QoS}],
  emqx:hook('client.connected',
    {emqx_mod_presence, on_client_connected, [Env]}),
  emqx:hook('client.disconnected',
    {emqx_mod_presence, on_client_disconnected, [Env]}),
  #{}.

on_module_update(_ModuleId, Context, Config, Config) ->
  Context;
on_module_update(ModuleId, Context, _Config,
    NewConfig) ->
  on_module_destroy(ModuleId, Context),
  on_module_create(ModuleId, NewConfig).

on_module_destroy(_ModuleId, _) ->
  emqx:unhook('client.connected',
    {emqx_mod_presence, on_client_connected}),
  emqx:unhook('client.disconnected',
    {emqx_mod_presence, on_client_disconnected}),
  ok.

on_module_status(_ModuleId, _) -> #{is_alive => true}.

