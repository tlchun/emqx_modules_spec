%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:36
%%%-------------------------------------------------------------------
-module(emqx_module_auth_sasl).
-author("root").

-export([on_module_create/2, on_module_update/4, on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<69, 110, 104, 97, 110, 99, 101, 100, 32, 65, 117,
    116, 104>>,
    zh =>
    <<77, 81, 84, 84, 32, 229, 162, 158, 229, 188, 186,
      232, 174, 164, 232, 175, 129>>},
  destroy => on_module_destroy, name => auth_sasl,
  params => #{}, status => on_module_status,
  title =>
  #{en =>
  <<69, 110, 104, 97, 110, 99, 101, 100, 32, 65, 117,
    116, 104>>,
    zh =>
    <<77, 81, 84, 84, 32, 229, 162, 158, 229, 188, 186,
      232, 174, 164, 232, 175, 129>>},
  type => module, update => on_module_update}).

-vsn("4.2.2").

on_module_create(_ModuleId, _) ->
  emqx_sasl:init(),
  emqx_sasl:load(),
  emqx_sasl_cli:load(),
  #{}.

on_module_update(_ModuleId, Context, Config, Config) ->
  Context.

on_module_destroy(_ModuleId, _) ->
  emqx_sasl_cli:unload(), emqx_sasl:unload(), ok.

on_module_status(_ModuleId, _) -> #{is_alive => true}.

