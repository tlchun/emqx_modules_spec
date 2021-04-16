%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:34
%%%-------------------------------------------------------------------
-module(emqx_module_auth_ldap).
-author("root").

-export([on_module_create/2, on_module_destroy/2,
  on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<76, 68, 65, 80, 32, 65, 85, 84, 72, 47, 65, 67, 76>>,
    zh =>
    <<76, 68, 65, 80, 32, 232, 174, 164, 232, 175, 129, 47,
      232, 174, 191, 233, 151, 174, 230, 142, 167, 229,
      136, 182>>},
  destroy => on_module_destroy,
  name => ldap_authentication,
  params =>
  #{bind_dn =>
  #{default =>
  <<99, 110, 61, 114, 111, 111, 116, 44, 100, 99,
    61, 101, 109, 113, 120, 44, 100, 99, 61, 105,
    111>>,
    description =>
    #{en =>
    <<76, 68, 65, 80, 32, 66, 105, 110, 100,
      32, 68, 110>>,
      zh =>
      <<76, 68, 65, 80, 32, 232, 175, 134, 229,
        136, 171, 229, 144, 141>>},
    order => 5, required => true,
    title =>
    #{en =>
    <<76, 68, 65, 80, 32, 66, 105, 110, 100,
      32, 68, 110>>,
      zh =>
      <<76, 68, 65, 80, 32, 232, 175, 134, 229,
        136, 171, 229, 144, 141>>},
    type => string},
    bind_password =>
    #{default => <<112, 117, 98, 108, 105, 99>>,
      description =>
      #{en =>
      <<80, 97, 115, 115, 119, 111, 114, 100, 32,
        102, 111, 114, 32, 66, 105, 110, 100, 32,
        116, 111, 32, 76, 68, 65, 80>>,
        zh =>
        <<76, 68, 65, 80, 32, 229, 175, 134, 231,
          160, 129>>},
      order => 6, required => true,
      title =>
      #{en =>
      <<76, 68, 65, 80, 32, 66, 105, 110, 100,
        32, 80, 97, 115, 115, 119, 111, 114,
        100>>,
        zh =>
        <<76, 68, 65, 80, 32, 229, 175, 134, 231,
          160, 129>>},
      type => password},
    cacertfile =>
    #{default => <<>>,
      description =>
      #{en =>
      <<67, 65, 32, 67, 101, 114, 116, 105, 102,
        105, 99, 97, 116, 101, 32, 70, 105, 108,
        101>>,
        zh =>
        <<67, 65, 32, 232, 175, 129, 228, 185, 166,
          230, 150, 135, 228, 187, 182>>},
      order => 14,
      title =>
      #{en =>
      <<67, 65, 32, 67, 101, 114, 116, 105, 102,
        105, 99, 97, 116, 101, 32, 70, 105, 108,
        101>>,
        zh =>
        <<67, 65, 32, 232, 175, 129, 228, 185, 166,
          230, 150, 135, 228, 187, 182>>},
      type => file},
    certfile =>
    #{default => <<>>,
      description =>
      #{en =>
      <<67, 101, 114, 116, 105, 102, 105, 99, 97,
        116, 101, 32, 70, 105, 108, 101>>,
        zh =>
        <<83, 83, 76, 32, 232, 175, 129, 228, 185,
          166, 230, 150, 135, 228, 187, 182>>},
      order => 13,
      title =>
      #{en =>
      <<67, 101, 114, 116, 105, 102, 105, 99, 97,
        116, 101, 32, 70, 105, 108, 101>>,
        zh =>
        <<232, 175, 129, 228, 185, 166, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    device_dn =>
    #{default =>
    <<111, 117, 61, 100, 101, 118, 105, 99, 101, 44,
      100, 99, 61, 101, 109, 113, 120, 44, 100, 99,
      61, 105, 111>>,
      description =>
      #{en =>
      <<68, 101, 118, 105, 99, 101, 32, 68,
        110>>,
        zh =>
        <<232, 174, 190, 229, 164, 135, 232, 175,
          134, 229, 136, 171, 229, 144, 141>>},
      order => 7,
      title =>
      #{en =>
      <<68, 101, 118, 105, 99, 101, 32, 68,
        110>>,
        zh =>
        <<232, 174, 190, 229, 164, 135, 232, 175,
          134, 229, 136, 171, 229, 144, 141>>},
      type => string},
    keyfile =>
    #{default => <<>>,
      description =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<83, 83, 76, 32, 231, 167, 129, 233, 146,
          165, 230, 150, 135, 228, 187, 182>>},
      order => 12,
      title =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<231, 167, 129, 233, 146, 165, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    match_object_class =>
    #{default => <<109, 113, 116, 116, 85, 115, 101, 114>>,
      description =>
      #{en =>
      <<79, 98, 106, 101, 99, 116, 32, 67, 108,
        97, 115, 115>>,
        zh =>
        <<229, 175, 185, 232, 177, 161, 231, 177,
          187>>},
      order => 8, required => true,
      title =>
      #{en =>
      <<79, 98, 106, 101, 99, 116, 32, 67, 108,
        97, 115, 115>>,
        zh =>
        <<229, 175, 185, 232, 177, 161, 231, 177,
          187>>},
      type => string},
    password_attribute_type =>
    #{default =>
    <<117, 115, 101, 114, 80, 97, 115, 115, 119, 111,
      114, 100>>,
      description =>
      #{en =>
      <<80, 97, 115, 115, 119, 111, 114, 100, 32,
        84, 121, 112, 101>>,
        zh => <<229, 175, 134, 231, 160, 129>>},
      order => 10, required => true,
      title =>
      #{en =>
      <<80, 97, 115, 115, 119, 111, 114, 100, 32,
        84, 121, 112, 101>>,
        zh => <<229, 175, 134, 231, 160, 129>>},
      type => string},
    pool_size =>
    #{default => 8,
      description =>
      #{en =>
      <<84, 104, 101, 32, 83, 105, 122, 101, 32,
        111, 102, 32, 67, 111, 110, 110, 101, 99,
        116, 105, 111, 110, 32, 80, 111, 111,
        108, 32, 102, 111, 114, 32, 76, 68, 65,
        80>>,
        zh =>
        <<76, 68, 65, 80, 32, 232, 191, 158, 230,
          142, 165, 230, 177, 160, 229, 164, 167,
          229, 176, 143>>},
      order => 4,
      title =>
      #{en =>
      <<80, 111, 111, 108, 32, 83, 105, 122,
        101>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 177,
          160, 229, 164, 167, 229, 176, 143>>},
      type => number},
    port =>
    #{default => 389,
      description =>
      #{en =>
      <<76, 68, 65, 80, 32, 83, 101, 114, 118,
        101, 114, 32, 80, 111, 114, 116>>,
        zh =>
        <<76, 68, 65, 80, 32, 230, 156, 141, 229,
          138, 161, 229, 153, 168, 231, 171, 175,
          229, 143, 163>>},
      order => 2, required => true,
      title =>
      #{en =>
      <<76, 68, 65, 80, 32, 83, 101, 114, 118,
        101, 114, 32, 80, 111, 114, 116>>,
        zh =>
        <<76, 68, 65, 80, 32, 230, 156, 141, 229,
          138, 161, 229, 153, 168, 231, 171, 175,
          229, 143, 163>>},
      type => number},
    servers =>
    #{default => <<49, 50, 55, 46, 48, 46, 48, 46, 49>>,
      description =>
      #{en =>
      <<76, 68, 65, 80, 32, 73, 80, 32, 65, 100,
        100, 114, 101, 115, 115, 32, 111, 114,
        32, 72, 111, 115, 116, 110, 97, 109,
        101>>,
        zh =>
        <<76, 68, 65, 80, 32, 230, 156, 141, 229,
          138, 161, 229, 153, 168, 229, 156, 176,
          229, 157, 128>>},
      order => 1, required => true,
      title =>
      #{en =>
      <<76, 68, 65, 80, 32, 83, 101, 114, 118,
        101, 114>>,
        zh =>
        <<76, 68, 65, 80, 32, 230, 156, 141, 229,
          138, 161, 229, 153, 168>>},
      type => string},
    ssl =>
    #{default => false,
      description =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 83, 83,
        76>>,
        zh =>
        <<230, 152, 175, 229, 144, 166, 229, 188,
          128, 229, 144, 175, 32, 83, 83, 76>>},
      order => 11,
      title =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 83, 83,
        76>>,
        zh =>
        <<229, 188, 128, 229, 144, 175, 32, 83, 83,
          76>>},
      type => boolean},
    timeout =>
    #{default => <<51, 48, 115>>,
      description =>
      #{en =>
      <<67, 111, 110, 110, 101, 99, 116, 32, 84,
        105, 109, 101, 111, 117, 116, 40, 115,
        41>>,
        zh =>
        <<232, 182, 133, 230, 156, 159, 230, 151,
          182, 233, 151, 180, 40, 115, 41>>},
      order => 3,
      title =>
      #{en =>
      <<67, 111, 110, 110, 101, 99, 116, 32, 84,
        105, 109, 101, 111, 117, 116, 40, 115,
        41>>,
        zh =>
        <<232, 182, 133, 230, 156, 159, 230, 151,
          182, 233, 151, 180, 40, 115, 41>>},
      type => string},
    username_attribute_type =>
    #{default => <<117, 105, 100>>,
      description =>
      #{en =>
      <<85, 115, 101, 114, 32, 65, 116, 116, 114,
        105, 98, 117, 116, 101, 32, 84, 121, 112,
        101>>,
        zh =>
        <<231, 148, 168, 230, 136, 183, 229, 143,
          130, 230, 149, 176>>},
      order => 9, required => true,
      title =>
      #{en =>
      <<85, 115, 101, 114, 32, 65, 116, 116, 114,
        105, 98, 117, 116, 101, 32, 84, 121, 112,
        101>>,
        zh =>
        <<231, 148, 168, 230, 136, 183, 229, 143,
          130, 230, 149, 176>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<76, 68, 65, 80, 32, 65, 85, 84, 72, 47, 65, 67, 76>>,
    zh =>
    <<76, 68, 65, 80, 32, 232, 174, 164, 232, 175, 129, 47,
      232, 174, 191, 233, 151, 174, 230, 142, 167, 229,
      136, 182>>},
  type => auth, update => on_module_update}).


