%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:36
%%%-------------------------------------------------------------------
-module(emqx_module_consumer_kafka).
-author("root").

-export([logger_header/0]).

-include("../include/emqx.hrl").
-include("../include/logger.hrl").


-export([on_module_create/2, on_module_destroy/2,
  on_module_update/4, on_module_status/2]).

-export([connect/1]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<75, 97, 102, 107, 97, 32, 67, 111, 110, 115, 117,
    109, 101, 114, 32, 71, 114, 111, 117, 112>>,
    zh =>
    <<75, 97, 102, 107, 97, 32, 230, 182, 136, 232, 180,
      185, 231, 187, 132>>},
  destroy => on_module_destroy, name => kafka_consumer,
  params =>
  #{auto_reconnect =>
  #{default => true,
    description =>
    #{en =>
    <<73, 102, 32, 114, 101, 45, 116, 114, 121,
      32, 119, 104, 101, 110, 32, 116, 104,
      101, 32, 99, 111, 110, 110, 101, 99, 116,
      105, 111, 110, 32, 108, 111, 115, 116>>,
      zh =>
      <<67, 111, 110, 115, 117, 109, 101, 114,
        32, 232, 191, 158, 230, 142, 165, 230,
        150, 173, 229, 188, 128, 230, 151, 182,
        230, 152, 175, 229, 144, 166, 233, 135,
        141, 232, 191, 158>>},
    order => 8,
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
      order => 12,
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
      order => 12,
      title =>
      #{en =>
      <<67, 101, 114, 116, 105, 102, 105, 99, 97,
        116, 101, 32, 70, 105, 108, 101>>,
        zh =>
        <<232, 175, 129, 228, 185, 166, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    keyfile =>
    #{default => <<>>,
      description =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<83, 83, 76, 32, 231, 167, 129, 233, 146,
          165, 230, 150, 135, 228, 187, 182>>},
      order => 11,
      title =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<231, 167, 129, 233, 146, 165, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    max_bytes =>
    #{default => <<49, 48, 48, 75, 66>>,
      description =>
      #{en =>
      <<77, 97, 120, 105, 109, 117, 109, 32, 98,
        121, 116, 101, 115, 32, 116, 111, 32,
        102, 101, 116, 99, 104, 32, 105, 110, 32,
        97, 32, 98, 97, 116, 99, 104, 32, 111,
        102, 32, 109, 101, 115, 115, 97, 103,
        101, 115>>,
        zh =>
        <<230, 137, 185, 233, 135, 143, 230, 143,
          144, 229, 143, 150, 230, 182, 136, 230,
          129, 175, 231, 154, 132, 230, 156, 128,
          229, 164, 167, 229, 173, 151, 232, 138,
          130, 230, 149, 176>>},
      order => 6,
      title =>
      #{en =>
      <<77, 97, 120, 32, 66, 121, 116, 101,
        115>>,
        zh =>
        <<230, 143, 144, 229, 143, 150, 230, 182,
          136, 230, 129, 175, 230, 156, 128, 229,
          164, 167, 229, 173, 151, 232, 138, 130,
          230, 149, 176>>},
      type => string},
    offset_reset_policy =>
    #{default =>
    <<114, 101, 115, 101, 116, 95, 116, 111, 95, 108,
      97, 116, 101, 115, 116>>,
      description =>
      #{en =>
      <<72, 111, 119, 32, 116, 111, 32, 114, 101,
        115, 101, 116, 32, 98, 101, 103, 105,
        110, 95, 111, 102, 102, 115, 101, 116,
        32, 105, 102, 32, 79, 102, 102, 115, 101,
        116, 79, 117, 116, 79, 102, 82, 97, 110,
        103, 101, 32, 101, 120, 99, 101, 112,
        116, 105, 111, 110, 32, 105, 115, 32,
        114, 101, 99, 101, 105, 118, 101, 100>>,
        zh =>
        <<229, 166, 130, 230, 158, 156, 230, 148,
          182, 229, 136, 176, 79, 102, 102, 115,
          101, 116, 79, 117, 116, 79, 102, 82, 97,
          110, 103, 101, 229, 188, 130, 229, 184,
          184, 239, 188, 140, 229, 166, 130, 228,
          189, 149, 233, 135, 141, 231, 189, 174,
          98, 101, 103, 105, 110, 95, 111, 102,
          102, 115, 101, 116>>},
      enum =>
      [<<114, 101, 115, 101, 116, 95, 116, 111, 95,
        108, 97, 116, 101, 115, 116>>,
        <<114, 101, 115, 101, 116, 95, 98, 121, 95, 115,
          117, 98, 100, 99, 114, 105, 98, 101, 114>>],
      order => 7,
      title =>
      #{en =>
      <<79, 102, 102, 115, 101, 116, 32, 82, 101,
        115, 101, 116, 32, 80, 111, 108, 105, 99,
        121>>,
        zh =>
        <<79, 102, 102, 115, 101, 116, 32, 233,
          135, 141, 231, 189, 174, 231, 173, 150,
          231, 149, 165>>},
      type => string},
    password =>
    #{default => <<>>,
      description =>
      #{en =>
      <<75, 97, 102, 107, 97, 32, 65, 117, 116,
        104, 32, 80, 97, 115, 115, 119, 111, 114,
        100>>,
        zh =>
        <<75, 97, 102, 107, 97, 32, 232, 174, 164,
          232, 175, 129, 229, 175, 134, 231, 160,
          129>>},
      order => 4,
      title =>
      #{en =>
      <<75, 97, 102, 107, 97, 32, 80, 97, 115,
        115, 119, 111, 114, 100>>,
        zh =>
        <<75, 97, 102, 107, 97, 32, 229, 175, 134,
          231, 160, 129>>},
      type => password},
    pool_size =>
    #{default => 8,
      description =>
      #{en =>
      <<80, 111, 111, 108, 32, 83, 105, 122,
        101>>,
        zh =>
        <<80, 111, 111, 108, 32, 83, 105, 122,
          101>>},
      order => 2,
      title =>
      #{en =>
      <<80, 111, 111, 108, 32, 83, 105, 122,
        101>>,
        zh =>
        <<80, 111, 111, 108, 32, 83, 105, 122,
          101>>},
      type => number},
    servers =>
    #{default =>
    <<49, 50, 55, 46, 48, 46, 48, 46, 49, 58, 57, 48,
      57, 50>>,
      description =>
      #{en =>
      <<75, 97, 102, 107, 97, 32, 83, 101, 114,
        118, 101, 114, 32, 65, 100, 100, 114,
        101, 115, 115, 44, 32, 77, 117, 108, 116,
        105, 112, 108, 101, 32, 110, 111, 100,
        101, 115, 32, 115, 101, 112, 97, 114, 97,
        116, 101, 100, 32, 98, 121, 32, 99, 111,
        109, 109, 97, 115>>,
        zh =>
        <<75, 97, 102, 107, 97, 32, 230, 156, 141,
          229, 138, 161, 229, 153, 168, 229, 156,
          176, 229, 157, 128, 44, 32, 229, 164,
          154, 232, 138, 130, 231, 130, 185, 228,
          189, 191, 231, 148, 168, 233, 128, 151,
          229, 143, 183, 229, 136, 134, 233, 154,
          148>>},
      order => 1, required => true,
      title =>
      #{en =>
      <<75, 97, 102, 107, 97, 32, 83, 101, 114,
        118, 101, 114>>,
        zh =>
        <<75, 97, 102, 107, 97, 32, 230, 156, 141,
          229, 138, 161, 229, 153, 168>>},
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
      order => 9,
      title =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 83, 83,
        76>>,
        zh =>
        <<229, 188, 128, 229, 144, 175, 32, 83, 83,
          76>>},
      type => boolean},
    topic_mapping =>
    #{default => [],
      description =>
      #{en =>
      <<75, 97, 102, 107, 97, 32, 116, 111, 112,
        105, 99, 32, 116, 111, 32, 77, 81, 84,
        84, 32, 116, 111, 112, 105, 99, 32, 109,
        97, 112, 112, 105, 110, 103, 32, 114,
        101, 108, 97, 116, 105, 111, 110, 115,
        104, 105, 112>>,
        zh =>
        <<75, 97, 102, 107, 97, 32, 228, 184, 187,
          233, 162, 152, 232, 189, 172, 32, 77, 81,
          84, 84, 32, 228, 184, 187, 233, 162, 152,
          230, 152, 160, 229, 176, 132, 229, 133,
          179, 231, 179, 187>>},
      items =>
      #{default => #{},
        schema =>
        #{kafka_topic =>
        #{default =>
        <<84, 101, 115, 116, 84, 111,
          112, 105, 99>>,
          description =>
          #{en =>
          <<75, 97, 102, 107, 97,
            32, 84, 111, 112, 105,
            99>>,
            zh =>
            <<75, 97, 102, 107, 97,
              32, 84, 111, 112, 105,
              99>>},
          order => 1, required => true,
          title =>
          #{en =>
          <<75, 97, 102, 107, 97,
            32, 84, 111, 112, 105,
            99>>,
            zh =>
            <<75, 97, 102, 107, 97,
              32, 228, 184, 187, 233,
              162, 152>>},
          type => string},
          mqtt_topic =>
          #{default =>
          <<84, 101, 115, 116, 84, 111,
            112, 105, 99>>,
            description =>
            #{en =>
            <<77, 81, 84, 84, 32, 84,
              111, 112, 105, 99>>,
              zh =>
              <<77, 81, 84, 84, 32, 84,
                111, 112, 105, 99>>},
            order => 2, required => true,
            title =>
            #{en =>
            <<77, 81, 84, 84, 32, 84,
              111, 112, 105, 99>>,
              zh =>
              <<77, 81, 84, 84, 32,
                228, 184, 187, 233,
                162, 152>>},
            type => string},
          mqtt_topic_qos =>
          #{default => 0,
            description =>
            #{en =>
            <<77, 81, 84, 84, 32, 84,
              111, 112, 105, 99, 32,
              81, 111, 83>>,
              zh =>
              <<77, 81, 84, 84, 32,
                228, 184, 187, 233,
                162, 152, 230, 156,
                141, 229, 138, 161,
                232, 180, 168, 233,
                135, 143>>},
            enum => [0, 1, 2], order => 3,
            title =>
            #{en =>
            <<77, 81, 84, 84, 32, 84,
              111, 112, 105, 99, 32,
              81, 111, 83>>,
              zh =>
              <<77, 81, 84, 84, 32,
                228, 184, 187, 233,
                162, 152, 230, 156,
                141, 229, 138, 161,
                232, 180, 168, 233,
                135, 143>>},
            type => number}},
        type => object},
      order => 5, required => true,
      title =>
      #{en =>
      <<84, 111, 112, 105, 99, 32, 77, 97, 112,
        112, 105, 110, 103>>,
        zh =>
        <<75, 97, 102, 107, 97, 32, 228, 184, 187,
          233, 162, 152, 232, 189, 172, 32, 77, 81,
          84, 84, 32, 228, 184, 187, 233, 162, 152,
          230, 152, 160, 229, 176, 132, 229, 133,
          179, 231, 179, 187>>},
      type => array},
    username =>
    #{default => <<>>,
      description =>
      #{en =>
      <<75, 97, 102, 107, 97, 32, 65, 117, 116,
        104, 32, 85, 115, 101, 114, 110, 97, 109,
        101>>,
        zh =>
        <<75, 97, 102, 107, 97, 32, 232, 174, 164,
          232, 175, 129, 231, 148, 168, 230, 136,
          183, 229, 144, 141>>},
      order => 3,
      title =>
      #{en =>
      <<75, 97, 102, 107, 97, 32, 85, 115, 101,
        114, 110, 97, 109, 101>>,
        zh =>
        <<75, 97, 102, 107, 97, 32, 231, 148, 168,
          230, 136, 183, 229, 144, 141>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<75, 97, 102, 107, 97, 32, 67, 111, 110, 115, 117,
    109, 101, 114, 32, 71, 114, 111, 117, 112>>,
    zh =>
    <<75, 97, 102, 107, 97, 32, 230, 182, 136, 232, 180,
      185, 231, 187, 132>>},
  type => message, update => on_module_update}).

