%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:35
%%%-------------------------------------------------------------------
-module(emqx_module_auth_redis).
-author("root").

-export([on_module_create/2, on_module_destroy/2,
  on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<82, 101, 100, 105, 115, 32, 65, 85, 84, 72, 47, 65,
    67, 76>>,
    zh =>
    <<82, 101, 100, 105, 115, 32, 232, 174, 164, 232, 175,
      129, 47, 232, 174, 191, 233, 151, 174, 230, 142, 167,
      229, 136, 182>>},
  destroy => on_module_destroy,
  name => redis_authentication,
  params =>
  #{acl_cmd =>
  #{default =>
  <<72, 71, 69, 84, 65, 76, 76, 32, 109, 113, 116,
    116, 95, 97, 99, 108, 58, 37, 117>>,
    description =>
    #{en => <<65, 67, 76, 32, 67, 77, 68>>,
      zh =>
      <<232, 174, 191, 233, 151, 174, 230, 142,
        167, 229, 136, 182, 230, 159, 165, 232,
        175, 162, 229, 145, 189, 228, 187,
        164>>},
    order => 8,
    title =>
    #{en => <<65, 67, 76, 32, 67, 77, 68>>,
      zh =>
      <<232, 174, 191, 233, 151, 174, 230, 142,
        167, 229, 136, 182, 230, 159, 165, 232,
        175, 162, 229, 145, 189, 228, 187,
        164>>},
    type => string},
    auth_cmd =>
    #{default =>
    <<72, 77, 71, 69, 84, 32, 109, 113, 116, 116, 95,
      117, 115, 101, 114, 58, 37, 117, 32, 112, 97,
      115, 115, 119, 111, 114, 100>>,
      description =>
      #{en => <<65, 117, 116, 104, 32, 67, 77, 68>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 159,
          165, 232, 175, 162, 229, 145, 189, 228,
          187, 164>>},
      order => 7,
      title =>
      #{en => <<65, 117, 116, 104, 32, 67, 77, 68>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 159,
          165, 232, 175, 162, 229, 145, 189, 228,
          187, 164>>},
      type => string},
    auto_reconnect =>
    #{default => true,
      description =>
      #{en =>
      <<73, 102, 32, 82, 101, 45, 116, 114, 121,
        32, 119, 104, 101, 110, 32, 116, 104,
        101, 32, 67, 111, 110, 110, 101, 99, 116,
        105, 111, 110, 32, 76, 111, 115, 116>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 232, 191,
          158, 230, 142, 165, 230, 150, 173, 229,
          188, 128, 230, 151, 182, 230, 152, 175,
          229, 144, 166, 233, 135, 141, 232, 191,
          158>>},
      order => 10,
      title =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 82, 101,
        99, 111, 110, 110, 101, 99, 116>>,
        zh =>
        <<230, 152, 175, 229, 144, 166, 233, 135,
          141, 232, 191, 158>>},
      type => boolean},
    cacertfile =>
    #{default => <<>>,
      description =>
      #{en =>
      <<67, 65, 32, 67, 101, 114, 116, 105, 102,
        105, 99, 97, 116, 101, 32, 102, 105, 108,
        101>>,
        zh =>
        <<67, 65, 32, 232, 175, 129, 228, 185, 166,
          230, 150, 135, 228, 187, 182>>},
      order => 16,
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
      order => 15,
      title =>
      #{en =>
      <<67, 101, 114, 116, 105, 102, 105, 99, 97,
        116, 101, 32, 70, 105, 108, 101>>,
        zh =>
        <<232, 175, 129, 228, 185, 166, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    database =>
    #{default => 0,
      description =>
      #{en =>
      <<82, 101, 100, 105, 115, 32, 68, 97, 116,
        97, 98, 97, 115, 101>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 230, 149,
          176, 230, 141, 174, 229, 186, 147>>},
      order => 3, required => true,
      title =>
      #{en =>
      <<82, 101, 100, 105, 115, 32, 68, 97, 116,
        97, 98, 97, 115, 101>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 230, 149,
          176, 230, 141, 174, 229, 186, 147>>},
      type => number},
    keyfile =>
    #{default => <<>>,
      description =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<83, 83, 76, 32, 231, 167, 129, 233, 146,
          165, 230, 150, 135, 228, 187, 182>>},
      order => 14,
      title =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<231, 167, 129, 233, 146, 165, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    password =>
    #{default => <<>>,
      description =>
      #{en =>
      <<82, 101, 100, 105, 115, 32, 80, 97, 115,
        115, 119, 111, 114, 100>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 229, 175,
          134, 231, 160, 129>>},
      order => 4,
      title =>
      #{en =>
      <<82, 101, 100, 105, 115, 32, 80, 97, 115,
        115, 119, 111, 114, 100>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 229, 175,
          134, 231, 160, 129>>},
      type => password},
    password_hash =>
    #{default => <<112, 108, 97, 105, 110>>,
      description =>
      #{en =>
      <<80, 97, 115, 115, 119, 111, 114, 100, 32,
        72, 97, 115, 104>>,
        zh =>
        <<229, 138, 160, 229, 175, 134, 230, 150,
          185, 229, 188, 143>>},
      enum =>
      [<<112, 108, 97, 105, 110>>, <<109, 100, 53>>,
        <<115, 104, 97>>, <<115, 104, 97, 50, 53, 54>>,
        <<115, 104, 97, 53, 49, 50>>,
        <<98, 99, 114, 121, 112, 116>>,
        <<115, 97, 108, 116, 44, 112, 108, 97, 105,
          110>>,
        <<112, 108, 97, 105, 110, 44, 115, 97, 108,
          116>>,
        <<115, 97, 108, 116, 44, 109, 100, 53>>,
        <<109, 100, 53, 44, 115, 97, 108, 116>>,
        <<115, 97, 108, 116, 44, 115, 104, 97>>,
        <<115, 104, 97, 44, 115, 97, 108, 116>>,
        <<115, 97, 108, 116, 44, 115, 104, 97, 50, 53,
          54>>,
        <<115, 104, 97, 50, 53, 54, 44, 115, 97, 108,
          116>>,
        <<115, 97, 108, 116, 44, 115, 104, 97, 53, 49,
          50>>,
        <<115, 104, 97, 53, 49, 50, 44, 115, 97, 108,
          116>>,
        <<115, 97, 108, 116, 44, 98, 99, 114, 121, 112,
          116>>,
        <<98, 99, 114, 121, 112, 116, 44, 115, 97, 108,
          116>>],
      order => 6,
      title =>
      #{en =>
      <<80, 97, 115, 115, 119, 111, 114, 100, 32,
        72, 97, 115, 104>>,
        zh =>
        <<229, 138, 160, 229, 175, 134, 230, 150,
          185, 229, 188, 143>>},
      type => string},
    pool_size =>
    #{default => 8,
      description =>
      #{en =>
      <<83, 105, 122, 101, 32, 111, 102, 32, 82,
        101, 100, 105, 115, 32, 67, 111, 110,
        110, 101, 99, 116, 105, 111, 110, 32, 80,
        111, 111, 108>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 232, 191,
          158, 230, 142, 165, 230, 177, 160, 229,
          164, 167, 229, 176, 143>>},
      order => 5, required => true,
      title =>
      #{en =>
      <<80, 111, 111, 108, 32, 83, 105, 122,
        101>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 177,
          160, 229, 164, 167, 229, 176, 143>>},
      type => number},
    query_timeout =>
    #{default => <<53, 115>>,
      description =>
      #{en =>
      <<81, 117, 101, 114, 121, 32, 84, 105, 109,
        101, 111, 117, 116>>,
        zh =>
        <<230, 159, 165, 232, 175, 162, 232, 182,
          133, 230, 156, 159, 230, 151, 182, 233,
          151, 180>>},
      order => 12,
      title =>
      #{en =>
      <<81, 117, 101, 114, 121, 32, 84, 105, 109,
        101, 111, 117, 116>>,
        zh =>
        <<230, 159, 165, 232, 175, 162, 232, 182,
          133, 230, 156, 159, 230, 151, 182, 233,
          151, 180>>},
      type => string},
    sentinel =>
    #{default => <<>>,
      description =>
      #{en =>
      <<83, 101, 110, 116, 105, 110, 101, 108,
        32, 78, 97, 109, 101>>,
        zh =>
        <<83, 101, 110, 116, 105, 110, 101, 108,
          32, 229, 144, 141, 231, 167, 176>>},
      order => 11,
      title =>
      #{en =>
      <<83, 101, 110, 116, 105, 110, 101, 108,
        32, 78, 97, 109, 101>>,
        zh =>
        <<83, 101, 110, 116, 105, 110, 101, 108,
          32, 229, 144, 141, 231, 167, 176>>},
      type => string},
    server =>
    #{default =>
    <<49, 50, 55, 46, 48, 46, 48, 46, 49, 58, 54, 51,
      55, 57>>,
      description =>
      #{en =>
      <<82, 101, 100, 105, 115, 32, 83, 101, 114,
        118, 101, 114>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 230, 156,
          141, 229, 138, 161, 229, 153, 168, 229,
          156, 176, 229, 157, 128>>},
      order => 2, required => true,
      title =>
      #{en =>
      <<82, 101, 100, 105, 115, 32, 83, 101, 114,
        118, 101, 114>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 230, 156,
          141, 229, 138, 161, 229, 153, 168>>},
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
      order => 13,
      title =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 83, 83,
        76>>,
        zh =>
        <<229, 188, 128, 229, 144, 175, 32, 83, 83,
          76>>},
      type => boolean},
    super_cmd =>
    #{default =>
    <<72, 71, 69, 84, 32, 109, 113, 116, 116, 95,
      117, 115, 101, 114, 58, 37, 117, 32, 105, 115,
      95, 115, 117, 112, 101, 114, 117, 115, 101,
      114>>,
      description =>
      #{en =>
      <<83, 117, 112, 101, 114, 85, 115, 101,
        114, 32, 67, 77, 68>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 230, 159, 165, 232,
          175, 162, 229, 145, 189, 228, 187,
          164>>},
      order => 9,
      title =>
      #{en =>
      <<83, 117, 112, 101, 114, 85, 115, 101,
        114, 32, 67, 77, 68>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 230, 159, 165, 232,
          175, 162, 229, 145, 189, 228, 187,
          164>>},
      type => string},
    type =>
    #{default => <<115, 105, 110, 103, 108, 101>>,
      description =>
      #{en =>
      <<82, 101, 100, 105, 115, 32, 67, 108, 117,
        115, 116, 101, 114, 32, 84, 121, 112,
        101>>,
        zh =>
        <<82, 101, 100, 105, 115, 32, 233, 155,
          134, 231, 190, 164, 231, 177, 187, 229,
          158, 139>>},
      enum =>
      [<<115, 105, 110, 103, 108, 101>>,
        <<115, 101, 110, 116, 105, 110, 101, 108>>,
        <<99, 108, 117, 115, 116, 101, 114>>],
      order => 1,
      title =>
      #{en =>
      <<67, 108, 117, 115, 116, 101, 114, 32, 84,
        121, 112, 101>>,
        zh =>
        <<233, 155, 134, 231, 190, 164, 231, 177,
          187, 229, 158, 139>>}}},
  status => on_module_status,
  title =>
  #{en =>
  <<82, 101, 100, 105, 115, 32, 65, 85, 84, 72, 47, 65,
    67, 76>>,
    zh =>
    <<82, 101, 100, 105, 115, 32, 232, 174, 164, 232, 175,
      129, 47, 232, 174, 191, 233, 151, 174, 230, 142, 167,
      229, 136, 182>>},
  type => auth, update => on_module_update}).

