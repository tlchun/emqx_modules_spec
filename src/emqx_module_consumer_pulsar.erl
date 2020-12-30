%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:36
%%%-------------------------------------------------------------------
-module(emqx_module_consumer_pulsar).
-author("root").

-export([logger_header/0]).
-include("../include/emqx.hrl").
-include("../include/logger.hrl").

-export([on_module_create/2, on_module_destroy/2, on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<80, 117, 108, 115, 97, 114, 32, 67, 111, 110, 115,
    117, 109, 101, 114, 32, 71, 114, 111, 117, 112>>,
    zh =>
    <<80, 117, 108, 115, 97, 114, 32, 230, 182, 136, 232,
      180, 185, 231, 187, 132>>},
  destroy => on_module_destroy, name => pulsar_consumer,
  params =>
  #{flow_size =>
  #{default => 1000,
    description =>
    #{en =>
    <<80, 117, 108, 115, 97, 114, 32, 102, 108,
      111, 119, 32, 99, 111, 110, 116, 114,
      111, 108, 32, 116, 104, 114, 101, 115,
      104, 111, 108, 100, 44, 32, 99, 111, 110,
      102, 105, 103, 117, 114, 101, 32, 104,
      111, 119, 32, 109, 97, 110, 121, 32, 109,
      101, 115, 115, 97, 103, 101, 115, 32, 80,
      117, 108, 115, 97, 114, 32, 115, 101,
      110, 100, 115, 32, 116, 111, 32, 99, 111,
      110, 115, 117, 109, 101, 114, 115, 32,
      97, 110, 100, 32, 116, 104, 101, 110, 32,
      98, 108, 111, 99, 107, 32, 80, 117, 108,
      115, 97, 114, 32, 67, 111, 110, 115, 117,
      109, 101, 114>>,
      zh =>
      <<80, 117, 108, 115, 97, 114, 32, 230, 181,
        129, 230, 142, 167, 233, 152, 136, 229,
        128, 188, 239, 188, 140, 233, 133, 141,
        231, 189, 174, 32, 80, 117, 108, 115, 97,
        114, 32, 229, 144, 145, 230, 182, 136,
        232, 180, 185, 232, 128, 133, 229, 143,
        145, 233, 128, 129, 229, 164, 154, 229,
        176, 145, 230, 157, 161, 230, 182, 136,
        230, 129, 175, 229, 144, 142, 233, 152,
        187, 229, 161, 158, 32, 80, 117, 108,
        115, 97, 114, 32, 67, 111, 110, 115, 117,
        109, 101, 114>>},
    order => 3,
    title =>
    #{en =>
    <<70, 108, 111, 119, 32, 84, 104, 114, 101,
      115, 104, 111, 108, 100>>,
      zh =>
      <<230, 181, 129, 230, 142, 167, 233, 152,
        136, 229, 128, 188>>},
    type => number},
    max_consumer_num =>
    #{default => 1,
      description =>
      #{en =>
      <<80, 117, 108, 115, 97, 114, 32, 67, 111,
        110, 115, 117, 109, 101, 114, 32, 78,
        117, 109>>,
        zh =>
        <<80, 117, 108, 115, 97, 114, 32, 67, 111,
          110, 115, 117, 109, 101, 114, 32, 78,
          117, 109>>},
      order => 2,
      title =>
      #{en =>
      <<67, 111, 110, 115, 117, 109, 101, 114,
        32, 78, 117, 109>>,
        zh =>
        <<67, 111, 110, 115, 117, 109, 101, 114,
          32, 78, 117, 109>>},
      type => number},
    reset_flow_rate =>
    #{default => <<56, 48, 37>>,
      description =>
      #{en =>
      <<80, 117, 108, 115, 97, 114, 32, 102, 108,
        111, 119, 32, 99, 111, 110, 116, 114,
        111, 108, 32, 116, 104, 114, 101, 115,
        104, 111, 108, 100, 32, 114, 101, 115,
        101, 116, 32, 112, 101, 114, 99, 101,
        110, 116, 97, 103, 101, 46, 84, 104, 105,
        115, 32, 99, 111, 110, 102, 105, 103,
        117, 114, 97, 116, 105, 111, 110, 32, 97,
        108, 108, 111, 119, 115, 32, 99, 111,
        110, 115, 117, 109, 101, 114, 115, 32,
        116, 111, 32, 114, 101, 115, 101, 116,
        32, 116, 104, 101, 32, 80, 117, 108, 115,
        97, 114, 32, 102, 108, 111, 119, 32, 99,
        111, 110, 116, 114, 111, 108, 32, 116,
        104, 114, 101, 115, 104, 111, 108, 100,
        32, 105, 110, 32, 97, 100, 118, 97, 110,
        99, 101, 32, 97, 102, 116, 101, 114, 32,
        112, 114, 111, 99, 101, 115, 115, 105,
        110, 103, 32, 97, 32, 99, 101, 114, 116,
        97, 105, 110, 32, 110, 117, 109, 98, 101,
        114, 32, 111, 102, 32, 109, 101, 115,
        115, 97, 103, 101, 115, 46, 40, 70, 111,
        114, 32, 101, 120, 97, 109, 112, 108,
        101, 44, 32, 105, 102, 32, 80, 117, 108,
        115, 97, 114, 32, 102, 108, 111, 119, 32,
        99, 111, 110, 116, 114, 111, 108, 32,
        116, 104, 114, 101, 115, 104, 111, 108,
        100, 32, 105, 115, 32, 49, 48, 48, 48,
        32, 97, 110, 100, 32, 116, 104, 114, 101,
        115, 104, 111, 108, 100, 32, 114, 101,
        115, 101, 116, 32, 112, 101, 114, 99,
        101, 110, 116, 97, 103, 101, 32, 105,
        115, 32, 56, 48, 37, 44, 32, 116, 104,
        101, 110, 32, 114, 101, 115, 101, 116,
        41>>,
        zh =>
        <<80, 117, 108, 115, 97, 114, 32, 230, 181,
          129, 230, 142, 167, 233, 152, 136, 229,
          128, 188, 233, 135, 141, 231, 189, 174,
          231, 153, 190, 229, 136, 134, 230, 175,
          148, 227, 128, 130, 230, 173, 164, 233,
          133, 141, 231, 189, 174, 232, 174, 169,
          230, 182, 136, 232, 180, 185, 232, 128,
          133, 229, 164, 132, 231, 144, 134, 229,
          174, 140, 230, 136, 144, 228, 184, 128,
          229, 174, 154, 230, 149, 176, 233, 135,
          143, 231, 154, 132, 230, 182, 136, 230,
          129, 175, 228, 185, 139, 229, 144, 142,
          239, 188, 140, 230, 143, 144, 229, 137,
          141, 233, 135, 141, 231, 189, 174, 32,
          80, 117, 108, 115, 97, 114, 32, 230, 181,
          129, 230, 142, 167, 233, 152, 136, 229,
          128, 188, 227, 128, 130, 32, 40, 230,
          175, 148, 229, 166, 130, 239, 188, 140,
          80, 117, 108, 115, 97, 114, 32, 230, 181,
          129, 230, 142, 167, 233, 152, 136, 229,
          128, 188, 32, 228, 184, 186, 32, 49, 48,
          48, 48, 239, 188, 140, 233, 152, 136,
          229, 128, 188, 233, 135, 141, 231, 189,
          174, 231, 153, 190, 229, 136, 134, 230,
          175, 148, 32, 228, 184, 186, 32, 56, 48,
          37, 239, 188, 140, 229, 136, 153, 233,
          135, 141, 231, 189, 174, 41>>},
      order => 4,
      title =>
      #{en =>
      <<82, 101, 115, 101, 116, 32, 70, 108, 111,
        119, 32, 82, 97, 116, 101>>,
        zh =>
        <<233, 135, 141, 231, 189, 174, 230, 181,
          129, 230, 142, 167, 233, 152, 136, 229,
          128, 188, 231, 154, 132, 231, 153, 190,
          229, 136, 134, 230, 175, 148>>},
      type => string},
    servers =>
    #{default =>
    <<49, 50, 55, 46, 48, 46, 48, 46, 49, 58, 54, 54,
      53, 48>>,
      description =>
      #{en =>
      <<80, 117, 108, 115, 97, 114, 32, 83, 101,
        114, 118, 101, 114, 32, 65, 100, 100,
        114, 101, 115, 115, 44, 32, 77, 117, 108,
        116, 105, 112, 108, 101, 32, 110, 111,
        100, 101, 115, 32, 115, 101, 112, 97,
        114, 97, 116, 101, 100, 32, 98, 121, 32,
        99, 111, 109, 109, 97, 115>>,
        zh =>
        <<80, 117, 108, 115, 97, 114, 32, 230, 156,
          141, 229, 138, 161, 229, 153, 168, 229,
          156, 176, 229, 157, 128, 44, 32, 229,
          164, 154, 232, 138, 130, 231, 130, 185,
          228, 189, 191, 231, 148, 168, 233, 128,
          151, 229, 143, 183, 229, 136, 134, 233,
          154, 148>>},
      order => 1, required => true,
      title =>
      #{en =>
      <<80, 117, 108, 115, 97, 114, 32, 83, 101,
        114, 118, 101, 114>>,
        zh =>
        <<80, 117, 108, 115, 97, 114, 32, 230, 156,
          141, 229, 138, 161, 229, 153, 168>>},
      type => string},
    topic_mapping =>
    #{default => [],
      description =>
      #{en =>
      <<80, 117, 108, 115, 97, 114, 32, 116, 111,
        112, 105, 99, 32, 116, 111, 32, 77, 81,
        84, 84, 32, 116, 111, 112, 105, 99, 32,
        109, 97, 112, 112, 105, 110, 103, 32,
        114, 101, 108, 97, 116, 105, 111, 110,
        115, 104, 105, 112>>,
        zh =>
        <<80, 117, 108, 115, 97, 114, 32, 228, 184,
          187, 233, 162, 152, 232, 189, 172, 32,
          77, 81, 84, 84, 32, 228, 184, 187, 233,
          162, 152, 230, 152, 160, 229, 176, 132,
          229, 133, 179, 231, 179, 187>>},
      items =>
      #{default => #{},
        schema =>
        #{mqtt_topic =>
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
            type => number},
          pulsar_topic =>
          #{default =>
          <<84, 101, 115, 116, 84, 111,
            112, 105, 99>>,
            description =>
            #{en =>
            <<80, 117, 108, 115, 97,
              114, 32, 84, 111, 112,
              105, 99>>,
              zh =>
              <<80, 117, 108, 115, 97,
                114, 32, 84, 111, 112,
                105, 99>>},
            order => 1, required => true,
            title =>
            #{en =>
            <<80, 117, 108, 115, 97,
              114, 32, 84, 111, 112,
              105, 99>>,
              zh =>
              <<80, 117, 108, 115, 97,
                114, 32, 228, 184, 187,
                233, 162, 152>>},
            type => string}},
        type => object},
      order => 5, required => true,
      title =>
      #{en =>
      <<84, 111, 112, 105, 99, 32, 77, 97, 112,
        112, 105, 110, 103>>,
        zh =>
        <<80, 117, 108, 115, 97, 114, 32, 228, 184,
          187, 233, 162, 152, 232, 189, 172, 32,
          77, 81, 84, 84, 32, 228, 184, 187, 233,
          162, 152, 230, 152, 160, 229, 176, 132,
          229, 133, 179, 231, 179, 187>>},
      type => array}},
  status => on_module_status,
  title =>
  #{en =>
  <<80, 117, 108, 115, 97, 114, 32, 67, 111, 110, 115,
    117, 109, 101, 114, 32, 71, 114, 111, 117, 112>>,
    zh =>
    <<80, 117, 108, 115, 97, 114, 32, 230, 182, 136, 232,
      180, 185, 231, 187, 132>>},
  type => message, update => on_module_update}).

