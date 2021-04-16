%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:39
%%%-------------------------------------------------------------------
-module(emqx_module_topic_metrics).
-author("root").

-export([on_module_create/2, on_module_update/4,
  on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<84, 111, 112, 105, 99, 32, 77, 101, 116, 114, 105,
    99, 115>>,
    zh =>
    <<228, 184, 187, 233, 162, 152, 231, 155, 145, 230,
      142, 167>>},
  destroy => on_module_destroy, name => topic_metrics,
  params => #{}, status => on_module_status,
  title =>
  #{en =>
  <<84, 111, 112, 105, 99, 32, 77, 101, 116, 114, 105,
    99, 115>>,
    zh =>
    <<228, 184, 187, 233, 162, 152, 231, 155, 145, 230,
      142, 167>>},
  type => module, update => on_module_update}).


on_module_create(_ModuleId, _) ->
  emqx_modules_sup:start_child(emqx_mod_topic_metrics,
    worker),
  emqx_mod_topic_metrics:load([]),
  #{}.

on_module_update(_ModuleId, Context, Config, Config) ->
  Context.

on_module_destroy(_ModuleId, _) ->
  emqx_modules_sup:stop_child(emqx_mod_topic_metrics),
  emqx_mod_topic_metrics:unload([]),
  ok.

on_module_status(_ModuleId, _) -> #{is_alive => true}.