on_module_create(ModuleId,
    Config = #{<<"type">> := Type0, <<"server">> := Server,
      <<"database">> := Database,
      <<"pool_size">> := PoolSize,
      <<"query_timeout">> := Timeout0}) ->
  _ = application:ensure_all_started(ecpool),
  _ = application:ensure_all_started(eredis_cluster),
  _ = application:ensure_all_started(eredis),
  Type = b2a(Type0),
  Options = [{type, Type},
    {sentinel,
      binary_to_list(maps:get(<<"sentinel">>, Config,
        <<"">>))},
    {pool_size, PoolSize}, {database, Database},
    {password,
      binary_to_list(maps:get(<<"password">>, Config, ""))},
    {auto_reconnect,
      case maps:get(<<"auto_reconnect">>, Config, true) of
        true -> 2;
        false -> false
      end}]
    ++ format_servers(Type, binary_to_list(Server)),
  Timeout =
    cuttlefish_duration:parse(binary_to_list(Timeout0), ms),
  SslOptions = case maps:get(<<"ssl">>, Config, false) of
                 true ->
                   {options,
                     [{ssl_options,
                       emqx_module_utils:get_ssl_opts(Config, ModuleId)}]};
                 _ -> {options, []}
               end,
  PoolName = start_resource(pool_name(ModuleId),
    Options ++ [SslOptions]),
  case maps:get(<<"auth_cmd">>, Config, <<"">>) of
    <<"">> -> ok;
    AuthCmd ->
      HashType =
        password_hash(binary_to_list(maps:get(<<"password_hash">>,
          Config, <<"plain">>))),
      SuperCmd = case maps:get(<<"super_cmd">>, Config) of
                   <<"">> -> undefined;
                   SuperCmd0 -> binary_to_list(SuperCmd0)
                 end,
      load_auth_hook(PoolName, Type, Timeout,
        binary_to_list(AuthCmd), SuperCmd, HashType)
  end,
  case maps:get(<<"acl_cmd">>, Config, <<"">>) of
    <<"">> -> ok;
    AclCmd ->
      load_acl_hook(PoolName, Type, Timeout,
        binary_to_list(AclCmd))
  end,
  #{<<"type">> => Type, <<"pool">> => PoolName}.

