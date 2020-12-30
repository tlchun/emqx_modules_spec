%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:36
%%%-------------------------------------------------------------------
-module(emqx_module_delayed_publish).
-author("root").

-export([on_module_create/2, on_module_destroy/2, on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<77, 101, 115, 115, 97, 103, 101, 32, 68, 101, 108,
    97, 121, 101, 100, 32, 80, 117, 98, 108, 105, 115,
    104>>,
    zh =>
    <<230, 182, 136, 230, 129, 175, 229, 187, 182, 232,
      191, 159, 229, 143, 145, 229, 184, 131>>},
  destroy => on_module_destroy, name => delayed_publish,
  params => #{}, status => on_module_status,
  title =>
  #{en =>
  <<68, 101, 108, 97, 121, 101, 100, 32, 80, 117, 98,
    108, 105, 115, 104>>,
    zh =>
    <<229, 187, 182, 232, 191, 159, 229, 143, 145, 229,
      184, 131>>},
  type => module, update => on_module_update}).

-vsn("4.2.2").

on_module_create(_ModId, _) ->
  emqx_modules_sup:start_child(emqx_mod_delayed, worker),
  emqx:hook('message.publish',
    {emqx_mod_delayed, on_message_publish, []}),
  #{}.

on_module_destroy(_ModId, _) ->
  emqx:unhook('message.publish',
    {emqx_mod_delayed, on_message_publish}),
  emqx_modules_sup:stop_child(emqx_mod_delayed),
  ok.

on_module_status(_ModId, _) -> #{is_alive => true}.

on_module_update(_ModId, Config, Config, Params) ->
  Params.

