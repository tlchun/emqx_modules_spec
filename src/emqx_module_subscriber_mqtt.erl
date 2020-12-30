%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:38
%%%-------------------------------------------------------------------
-module(emqx_module_subscriber_mqtt).
-author("root").

-export([logger_header/0]).
-include("../include/emqx.hrl").
-include("../include/logger.hrl").

-import(emqx_rule_utils, [str/1]).

-export([on_module_create/2, on_module_status/2,
  on_module_destroy/2, on_module_update/4]).

-export([connect/1]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<77, 81, 84, 84, 32, 83, 117, 98, 115, 99, 114, 105,
    98, 101, 114>>,
    zh =>
    <<77, 81, 84, 84, 32, 232, 174, 162, 233, 152, 133,
      232, 128, 133>>},
  destroy => on_module_destroy, name => mqtt_subscriber,
  params =>
  #{address =>
  #{default =>
  <<49, 50, 55, 46, 48, 46, 48, 46, 49, 58, 49, 56,
    56, 51>>,
    description =>
    #{en =>
    <<84, 104, 101, 32, 77, 81, 84, 84, 32, 82,
      101, 109, 111, 116, 101, 32, 65, 100,
      100, 114, 101, 115, 115>>,
      zh =>
      <<232, 191, 156, 231, 168, 139, 32, 77, 81,
        84, 84, 32, 66, 114, 111, 107, 101, 114,
        32, 231, 154, 132, 229, 156, 176, 229,
        157, 128>>},
    order => 1, required => true,
    title =>
    #{en =>
    <<32, 66, 114, 111, 107, 101, 114, 32, 65,
      100, 100, 114, 101, 115, 115>>,
      zh =>
      <<232, 191, 156, 231, 168, 139, 32, 98,
        114, 111, 107, 101, 114, 32, 229, 156,
        176, 229, 157, 128>>},
    type => string},
    append =>
    #{default => true,
      description =>
      #{en =>
      <<65, 112, 112, 101, 110, 100, 32, 71, 85,
        73, 68, 32, 116, 111, 32, 77, 81, 84, 84,
        32, 67, 108, 105, 101, 110, 116, 73, 100,
        63>>,
        zh =>
        <<230, 152, 175, 229, 144, 166, 229, 176,
          134, 71, 85, 73, 68, 233, 153, 132, 229,
          138, 160, 229, 136, 176, 32, 77, 81, 84,
          84, 32, 67, 108, 105, 101, 110, 116, 73,
          100, 32, 229, 144, 142>>},
      order => 4, required => true,
      title =>
      #{en =>
      <<65, 112, 112, 101, 110, 100, 32, 71, 85,
        73, 68>>,
        zh =>
        <<233, 153, 132, 229, 138, 160, 32, 71, 85,
          73, 68>>},
      type => boolean},
    cacertfile =>
    #{default => <<>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 102, 105, 108, 101, 32,
        111, 102, 32, 116, 104, 101, 32, 67, 65,
        32, 99, 101, 114, 116, 105, 102, 105, 99,
        97, 116, 101, 115>>,
        zh =>
        <<67, 65, 32, 232, 175, 129, 228, 185,
          166>>},
      order => 12, required => false,
      title =>
      #{en =>
      <<67, 65, 32, 99, 101, 114, 116, 105, 102,
        105, 99, 97, 116, 101, 115>>,
        zh =>
        <<67, 65, 32, 232, 175, 129, 228, 185,
          166>>},
      type => file},
    certfile =>
    #{default => <<>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 102, 105, 108, 101, 32,
        111, 102, 32, 116, 104, 101, 32, 99, 108,
        105, 101, 110, 116, 32, 99, 101, 114,
        116, 102, 105, 108, 101>>,
        zh =>
        <<229, 174, 162, 230, 136, 183, 231, 171,
          175, 232, 175, 129, 228, 185, 166>>},
      order => 13, required => false,
      title =>
      #{en =>
      <<83, 83, 76, 32, 67, 101, 114, 116, 102,
        105, 108, 101>>,
        zh =>
        <<83, 83, 76, 32, 229, 174, 162, 230, 136,
          183, 231, 171, 175, 232, 175, 129, 228,
          185, 166>>},
      type => file},
    clientid =>
    #{default => <<99, 108, 105, 101, 110, 116>>,
      description =>
      #{en =>
      <<67, 108, 105, 101, 110, 116, 73, 100, 32,
        102, 111, 114, 32, 99, 111, 110, 110,
        101, 99, 116, 105, 110, 103, 32, 116,
        111, 32, 114, 101, 109, 111, 116, 101,
        32, 77, 81, 84, 84, 32, 98, 114, 111,
        107, 101, 114>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 232, 191,
          156, 231, 168, 139, 32, 66, 114, 111,
          107, 101, 114, 32, 231, 154, 132, 32, 67,
          108, 105, 101, 110, 116, 73, 100>>},
      order => 3, required => true,
      title =>
      #{en => <<67, 108, 105, 101, 110, 116, 73, 100>>,
        zh =>
        <<229, 174, 162, 230, 136, 183, 231, 171,
          175, 32, 73, 100>>},
      type => string},
    keepalive =>
    #{default => <<54, 48, 115>>,
      description =>
      #{en =>
      <<75, 101, 101, 112, 97, 108, 105, 118,
        101>>,
        zh =>
        <<229, 191, 131, 232, 183, 179, 233, 151,
          180, 233, 154, 148>>},
      order => 9, required => false,
      title =>
      #{en =>
      <<75, 101, 101, 112, 97, 108, 105, 118,
        101>>,
        zh =>
        <<229, 191, 131, 232, 183, 179, 233, 151,
          180, 233, 154, 148>>},
      type => string},
    keyfile =>
    #{default => <<>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 102, 105, 108, 101, 32,
        111, 102, 32, 116, 104, 101, 32, 99, 108,
        105, 101, 110, 116, 32, 107, 101, 121,
        102, 105, 108, 101>>,
        zh =>
        <<229, 174, 162, 230, 136, 183, 231, 171,
          175, 229, 175, 134, 233, 146, 165>>},
      order => 14, required => false,
      title =>
      #{en =>
      <<83, 83, 76, 32, 75, 101, 121, 102, 105,
        108, 101>>,
        zh =>
        <<83, 83, 76, 32, 229, 175, 134, 233, 146,
          165, 230, 150, 135, 228, 187, 182>>},
      type => file},
    password =>
    #{default => <<>>,
      description =>
      #{en =>
      <<80, 97, 115, 115, 119, 111, 114, 100, 32,
        102, 111, 114, 32, 99, 111, 110, 110,
        101, 99, 116, 105, 110, 103, 32, 116,
        111, 32, 114, 101, 109, 111, 116, 101,
        32, 77, 81, 84, 84, 32, 66, 114, 111,
        107, 101, 114>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 232, 191,
          156, 231, 168, 139, 32, 66, 114, 111,
          107, 101, 114, 32, 231, 154, 132, 229,
          175, 134, 231, 160, 129>>},
      order => 6, required => false,
      title =>
      #{en => <<80, 97, 115, 115, 119, 111, 114, 100>>,
        zh => <<229, 175, 134, 231, 160, 129>>},
      type => password},
    pool_size =>
    #{default => 8,
      description =>
      #{en =>
      <<77, 81, 84, 84, 32, 67, 111, 110, 110,
        101, 99, 116, 105, 111, 110, 32, 80, 111,
        111, 108, 32, 83, 105, 122, 101>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 177,
          160, 229, 164, 167, 229, 176, 143>>},
      order => 2, required => true,
      title =>
      #{en =>
      <<80, 111, 111, 108, 32, 83, 105, 122,
        101>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 177,
          160, 229, 164, 167, 229, 176, 143>>},
      type => number},
    proto_ver =>
    #{default => <<109, 113, 116, 116, 118, 52>>,
      description =>
      #{en =>
      <<77, 81, 84, 84, 84, 32, 80, 114, 111,
        116, 111, 99, 111, 108, 32, 118, 101,
        114, 115, 105, 111, 110>>,
        zh =>
        <<77, 81, 84, 84, 32, 229, 141, 143, 232,
          174, 174, 231, 137, 136, 230, 156,
          172>>},
      enum =>
      [<<109, 113, 116, 116, 118, 51>>,
        <<109, 113, 116, 116, 118, 52>>,
        <<109, 113, 116, 116, 118, 53>>],
      order => 8, required => false,
      title =>
      #{en =>
      <<80, 114, 111, 116, 111, 99, 111, 108, 32,
        86, 101, 114, 115, 105, 111, 110>>,
        zh =>
        <<229, 141, 143, 232, 174, 174, 231, 137,
          136, 230, 156, 172>>},
      type => string},
    reconnect_interval =>
    #{default => <<51, 48, 115>>,
      description =>
      #{en =>
      <<82, 101, 99, 111, 110, 110, 101, 99, 116,
        32, 105, 110, 116, 101, 114, 118, 97,
        108, 32, 111, 102, 32, 98, 114, 105, 100,
        103, 101, 58, 60, 98, 114, 47, 62>>,
        zh =>
        <<233, 135, 141, 232, 191, 158, 233, 151,
          180, 233, 154, 148>>},
      order => 10, required => false,
      title =>
      #{en =>
      <<82, 101, 99, 111, 110, 110, 101, 99, 116,
        32, 73, 110, 116, 101, 114, 118, 97,
        108>>,
        zh =>
        <<233, 135, 141, 232, 191, 158, 233, 151,
          180, 233, 154, 148>>},
      type => string},
    ssl =>
    #{default => false,
      description =>
      #{en =>
      <<73, 102, 32, 101, 110, 97, 98, 108, 101,
        32, 115, 115, 108>>,
        zh =>
        <<230, 152, 175, 229, 144, 166, 229, 188,
          128, 229, 144, 175, 32, 83, 83, 76>>},
      order => 12,
      title =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 83, 83,
        76>>,
        zh =>
        <<229, 188, 128, 229, 144, 175, 83, 83, 76,
          233, 147, 190, 230, 142, 165>>},
      type => boolean},
    subscription_opts =>
    #{default => [],
      description =>
      #{en =>
      <<83, 117, 98, 115, 99, 114, 105, 112, 116,
        105, 111, 110, 32, 79, 112, 116, 115>>,
        zh =>
        <<232, 174, 162, 233, 152, 133, 233, 128,
          137, 233, 161, 185>>},
      items =>
      #{default => #{},
        schema =>
        #{qos =>
        #{default => 0,
          description =>
          #{en =>
          <<77, 81, 84, 84, 32, 84,
            111, 112, 105, 99, 32,
            81, 111, 83>>,
            zh =>
            <<77, 81, 84, 84, 32,
              230, 156, 141, 229,
              138, 161, 232, 180,
              168, 233, 135, 143>>},
          enum => [0, 1, 2], order => 2,
          title =>
          #{en =>
          <<77, 81, 84, 84, 32, 84,
            111, 112, 105, 99, 32,
            81, 111, 83>>,
            zh =>
            <<77, 81, 84, 84, 32,
              230, 156, 141, 229,
              138, 161, 232, 180,
              168, 233, 135, 143>>},
          type => number},
          topic =>
          #{default => <<>>,
            description =>
            #{en =>
            <<77, 81, 84, 84, 32, 84,
              111, 112, 105, 99>>,
              zh =>
              <<77, 81, 84, 84, 32,
                228, 184, 187, 233,
                162, 152>>},
            order => 1, required => true,
            title =>
            #{en =>
            <<77, 81, 84, 84, 32, 84,
              111, 112, 105, 99>>,
              zh =>
              <<77, 81, 84, 84, 32,
                228, 184, 187, 233,
                162, 152>>},
            type => string}},
        type => object},
      order => 7, required => true,
      title =>
      #{en =>
      <<83, 117, 98, 115, 99, 114, 105, 112, 116,
        105, 111, 110, 32, 79, 112, 116, 115>>,
        zh =>
        <<232, 174, 162, 233, 152, 133, 233, 128,
          137, 233, 161, 185>>},
      type => array},
    username =>
    #{default => <<>>,
      description =>
      #{en =>
      <<85, 115, 101, 114, 110, 97, 109, 101, 32,
        102, 111, 114, 32, 99, 111, 110, 110,
        101, 99, 116, 105, 110, 103, 32, 116,
        111, 32, 114, 101, 109, 111, 116, 101,
        32, 77, 81, 84, 84, 32, 66, 114, 111,
        107, 101, 114>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 232, 191,
          156, 231, 168, 139, 32, 66, 114, 111,
          107, 101, 114, 32, 231, 154, 132, 231,
          148, 168, 230, 136, 183, 229, 144,
          141>>},
      order => 5, required => false,
      title =>
      #{en => <<85, 115, 101, 114, 110, 97, 109, 101>>,
        zh =>
        <<231, 148, 168, 230, 136, 183, 229, 144,
          141>>},
      type => string},
    versions =>
    #{default =>
    <<116, 108, 115, 118, 49, 46, 50, 44, 116, 108,
      115, 118, 49, 46, 49, 44, 116, 108, 115, 118,
      49>>,
      description => #{en => <<>>, zh => <<>>},
      enum =>
      [<<116, 108, 115, 118, 49, 46, 50, 44, 116, 108,
        115, 118, 49, 46, 49, 44, 116, 108, 115, 118,
        49>>,
        <<116, 108, 115, 118, 49, 46, 50>>,
        <<116, 108, 115, 118, 49, 46, 50, 44, 116, 108,
          115, 118, 49, 46, 49>>,
        <<116, 108, 115, 118, 49>>],
      order => 13,
      title =>
      #{en =>
      <<84, 76, 83, 32, 86, 101, 114, 115, 105,
        111, 110>>,
        zh =>
        <<84, 76, 83, 32, 86, 101, 114, 115, 105,
          111, 110>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<77, 81, 84, 84, 32, 83, 117, 98, 115, 99, 114, 105,
    98, 101, 114>>,
    zh =>
    <<77, 81, 84, 84, 32, 83, 117, 98, 115, 99, 114, 105,
      98, 101, 114>>},
  type => message, update => on_module_update}).

