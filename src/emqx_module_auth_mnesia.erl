%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:35
%%%-------------------------------------------------------------------
-module(emqx_module_auth_mnesia).
-author("root").

-export([on_module_create/2, on_module_update/4,
  on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<69, 114, 108, 97, 110, 103, 32, 73, 110, 116, 101,
    114, 110, 97, 108, 32, 68, 66, 32, 65, 85, 84, 72,
    47, 65, 67, 76>>,
    zh =>
    <<69, 114, 108, 97, 110, 103, 32, 229, 134, 133, 231,
      189, 174, 230, 149, 176, 230, 141, 174, 229, 186,
      147, 32, 232, 174, 164, 232, 175, 129, 47, 232, 174,
      191, 233, 151, 174, 230, 142, 167, 229, 136, 182>>},
  destroy => on_module_destroy,
  name => mnesia_authentication,
  params =>
  #{password_hash =>
  #{default => <<115, 104, 97, 50, 53, 54>>,
    description =>
    #{en =>
    <<112, 97, 115, 115, 111, 119, 114, 100,
      32, 104, 97, 115, 104>>,
      zh =>
      <<229, 138, 160, 229, 175, 134, 231, 177,
        187, 229, 158, 139>>},
    enum =>
    [<<112, 108, 97, 105, 110>>, <<109, 100, 53>>,
      <<115, 104, 97>>, <<115, 104, 97, 50, 53, 54>>,
      <<115, 104, 97, 53, 49, 50>>],
    order => 1,
    title =>
    #{en =>
    <<112, 97, 115, 115, 119, 111, 114, 100,
      32, 104, 97, 115, 104>>,
      zh =>
      <<229, 138, 160, 229, 175, 134, 231, 177,
        187, 229, 158, 139>>}}},
  status => on_module_status,
  title =>
  #{en =>
  <<73, 110, 116, 101, 114, 110, 97, 108, 32, 68, 66, 32,
    65, 85, 84, 72, 47, 65, 67, 76>>,
    zh =>
    <<229, 134, 133, 231, 189, 174, 230, 149, 176, 230,
      141, 174, 229, 186, 147, 32, 232, 174, 164, 232, 175,
      129, 47, 232, 174, 191, 233, 151, 174, 230, 142, 167,
      229, 136, 182>>},
  type => auth, update => on_module_update}).


on_module_create(_ModuleId, #{<<"password_hash">> := PasswordHash} = Params) ->
  application:set_env(emqx_auth_mnesia, password_hash, binary_to_atom(PasswordHash, utf8)),
  emqx_ctl:register_command(clientid, {emqx_auth_mnesia_cli, auth_clientid_cli}, []),
  emqx_ctl:register_command(username, {emqx_auth_mnesia_cli, auth_username_cli}, []),
  emqx_ctl:register_command(acl, {emqx_acl_mnesia_cli, cli}, []),
  load_auth_hook(Params),
  load_acl_hook(),
  #{}.

on_module_update(_ModuleId, Context, Config, Config) ->
  Context;
on_module_update(ModuleId, Context, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Context),
  on_module_create(ModuleId, Config).

on_module_destroy(_ModuleId, #{}) ->
  application:unset_env(emqx_auth_mnesia, password_hash),
  emqx:unhook('client.authenticate',
    fun emqx_auth_mnesia:check/3),
  emqx:unhook('client.check_acl',
    fun emqx_acl_mnesia:check_acl/5),
  emqx_ctl:unregister_command(clientid),
  emqx_ctl:unregister_command(username),
  emqx_ctl:unregister_command(acl),
  ok.

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

load_auth_hook(Params = #{<<"password_hash">> :=
PasswordHash}) ->
  ClientidList = maps:get(<<"clinetid_list">>, Params,
    []),
  UsernameList = maps:get(<<"username_list">>, Params,
    []),
  NClientidList = [{Clientid, Password}
    || #{<<"clientid">> := Clientid,
      <<"password">> := Password}
      <- ClientidList],
  NUsernameList = [{Username, Password}
    || #{<<"username">> := Username,
      <<"password">> := Password}
      <- UsernameList],
  ok = emqx_auth_mnesia:init(#{clientid_list =>
  NClientidList,
    username_list => NUsernameList}),
  ok = emqx_auth_mnesia:register_metrics(),
  emqx:hook('client.authenticate',
    fun emqx_auth_mnesia:check/3,
    [#{hash_type => binary_to_atom(PasswordHash, utf8)}]).

load_acl_hook() ->
  ok = emqx_acl_mnesia:init(),
  ok = emqx_acl_mnesia:register_metrics(),
  emqx:hook('client.check_acl',
    fun emqx_acl_mnesia:check_acl/5, [#{}]).