-vsn("4.2.2").

on_module_create(ModuleId,
    Config = #{<<"servers">> := Servers,
      <<"pool_size">> := PoolSize,
      <<"topic_mapping">> := TopicMapping}) ->
  _ = application:ensure_all_started(brod),
  _ = application:ensure_all_started(ecpool),
  ClientId = binary_to_atom(client_id(ModuleId), utf8),
  Servers1 = format_servers(Servers),
  AutoReconnect = case maps:get(<<"auto_reconnect">>,
    Config, true)
                  of
                    true -> 5;
                    false -> false
                  end,
  MaxBytes =
    cuttlefish_bytesize:parse(str(maps:get(<<"max_bytes">>,
      Config, <<"100KB">>))),
  OffsetResetPolicy =
    atom(maps:get(<<"offset_reset_policy">>, Config,
      <<"reset_to_latest">>)),
  ClientConfig = case maps:get(<<"username">>, Config,
    <<>>)
                 of
                   <<>> -> [];
                   Username ->
                     [{sasl,
                       {plain, Username,
                         maps:get(<<"password">>, Config, <<>>)}}]
                 end,
  ClientConfig2 = maybe_append_ssl_options(ClientConfig,
    Config, ModuleId),
  start_brod(Servers1, ClientId, ClientConfig2),
  lists:foreach(fun (TM = #{<<"kafka_topic">> :=
  KafkaTopic,
    <<"mqtt_topic">> := MQTTTopic}) ->
    Options = [{pool_size, PoolSize},
      {auto_reconnect, AutoReconnect},
      {servers, Servers1}, {client_id, ClientId},
      {kafka_topic, KafkaTopic},
      {mqtt_topic, MQTTTopic},
      {mqtt_topic_qos,
        maps:get(<<"mqtt_topic_qos">>, TM, 1)},
      {group_id, ModuleId},
      {consumer_config,
        [{max_bytes, MaxBytes},
          {offset_reset_policy,
            OffsetResetPolicy}]},
      {group_config, []}],
    PoolName = pool_name(ModuleId, KafkaTopic),
    start_kafka_comsumer(ModuleId, PoolName, Options)
                end,
    TopicMapping),
  #{<<"client_id">> => ClientId,
    <<"servers">> => Servers1,
    <<"topic_maping">> => TopicMapping}.

