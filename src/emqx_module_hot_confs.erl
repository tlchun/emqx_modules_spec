%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:36
%%%-------------------------------------------------------------------
-module(emqx_module_hot_confs).
-author("root").

-export([on_module_create/2, on_module_update/4, on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<72, 111, 116, 32, 99, 111, 110, 102, 105, 103, 117,
    114, 97, 116, 105, 111, 110>>,
    zh => <<231, 131, 173, 233, 133, 141, 231, 189, 174>>},
  destroy => on_module_destroy, name => hot_confs,
  params => #{}, status => on_module_status,
  title =>
  #{en =>
  <<72, 111, 116, 32, 99, 111, 110, 102, 105, 103, 117,
    114, 97, 116, 105, 111, 110>>,
    zh => <<231, 131, 173, 233, 133, 141, 231, 189, 174>>},
  type => devops, update => on_module_update}).

-vsn("4.2.2").

on_module_create(_ModId, _Config) ->
  PluginsEtcDir = emqx:get_env(plugins_etc_dir),
  BaseDir = re:replace(PluginsEtcDir, "plugins/", "",
    [{return, list}]),
  AppEtcDirs = [{emqx, sys_mon, BaseDir},
    {emqx, listeners, BaseDir}, {emqx, zones, BaseDir},
    {emqx, BaseDir}],
  emqx_conf:init_by_module(AppEtcDirs),
  case emqx_modules_registry:find_module_params(hot_confs)
  of
    not_found -> emqx_conf:refresh_confs(AppEtcDirs);
    {ok, {module_params, _, Params, _}} ->
      case maps:get(created, Params, false) of
        false -> emqx_conf:refresh_confs(AppEtcDirs);
        true -> ok
      end;
    _ -> ok
  end,
  emqx_modules_registry:add_module_params({module_params,
    hot_confs, #{created => true},
    #{}}),
  #{}.

on_module_update(_ModId, Params, Config, Config) ->
  Params.

on_module_destroy(_ModId, #{}) -> ok.

on_module_status(_ModId, _) -> #{is_alive => true}.

