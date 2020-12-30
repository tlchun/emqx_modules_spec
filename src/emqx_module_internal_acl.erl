%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:36
%%%-------------------------------------------------------------------
-module(emqx_module_internal_acl).
-author("root").

-export([on_module_create/2, on_module_update/4, on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<73, 110, 116, 101, 114, 110, 97, 108, 32, 65, 67, 76,
    32, 70, 105, 108, 101>>,
    zh =>
    <<229, 134, 133, 231, 189, 174, 232, 174, 191, 233,
      151, 174, 230, 142, 167, 229, 136, 182, 230, 150,
      135, 228, 187, 182>>},
  destroy => on_module_destroy, name => internal_acl,
  params =>
  #{acl_rule_file =>
  #{default => <<>>,
    description =>
    #{en =>
    <<73, 110, 116, 101, 114, 110, 97, 108, 32,
      65, 67, 76, 32, 82, 117, 108, 101, 32,
      70, 105, 108, 101>>,
      zh =>
      <<229, 134, 133, 231, 189, 174, 232, 174,
        191, 233, 151, 174, 230, 142, 167, 229,
        136, 182, 232, 167, 132, 229, 136, 153,
        230, 150, 135, 228, 187, 182>>},
    order => 1,
    title =>
    #{en =>
    <<65, 67, 76, 32, 82, 117, 108, 101, 32,
      70, 105, 108, 101>>,
      zh =>
      <<232, 174, 191, 233, 151, 174, 230, 142,
        167, 229, 136, 182, 232, 167, 132, 229,
        136, 153, 230, 150, 135, 228, 187,
        182>>},
    type => file}},
  status => on_module_status,
  title =>
  #{en =>
  <<73, 110, 116, 101, 114, 110, 97, 108, 32, 65, 67, 76,
    32, 70, 105, 108, 101>>,
    zh =>
    <<229, 134, 133, 231, 189, 174, 232, 174, 191, 233,
      151, 174, 230, 142, 167, 229, 136, 182, 230, 150,
      135, 228, 187, 182>>},
  type => auth, update => on_module_update}).

-vsn("4.2.2").

on_module_create(ModuleId,
    #{<<"acl_rule_file">> := File}) ->
  AclFile = emqx_module_utils:save_upload_file(File,
    ModuleId),
  Rules = emqx_mod_acl_internal:rules_from_file(AclFile),
  emqx:hook('client.check_acl',
    {emqx_mod_acl_internal, check_acl, [Rules]}, -1),
  #{}.

on_module_update(_ModuleId, Context, Config, Config) ->
  Context;
on_module_update(ModuleId, Context, _Config,
    NewConfig) ->
  on_module_destroy(ModuleId, Context),
  emqx_acl_cache:is_enabled() andalso
    lists:foreach(fun (Pid) ->
      erlang:send(Pid, clean_acl_cache)
                  end,
      emqx_cm:all_channels()),
  on_module_create(ModuleId, NewConfig).

on_module_destroy(_ModuleId, #{}) ->
  emqx:unhook('client.check_acl',
    {emqx_mod_acl_internal, check_acl}),
  ok.

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.
