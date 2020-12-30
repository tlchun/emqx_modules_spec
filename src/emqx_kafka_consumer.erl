%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:34
%%%-------------------------------------------------------------------
-module(emqx_kafka_consumer).
-author("root").

-module(emqx_kafka_consumer).

-export([logger_header/0]).
-include("../include/brod.hrl").
-include("../include/kpro_public.hrl").
-include("../include/logger.hrl").
-include("../include/emqx.hrl").



-export([start/1]).
-export([init/2, handle_message/4]).

-vsn("4.2.2").

init(_GroupId, State) -> {ok, State}.

handle_message(_Topic, Partition, Message, State) ->
  MQTTTopic = proplists:get_value(mqtt_topic, State),
  begin
    logger:log(debug, #{},
      #{report_cb =>
      fun (_) ->
        {logger_header() ++ "consumer :~p",
          [{_Topic, Partition, Message}]}
      end,
        mfa => {emqx_kafka_consumer, handle_message, 4},
        line => 23})
  end,
  MQTTTopicQoS = proplists:get_value(mqtt_topic_qos,
    State, 0),
  Msg = emqx_message:make(<<"kafka_consumer">>,
    MQTTTopicQoS, MQTTTopic,
    Message#kafka_message.value),
  emqx_metrics:inc_msg(Msg),
  emqx:publish(Msg#message{flags = #{retain => false}}),
  {ok, ack, State}.

start(Opts) ->
  ClientId = proplists:get_value(client_id, Opts),
  KafkaTopic = proplists:get_value(kafka_topic, Opts),
  GroupId = proplists:get_value(group_id, Opts),
  ConsumerConfig = proplists:get_value(consumer_config,
    Opts),
  GroupConfig = proplists:get_value(group_config, Opts),
  brod:start_link_group_subscriber(ClientId, GroupId,
    [KafkaTopic], GroupConfig, ConsumerConfig,
    emqx_kafka_consumer, Opts).

logger_header() -> "".