-vsn("4.2.2").

on_module_create(ModuleId, Params) ->
  begin
    logger:log(info, #{},
      #{report_cb =>
      fun (_) ->
        {logger_header() ++
          "Initiating Feature ~p, ModuleId: ~p",
          [mqtt_subscriber, ModuleId]}
      end,
        mfa =>
        {emqx_module_subscriber_mqtt, on_module_create, 2},
        line => 214})
  end,
  _ = application:ensure_all_started(ecpool),
  PoolName = pool_name(ModuleId),
  Options = options(Params, PoolName, ModuleId),
  start_module(ModuleId, PoolName, Options),
  #{<<"pool">> => PoolName}.

start_module(ModuleId, PoolName, Options) ->
  case ecpool:start_sup_pool(PoolName,
    emqx_module_subscriber_mqtt, Options)
  of
    {ok, _} ->
      begin
        logger:log(info, #{},
          #{report_cb =>
          fun (_) ->
            {logger_header() ++
              "Initiated Feature ~p Successfully, ModuleId: ~p",
              [mqtt_subscriber, ModuleId]}
          end,
            mfa => {emqx_module_subscriber_mqtt, start_module, 3},
            line => 224})
      end;
    {error, {already_started, _Pid}} ->
      on_module_destroy(ModuleId, #{<<"pool">> => PoolName}),
      start_module(ModuleId, PoolName, Options);
    {error, Reason} ->
      begin
        logger:log(error, #{},
          #{report_cb =>
          fun (_) ->
            {logger_header() ++
              "Initiate Feature ~p failed, ModuleId: "
              "~p, ~p",
              [mqtt_subscriber, ModuleId, Reason]}
          end,
            mfa => {emqx_module_subscriber_mqtt, start_module, 3},
            line => 229})
      end,
      on_module_destroy(ModuleId, #{<<"pool">> => PoolName}),
      error({{mqtt_subscriber, ModuleId}, create_failed})
  end.

-spec on_module_status(ModuleId :: binary(),
    Params :: map()) -> Status :: map().

on_module_status(_ModuleId,
    #{<<"pool">> := PoolName}) ->
  IsConnected = fun (Worker) ->
    case ecpool_worker:client(Worker) of
      {ok, Bridge} ->
        case emqx_bridge_worker:status(Bridge) of
          connected -> true;
          _ -> false
        end;
      {error, _} -> false
    end
                end,
  Status = [IsConnected(Worker)
    || {_WorkerName, Worker} <- ecpool:workers(PoolName)],
  #{is_alive =>
  lists:any(fun (St) -> St =:= true end, Status)}.

on_module_destroy(ModuleId,
    #{<<"pool">> := PoolName}) ->
  begin
    logger:log(info, #{},
      #{report_cb =>
      fun (_) ->
        {logger_header() ++
          "Destroying Feature ~p, ModuleId: ~p",
          [mqtt_subscriber, ModuleId]}
      end,
        mfa =>
        {emqx_module_subscriber_mqtt, on_module_destroy, 2},
        line => 251})
  end,
  case ecpool:stop_sup_pool(PoolName) of
    ok ->
      begin
        logger:log(info, #{},
          #{report_cb =>
          fun (_) ->
            {logger_header() ++
              "Destroyed Feature ~p Successfully, ModuleId: ~p",
              [mqtt_subscriber, ModuleId]}
          end,
            mfa =>
            {emqx_module_subscriber_mqtt, on_module_destroy,
              2},
            line => 254})
      end;
    {error, Reason} ->
      begin
        logger:log(error, #{},
          #{report_cb =>
          fun (_) ->
            {logger_header() ++
              "Destroy Feature ~p failed, ModuleId: "
              "~p, ~p",
              [mqtt_subscriber, ModuleId, Reason]}
          end,
            mfa =>
            {emqx_module_subscriber_mqtt, on_module_destroy,
              2},
            line => 256})
      end,
      error({{mqtt_subscriber, ModuleId}, destroy_failed})
  end.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

