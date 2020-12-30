%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:39
%%%-------------------------------------------------------------------
-module(emqx_pulsar_consumer).
-author("root").
-export([logger_header/0]).

-export([start/3]).

-export([init/2, handle_message/3]).
-include("../include/logger.hrl").
-include("../include/emqx.hrl").



-vsn("4.2.2").

init(_Topic, Args) -> {ok, Args}.

handle_message(MessageId, Payload, State) ->
  MQTTTopic = maps:get(mqtt_topic, State),
  MQTTTopicQoS = maps:get(mqtt_topic_qos, State, 0),
  begin
    logger:log(debug, #{},
      #{report_cb =>
      fun (_) ->
        {logger_header() ++
          "Receive pulsar message:~p",
          [{MessageId, Payload}]}
      end,
        mfa => {emqx_pulsar_consumer, handle_message, 3},
        line => 22})
  end,
  Msg = emqx_message:make(<<"pulsar_consumer">>,
    MQTTTopicQoS, MQTTTopic, Payload),
  emqx_metrics:inc_msg(Msg),
  emqx:publish(Msg#message{flags = #{retain => false}}),
  {ok, 'Individual', State}.

start(Client, Topic, ConsumerOpts0) ->
  ConsumerOpts1 = maps:merge(#{cb_init_args =>
  ConsumerOpts0,
    cb_module => emqx_pulsar_consumer,
    sub_type => 'Shared',
    subscription =>
    atom_to_list(maps:get(name,
      ConsumerOpts0))},
    ConsumerOpts0),
  pulsar:ensure_supervised_consumers(Client, Topic,
    maps:without([mqtt_topic],
      ConsumerOpts1)).

logger_header() -> "".