on_module_create(ModuleId,
    #{<<"servers">> := Servers, <<"port">> := Port,
      <<"pool_size">> := PoolSize, <<"timeout">> := Timeout,
      <<"bind_dn">> := BindDn,
      <<"bind_password">> := BindPassword,
      <<"device_dn">> := DeviceDn,
      <<"username_attribute_type">> := UsernameAttr,
      <<"password_attribute_type">> := PasswordAttr,
      <<"match_object_class">> := MatchObjectclass} =
      Params) ->
  _ = application:ensure_all_started(ecpool),
  _ = application:ensure_all_started(eldap2),
  LDAPOpts = [{servers, parse_address(Servers)},
    {port, Port}, {pool, PoolSize},
    {timeout, emqx_module_utils:parse_timeout(Timeout)},
    {bind_dn, binary_to_list(BindDn)},
    {bind_password, binary_to_list(BindPassword)}],
  SslOptions = case maps:get(<<"ssl">>, Params, false) of
                 true ->
                   [{ssl, true},
                     {ssl_opts,
                       emqx_module_utils:get_ssl_opts(Params, ModuleId)}];
                 _ -> []
               end,
  PoolName = start_resource(ModuleId, emqx_auth_ldap_cli,
    LDAPOpts ++ SslOptions),
  AuthOpts = #{password_attr => PasswordAttr,
    bind_as_user => false, pool => PoolName},
  AclOpts = #{device_dn => DeviceDn,
    match_objectclass => MatchObjectclass,
    username_attr => UsernameAttr, custom_base_dn => BindDn,
    pool => PoolName},
  load_acl_hook(AclOpts),
  load_auth_hook(AuthOpts),
  #{pool => PoolName}.