on_module_destroy(ModuleId,
    #{<<"client_id">> := ClientId,
      <<"topic_maping">> := TopicMapping}) ->
  begin
    logger:log(info, #{},
      #{report_cb =>
      fun (_) ->
        {logger_header() ++
          "Destroying Module ~p, ModuleId: ~p",
          [kafka_consumer, ModuleId]}
      end,
        mfa =>
        {emqx_module_consumer_kafka, on_module_destroy, 2},
        line => 221})
  end,
  [ecpool:stop_sup_pool(pool_name(ModuleId, KafkaTopic))
    || #{<<"kafka_topic">> := KafkaTopic} <- TopicMapping],
  brod:stop_client(ClientId).

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

start_brod(Servers, ClientId, ClientConfig) ->
  case ensure_server_list(Servers, ClientConfig) of
    ok ->
      ok = brod:start_client(Servers, ClientId, ClientConfig);
    {error, _} -> error(connect_kafka_server_fail)
  end.

start_kafka_comsumer(ModuleId, PoolName, Options) ->
  case ecpool:start_sup_pool(PoolName,
    emqx_module_consumer_kafka, Options)
  of
    {ok, _} ->
      begin
        logger:log(info, #{},
          #{report_cb =>
          fun (_) ->
            {logger_header() ++
              "Initiated Module ~p Successfully, ModuleId: ~p",
              [kafka_consumer, ModuleId]}
          end,
            mfa =>
            {emqx_module_consumer_kafka, start_kafka_comsumer,
              3},
            line => 245})
      end;
    {error, {already_started, _Pid}} ->
      begin
        logger:log(info, #{},
          #{report_cb =>
          fun (_) ->
            {logger_header() ++
              "Initiated Module ~p Successfully, ModuleId: ~p",
              [kafka_consumer, ModuleId]}
          end,
            mfa =>
            {emqx_module_consumer_kafka, start_kafka_comsumer,
              3},
            line => 247})
      end;
    {error, Reason} ->
      begin
        logger:log(error, #{},
          #{report_cb =>
          fun (_) ->
            {logger_header() ++
              "Initiate Module ~p failed, ModuleId: "
              "~p, ~0p",
              [kafka_consumer, ModuleId, Reason]}
          end,
            mfa =>
            {emqx_module_consumer_kafka, start_kafka_comsumer,
              3},
            line => 250})
      end,
      error({kafka_consumer, {ModuleId, create_failed}})
  end.

