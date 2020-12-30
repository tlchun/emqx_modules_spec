%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:39
%%%-------------------------------------------------------------------
-module(emqx_module_topic_rewrite).
-author("root").

-export([on_module_create/2, on_module_update/4, on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<84, 111, 112, 105, 99, 32, 82, 101, 119, 114, 105,
    116, 101>>,
    zh =>
    <<228, 184, 187, 233, 162, 152, 233, 135, 141, 229,
      134, 153>>},
  destroy => on_module_destroy, name => topic_rewrite,
  params =>
  #{rules =>
  #{default => [],
    description =>
    #{en =>
    <<84, 111, 112, 105, 99, 32, 82, 101, 119,
      114, 105, 116, 101, 32, 82, 117, 108,
      101, 115>>,
      zh =>
      <<228, 184, 187, 233, 162, 152, 233, 135,
        141, 229, 134, 153, 232, 167, 132, 229,
        136, 153>>},
    items =>
    #{default => #{},
      schema =>
      #{dest =>
      #{default => <<>>,
        description =>
        #{en =>
        <<68, 101, 115, 116, 32,
          84, 111, 112, 105,
          99>>,
          zh =>
          <<231, 155, 174, 230,
            160, 135, 228, 184,
            187, 233, 162, 152>>},
        order => 4,
        title =>
        #{en =>
        <<68, 101, 115, 116, 32,
          84, 111, 112, 105,
          99>>,
          zh =>
          <<231, 155, 174, 230,
            160, 135, 228, 184,
            187, 233, 162, 152>>},
        type => string},
        re =>
        #{default => <<>>,
          description =>
          #{en =>
          <<82, 101, 103, 117, 108,
            97, 114, 32, 69, 120,
            112, 114, 101, 115,
            115, 105, 111, 110>>,
            zh =>
            <<230, 173, 163, 229,
              136, 153, 232, 161,
              168, 232, 190, 190,
              229, 188, 143>>},
          order => 3,
          title =>
          #{en =>
          <<82, 101, 103, 117, 108,
            97, 114, 32, 69, 120,
            112, 114, 101, 115,
            115, 105, 111, 110>>,
            zh =>
            <<230, 173, 163, 229,
              136, 153, 232, 161,
              168, 232, 190, 190,
              229, 188, 143>>},
          type => string},
        topic =>
        #{default => <<>>,
          description =>
          #{en =>
          <<83, 111, 117, 114, 99,
            101, 32, 84, 111, 112,
            105, 99>>,
            zh =>
            <<229, 142, 159, 229,
              167, 139, 228, 184,
              187, 233, 162, 152>>},
          order => 2,
          title =>
          #{en =>
          <<83, 111, 117, 114, 99,
            101, 32, 84, 111, 112,
            105, 99>>,
            zh =>
            <<229, 142, 159, 229,
              167, 139, 228, 184,
              187, 233, 162, 152>>},
          type => string},
        type =>
        #{default =>
        <<115, 117, 98, 115, 99, 114,
          105, 98, 101>>,
          description =>
          #{en =>
          <<65, 99, 116, 105, 111,
            110>>,
            zh =>
            <<229, 138, 168, 228,
              189, 156, 231, 177,
              187, 229, 158, 139>>},
          enum =>
          [<<112, 117, 98, 108, 105, 115,
            104>>,
            <<115, 117, 98, 115, 99, 114,
              105, 98, 101>>],
          order => 1,
          title =>
          #{en =>
          <<65, 99, 116, 105, 111,
            110>>,
            zh =>
            <<229, 138, 168, 228,
              189, 156, 231, 177,
              187, 229, 158, 139>>},
          type => string}},
      type => object},
    order => 1,
    title =>
    #{en =>
    <<82, 101, 119, 114, 105, 116, 101, 32, 82,
      117, 108, 101, 115>>,
      zh =>
      <<228, 184, 187, 233, 162, 152, 233, 135,
        141, 229, 134, 153, 232, 167, 132, 229,
        136, 153>>},
    type => array}},
  status => on_module_status,
  title =>
  #{en =>
  <<84, 111, 112, 105, 99, 32, 82, 101, 119, 114, 105,
    116, 101>>,
    zh =>
    <<228, 184, 187, 233, 162, 152, 233, 135, 141, 229,
      134, 153>>},
  type => module, update => on_module_update}).

-vsn("4.2.2").

on_module_create(_ModuleId, #{<<"rules">> := Rules}) ->
  {PubRules, SubRules} = compile(Rules),
  emqx:hook('client.subscribe',
    {emqx_mod_rewrite, rewrite_subscribe, [SubRules]}),
  emqx:hook('client.unsubscribe',
    {emqx_mod_rewrite, rewrite_unsubscribe, [SubRules]}),
  emqx:hook('message.publish',
    {emqx_mod_rewrite, rewrite_publish, [PubRules]}),
  #{}.

on_module_update(_ModuleId, Context, Config, Config) ->
  Context;
on_module_update(ModuleId, Context, _Config,
    NewConfig) ->
  on_module_destroy(ModuleId, Context),
  on_module_create(ModuleId, NewConfig).

on_module_destroy(_ModuleId, #{}) ->
  emqx:unhook('client.subscribe',
    {emqx_mod_rewrite, rewrite_subscribe}),
  emqx:unhook('client.unsubscribe',
    {emqx_mod_rewrite, rewrite_unsubscribe}),
  emqx:unhook('message.publish',
    {emqx_mod_rewrite, rewrite_publish}),
  ok.

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

compile(Rules) ->
  PubRules = [begin
                {ok, MP} = re:compile(Re), {rewrite, Topic, MP, Dest}
              end
    || #{<<"type">> := <<"publish">>, <<"topic">> := Topic,
      <<"re">> := Re, <<"dest">> := Dest}
      <- Rules],
  SubRules = [begin
                {ok, MP} = re:compile(Re), {rewrite, Topic, MP, Dest}
              end
    || #{<<"type">> := <<"subscribe">>,
      <<"topic">> := Topic, <<"re">> := Re,
      <<"dest">> := Dest}
      <- Rules],
  {PubRules, SubRules}.

