%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:38
%%%-------------------------------------------------------------------
-module(emqx_module_recon).
-author("root").

-export([on_module_create/2, on_module_destroy/2, on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create, description =>
  #{en => <<82, 101, 99, 111, 110>>, zh => <<82, 101, 99, 111, 110>>},
  destroy => on_module_destroy, name => recon,
  params => #{}, status => on_module_status,
  title => #{en => <<82, 101, 99, 111, 110>>, zh => <<82, 101, 99, 111, 110>>}, type => devops, update => on_module_update}).



on_module_create(_ModuleId, _Config) ->
  _ = application:ensure_all_started(recon),
  emqx_recon_cli:load(),
  #{}.

on_module_destroy(_ModuleId, _Params) ->
  emqx_recon_cli:unload(), ok.

on_module_status(_ModuleId, _Params) ->
  #{is_alive => true}.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params.

