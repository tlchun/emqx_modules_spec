%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:35
%%%-------------------------------------------------------------------
-module(emqx_module_auth_psk_file).
-author("root").

-export([on_module_create/2, on_module_update/4,
  on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<80, 75, 83, 70, 105, 108, 101, 32, 65, 85, 84, 72>>,
    zh =>
    <<80, 75, 83, 70, 105, 108, 101, 32, 232, 174, 164,
      232, 175, 129>>},
  destroy => on_module_destroy,
  name => psk_authentication,
  params =>
  #{psk_file =>
  #{default => <<>>,
    description =>
    #{en => <<80, 83, 75, 32, 70, 105, 108, 101>>,
      zh =>
      <<80, 83, 75, 32, 230, 150, 135, 228, 187,
        182>>},
    order => 1,
    title =>
    #{en => <<80, 83, 75, 32, 70, 105, 108, 101>>,
      zh =>
      <<80, 83, 75, 32, 230, 150, 135, 228, 187,
        182>>},
    type => file}},
  status => on_module_status,
  title =>
  #{en =>
  <<80, 75, 83, 70, 105, 108, 101, 32, 65, 85, 84, 72>>,
    zh =>
    <<80, 75, 83, 70, 105, 108, 101, 32, 232, 174, 164,
      232, 175, 129>>},
  type => auth, update => on_module_update}).


on_module_create(ModuleId, Params) ->
  File = emqx_module_utils:save_upload_file(Params,
    ModuleId),
  emqx_psk_file:load(File),
  #{}.

on_module_destroy(_ModuleId, #{}) ->
  emqx_psk_file:unload(), ok.

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