-vsn("4.2.2").

on_module_create(ResId,
    Config = #{<<"servers">> := Servers,
      <<"topic_mapping">> := TopicMapping}) ->
  Servers1 = format_servers(Servers),
  ClientId = clientid(ResId),
  _ = application:ensure_all_started(pulsar),
  {ok, _Pid} = pulsar:ensure_supervised_client(ClientId,
    Servers1, #{}),
  lists:foreach(fun (TM = #{<<"pulsar_topic">> :=
  PulsarTopic,
    <<"mqtt_topic">> := MQTTTopic}) ->
    ConsumerOpts = #{mqtt_topic => MQTTTopic,
      mqtt_topic_qos =>
      maps:get(<<"mqtt_topic_qos">>,
        TM, 1),
      max_consumer_num =>
      maps:get(<<"max_consumer_num">>,
        Config, 1),
      name =>
      binary_to_atom(PulsarTopic,
        utf8),
      flow =>
      maps:get(<<"flow_size">>, Config,
        1000),
      flow_rate =>
      cuttlefish_datatypes:from_string(str(maps:get(<<"reset_flow_rate">>,
        Config,
        <<"80%">>)),
        {percent,
          float})},
    emqx_pulsar_consumer:start(ClientId, str(PulsarTopic),
      ConsumerOpts)
                end,
    TopicMapping),
  #{<<"client_id">> => ClientId,
    <<"servers">> => Servers1,
    <<"topic_mapping">> => TopicMapping}.

