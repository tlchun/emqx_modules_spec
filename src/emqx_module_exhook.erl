%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:36
%%%-------------------------------------------------------------------
-module(emqx_module_exhook).
-author("root").

-export([on_module_create/2, on_module_update/4, on_module_destroy/2, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<84, 104, 101, 32, 69, 120, 116, 101, 110, 115, 105,
    111, 110, 32, 72, 111, 111, 107, 32, 102, 111, 114,
    32, 109, 117, 108, 116, 105, 112, 108, 101, 32, 108,
    97, 110, 103, 117, 97, 103, 101, 32, 115, 117, 112,
    112, 111, 114, 116, 101, 100>>,
    zh =>
    <<229, 164, 154, 232, 175, 173, 232, 168, 128, 230,
      137, 169, 229, 177, 149, 233, 146, 169, 229, 173,
      144>>},
  destroy => on_module_destroy, name => exhook,
  params =>
  #{cacertfile =>
  #{default => <<>>,
    description =>
    #{en =>
    <<67, 65, 32, 67, 101, 114, 116, 105, 102,
      105, 99, 97, 116, 101, 32, 70, 105, 108,
      101>>,
      zh =>
      <<67, 65, 32, 232, 175, 129, 228, 185, 166,
        230, 150, 135, 228, 187, 182>>},
    order => 5,
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
      order => 4,
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
      order => 3,
      title =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<231, 167, 129, 233, 146, 165, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    ssl =>
    #{default => false,
      description =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 72, 84,
        84, 80, 83>>,
        zh =>
        <<230, 152, 175, 229, 144, 166, 229, 188,
          128, 229, 144, 175, 32, 72, 84, 84, 80,
          83>>},
      order => 2,
      title =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 72, 84,
        84, 80, 83>>,
        zh =>
        <<229, 188, 128, 229, 144, 175, 32, 72, 84,
          84, 80, 83>>},
      type => boolean},
    url =>
    #{default =>
    <<104, 116, 116, 112, 58, 47, 47, 49, 50, 55, 46,
      48, 46, 48, 46, 49, 58, 56, 57, 57, 49>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 103, 82, 80, 67, 32,
        115, 101, 114, 118, 101, 114, 32, 85, 82,
        76, 32, 102, 111, 114, 32, 72, 111, 111,
        107, 80, 114, 111, 118, 105, 100, 101,
        114, 32, 83, 101, 114, 118, 105, 99,
        101>>,
        zh =>
        <<103, 82, 80, 67, 32, 72, 111, 111, 107,
          80, 114, 111, 118, 105, 100, 101, 114,
          32, 230, 156, 141, 229, 138, 161, 231,
          154, 132, 32, 72, 84, 84, 80, 32, 229,
          156, 176, 229, 157, 128>>},
      order => 1, required => true,
      title =>
      #{en =>
      <<83, 101, 114, 118, 101, 114, 32, 85, 82,
        76>>,
        zh =>
        <<230, 156, 141, 229, 138, 161, 229, 153,
          168, 32, 85, 82, 76>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<69, 120, 116, 101, 110, 115, 105, 111, 110, 32, 72,
    111, 111, 107>>,
    zh =>
    <<229, 164, 154, 232, 175, 173, 232, 168, 128, 230,
      137, 169, 229, 177, 149, 233, 146, 169, 229, 173,
      144>>},
  type => extension, update => on_module_update}).


on_module_create(ModId, #{<<"url">> := Url} = Config) ->
  _ = application:ensure_all_started(grpc),
  ServerOpts = config_to_server_opts(binary_to_list(Url),
    ModId, Config),
  _ = emqx_exhook_app:load_exhooks(),
  _ = emqx_exhook_app:load_server(ModId, ServerOpts),
  #{server => ModId}.

on_module_update(_ModId, Params, Config, Config) ->
  Params;
on_module_update(ModId, Params, _OldConfig, Config) ->
  on_module_destroy(ModId, Params),
  on_module_create(ModId, Config).

on_module_destroy(_ModId, #{server := Name}) ->
  emqx_exhook_app:unload_exhooks(),
  emqx_exhook_app:unload_server(Name).

on_module_status(_ModId, _) -> #{is_alive => true}.

config_to_server_opts(Url, ModId, Config) ->
  case http_uri:parse(Url) of
    {ok, {http, _, Host, Port, _, _}} ->
      [{scheme, http}, {host, Host}, {port, Port}];
    {ok, {https, _, Host, Port, _, _}} ->
      SSLOptions = emqx_module_utils:get_ssl_opts(Config,
        ModId),
      [{scheme, https}, {host, Host}, {port, Port},
        {ssl_options, [{ssl, true}] ++ SSLOptions}];
    _ -> error(invalid_server_options)
  end.