connect(Options) when is_list(Options) ->
  connect(maps:from_list(Options));
connect(Options = #{ecpool_worker_id := Id,
  pool_name := Pool}) ->
  Options1 = case maps:is_key(append, Options) of
               false -> Options;
               true ->
                 case maps:get(append, Options, false) of
                   true ->
                     ClientId = lists:concat([str(maps:get(clientid,
                       Options)),
                       "_",
                       str(emqx_guid:to_hexstr(emqx_guid:gen()))]),
                     Options#{clientid => ClientId};
                   false -> Options
                 end
             end,
  Options2 = maps:without([ecpool_worker_id, pool_name,
    append],
    Options1),
  emqx_bridge_worker:start_link(name(Pool, Id), Options2).

name(Pool, Id) ->
  list_to_atom(atom_to_list(Pool) ++ ":" ++ integer_to_list(Id)).

pool_name(ModuleId) ->
  list_to_atom("bridge_mqtt:" ++ str(ModuleId)).

options(Options, PoolName, ModuleId) ->
  GetD = fun (Key, Default) ->
    maps:get(Key, Options, Default)
         end,
  Get = fun (Key) -> GetD(Key, undefined) end,
  [{start_type, auto}, {if_record_metrics, false},
    {pool_size, GetD(<<"pool_size">>, 1)},
    {pool_name, PoolName},
    {subscriptions,
      format_subscriptions(GetD(<<"subscription_opts">>,
        []))},
    {address, binary_to_list(Get(<<"address">>))},
    {clean_start, true},
    {clientid, str(Get(<<"clientid">>))},
    {append, Get(<<"append">>)},
    {connect_module, emqx_bridge_mqtt},
    {keepalive,
      cuttlefish_duration:parse(str(Get(<<"keepalive">>)),
        s)},
    {reconnect_delay_ms,
      cuttlefish_duration:parse(str(Get(<<"reconnect_interval">>)),
        ms)},
    {username, str(Get(<<"username">>))},
    {password, str(Get(<<"password">>))},
    {proto_ver, mqtt_ver(Get(<<"proto_ver">>))}]
  ++
  case convert_key_name(<<"ssl">>, Options) of
    true ->
      [{ssl, true},
        {ssl_opts,
          [{versions, tls_versions(Options)},
            {ciphers,
              lists:usort(lists:append([ssl:cipher_suites(all, V,
                openssl)
                || V <- tls_versions(Options)]))}
            | emqx_module_utils:get_ssl_opts(Options, ModuleId)]}];
    false -> []
  end.

format_subscriptions(SubOpts) ->
  lists:map(fun (Sub) ->
    {maps:get(<<"topic">>, Sub), maps:get(<<"qos">>, Sub)}
            end,
    SubOpts).

tls_versions(Opts) ->
  TLS = re:split(maps:get(versions, Opts,
    <<"tlsv1.2,tlsv1.1,tlsv1">>),
    "[, ]"),
  [binary_to_existing_atom(V, utf8) || V <- TLS].

mqtt_ver(ProtoVer) ->
  case ProtoVer of
    <<"mqttv3">> -> v3;
    <<"mqttv4">> -> v4;
    <<"mqttv5">> -> v5;
    _ -> v4
  end.

convert_key_name(<<"ssl">>, Options) ->
  SSL = maps:get(<<"ssl">>, Options, <<"off">>),
  case is_binary(SSL) of
    true -> cuttlefish_flag:parse(str(SSL));
    false -> SSL
  end.

logger_header() -> "".