on_module_destroy(ResId,
    #{<<"client_id">> := ClientId,
      <<"topic_mapping">> := TopicMapping}) ->
  begin
    logger:log(info, #{},
      #{report_cb =>
      fun (_) ->
        {logger_header() ++
          "Destroying Feature ~p, ResId: ~p",
          [pulsar_consumer, ResId]}
      end,
        mfa =>
        {emqx_module_consumer_pulsar, on_module_destroy, 2},
        line => 138})
  end,
  lists:foreach(fun (#{<<"pulsar_topic">> :=
  PulsarTopic}) ->
    pulsar:stop_and_delete_supervised_consumers(#{client
    =>
    ClientId,
      name =>
      binary_to_atom(PulsarTopic,
        utf8)})
                end,
    TopicMapping),
  pulsar:stop_and_delete_supervised_client(ClientId).

on_module_status(_ResId,
    #{<<"client_id">> := ClientId}) ->
  case pulsar_client_sup:find_client(ClientId) of
    {ok, Pid} ->
      #{is_alive => pulsar_client:get_status(Pid)};
    _ -> #{is_alive => false}
  end.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

format_servers(Servers) when is_binary(Servers) ->
  format_servers(str(Servers));
format_servers(Servers) ->
  ServerList = string:tokens(Servers, ", "),
  lists:map(fun (Server) ->
    case string:tokens(Server, ":") of
      [Domain] -> {Domain, 6650};
      [Domain, Port] -> {Domain, list_to_integer(Port)}
    end
            end,
    ServerList).

clientid(ResId) ->
  list_to_atom("pulsar_consumer:" ++ str(ResId)).

str(List) when is_list(List) -> List;
str(Bin) when is_binary(Bin) -> binary_to_list(Bin);
str(Atom) when is_atom(Atom) -> atom_to_list(Atom).

logger_header() -> "".