on_module_destroy(_ModuleId,
    #{<<"type">> := Type, <<"pool">> := PoolName}) ->
  emqx:unhook('client.authenticate',
    fun emqx_auth_redis:check/3),
  emqx:unhook('client.check_acl',
    fun emqx_acl_redis:check_acl/5),
  stop_resource(Type, PoolName).

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

start_resource(PoolName, Options) ->
  case proplists:get_value(type, Options) of
    cluster ->
      {ok, _} = eredis_cluster:start_pool(PoolName, Options),
      eredis_cluster:q(PoolName, [<<"get">>, <<"test">>]);
    _ ->
      {ok, _} = ecpool:start_sup_pool(PoolName,
        emqx_auth_redis_cli, Options)
  end,
  PoolName.

stop_resource(Type, PoolName) ->
  case Type of
    cluster -> eredis_cluster:stop_pool(PoolName);
    _ -> ecpool:stop_sup_pool(PoolName)
  end.

pool_name(ModuleId) ->
  list_to_atom("auth_redis:" ++ binary_to_list(ModuleId)).

format_servers(single, Servers) ->
  {Host, Port} = format_server(Servers),
  [{host, Host}, {port, Port}];
format_servers(_, Servers) ->
  [{servers,
    [format_server(Server)
      || Server <- string:tokens(Servers, ",")]}].

format_server(Servers) ->
  case string:tokens(Servers, ":") of
    [Domain] -> {Domain, 6379};
    [Domain, Port] -> {Domain, list_to_integer(Port)}
  end.

b2a(B) when is_binary(B) ->
  list_to_atom(binary_to_list(B)).

load_auth_hook(PoolName, Type, Timeout, AuthCmd,
    SuperCmd, HashType) ->
  ok = emqx_auth_redis:register_metrics(),
  Config = #{auth_cmd => AuthCmd, super_cmd => SuperCmd,
    hash_type => HashType, timeout => Timeout, type => Type,
    pool => PoolName},
  emqx:hook('client.authenticate',
    fun emqx_auth_redis:check/3, [Config]).

load_acl_hook(PoolName, Type, Timeout, AclCmd) ->
  ok = emqx_acl_redis:register_metrics(),
  Config = #{acl_cmd => AclCmd, timeout => Timeout,
    type => Type, pool => PoolName},
  emqx:hook('client.check_acl',
    fun emqx_acl_redis:check_acl/5, [Config]).

password_hash(HashValue) ->
  case string:tokens(HashValue, ",") of
    [Hash] -> list_to_atom(Hash);
    [Prefix, Suffix] ->
      {list_to_atom(Prefix), list_to_atom(Suffix)};
    [Hash, MacFun, Iterations, Dklen] ->
      {list_to_atom(Hash), list_to_atom(MacFun),
        list_to_integer(Iterations), list_to_integer(Dklen)};
    _ -> plain
  end.