format_servers(Servers) when is_binary(Servers) ->
  format_servers(str(Servers));
format_servers(Servers) ->
  ServerList = string:tokens(Servers, ", "),
  lists:map(fun (Server) ->
    case string:tokens(Server, ":") of
      [Domain] -> {Domain, 9092};
      [Domain, Port] -> {Domain, list_to_integer(Port)}
    end
            end,
    ServerList).

client_id(ModuleId) ->
  binary:replace(list_to_binary("kafka_consumer" ++
  str(ModuleId)),
    <<":">>, <<"_">>, [global]).

pool_name(ModuleId, Topic) ->
  list_to_atom(lists:concat(["kafka_consumer:",
    str(ModuleId), ":", str(Topic)])).

str(List) when is_list(List) -> List;
str(Bin) when is_binary(Bin) -> binary_to_list(Bin);
str(Atom) when is_atom(Atom) -> atom_to_list(Atom).

atom(B) when is_binary(B) ->
  erlang:binary_to_atom(B, utf8);
atom(L) when is_list(L) -> erlang:list_to_atom(L);
atom(A) -> A.

ensure_server_list(Servers, ClientConfig) ->
  ensure_server_list(Servers, ClientConfig, []).

ensure_server_list([], _ClientConfig, Errors) ->
  {error, Errors};
ensure_server_list([Host | Rest], ClientConfig,
    Errors) ->
  case kpro:connect(Host, ClientConfig) of
    {ok, Pid} ->
      _ = spawn(fun () -> do_close_connection(Pid) end), ok;
    {error, Reason} ->
      ensure_server_list(Rest, ClientConfig,
        [{Host, Reason} | Errors])
  end.

do_close_connection(Pid) ->
  Mref = erlang:monitor(process, Pid),
  erlang:send(Pid, {{self(), Mref}, stop}),
  receive
    {Mref, Reply} -> erlang:demonitor(Mref, [flush]), Reply;
    {'DOWN', Mref, _, _, Reason} ->
      {error, {connection_down, Reason}}
  after 5000 -> exit(Pid, kill)
  end.

connect(Opts) -> emqx_kafka_consumer:start(Opts).

maybe_append_ssl_options(ClientCfg, Config, ModuleId) ->
  case maps:get(<<"ssl">>, Config, false) of
    true ->
      ClientCfg#{ssl =>
      emqx_module_utils:get_ssl_opts(Config, ModuleId)};
    _ -> ClientCfg
  end.

logger_header() -> "".