on_module_destroy(ModuleId, #{}) ->
  stop_resource(ModuleId), ok.

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

start_resource(ModuleId, WorkerName, Options) ->
  PoolName =
    emqx_module_utils:pool_name(emqx_module_auth_ldap,
      ModuleId),
  {ok, _} = ecpool:start_sup_pool(PoolName, WorkerName,
    Options),
  PoolName.

stop_resource(ModuleId) ->
  PoolName =
    emqx_module_utils:pool_name(emqx_module_auth_ldap,
      ModuleId),
  emqx:unhook('client.authenticate',
    fun emqx_auth_ldap:check/3),
  emqx:unhook('client.check_acl',
    fun emqx_acl_ldap:check_acl/5),
  ecpool:stop_sup_pool(PoolName).

parse_address(Servers) ->
  F = fun (H) ->
    case inet:parse_address(H) of
      {ok, Ip} -> Ip;
      _ -> H
    end
      end,
  [F(S)
    || S
    <- string:tokens(erlang:binary_to_list(Servers), " ,")].

load_auth_hook(Params) ->
  ok = emqx_auth_ldap:register_metrics(),
  emqx:hook('client.authenticate',
    fun emqx_auth_ldap:check/3, [Params]).

load_acl_hook(Params) ->
  ok = emqx_acl_ldap:register_metrics(),
  emqx:hook('client.check_acl',
    fun emqx_acl_ldap:check_acl/5, [Params]).

