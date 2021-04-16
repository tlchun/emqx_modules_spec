%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:34
%%%-------------------------------------------------------------------
-module(emqx_module_auth_http).
-author("root").

-record(http_request,
{method = post, path, headers, params,
  request_timeout}).

-export([on_module_create/2, on_module_destroy/2, on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<72, 84, 84, 80, 32, 65, 85, 84, 72, 47, 65, 67, 76>>,
    zh =>
    <<72, 84, 84, 80, 32, 232, 174, 164, 232, 175, 129, 47,
      232, 174, 191, 233, 151, 174, 230, 142, 167, 229,
      136, 182>>},
  destroy => on_module_destroy,
  name => http_authentication,
  params =>
  #{acl_req =>
  #{default =>
  <<104, 116, 116, 112, 58, 47, 47, 49, 50, 55, 46,
    48, 46, 48, 46, 49, 58, 56, 57, 57, 49, 47,
    109, 113, 116, 116, 47, 97, 99, 108>>,
    description =>
    #{en =>
    <<65, 67, 76, 32, 82, 101, 113, 117, 101,
      115, 116, 32, 85, 82, 76>>,
      zh =>
      <<232, 174, 191, 233, 151, 174, 230, 142,
        167, 229, 136, 182, 232, 175, 183, 230,
        177, 130, 229, 156, 176, 229, 157,
        128>>},
    order => 3,
    title =>
    #{en =>
    <<65, 67, 76, 32, 82, 101, 113, 117, 101,
      115, 116, 32, 85, 82, 76>>,
      zh =>
      <<232, 174, 191, 233, 151, 174, 230, 142,
        167, 229, 136, 182, 232, 175, 183, 230,
        177, 130, 229, 156, 176, 229, 157,
        128>>},
    type => string},
    acl_req_params =>
    #{default =>
    <<97, 99, 99, 101, 115, 115, 61, 37, 65, 44, 117,
      115, 101, 114, 110, 97, 109, 101, 61, 37, 117,
      44, 99, 108, 105, 101, 110, 116, 105, 100, 61,
      37, 99, 44, 105, 112, 97, 100, 100, 114, 61,
      37, 97, 44, 116, 111, 112, 105, 99, 61, 37,
      116, 44, 109, 111, 117, 110, 116, 112, 111,
      105, 110, 116, 61, 37, 109>>,
      description =>
      #{en =>
      <<65, 67, 76, 32, 82, 101, 113, 117, 101,
        115, 116, 32, 80, 97, 114, 97, 109,
        115>>,
        zh =>
        <<232, 174, 191, 233, 151, 174, 230, 142,
          167, 229, 136, 182, 232, 175, 183, 230,
          177, 130, 229, 143, 130, 230, 149,
          176>>},
      order => 4,
      title =>
      #{en =>
      <<65, 67, 76, 32, 82, 101, 113, 117, 101,
        115, 116, 32, 80, 97, 114, 97, 109,
        115>>,
        zh =>
        <<232, 174, 191, 233, 151, 174, 230, 142,
          167, 229, 136, 182, 232, 175, 183, 230,
          177, 130, 229, 143, 130, 230, 149,
          176>>},
      type => string},
    auth_req =>
    #{default =>
    <<104, 116, 116, 112, 58, 47, 47, 49, 50, 55, 46,
      48, 46, 48, 46, 49, 58, 56, 57, 57, 49, 47,
      109, 113, 116, 116, 47, 97, 117, 116, 104>>,
      description =>
      #{en =>
      <<65, 85, 84, 72, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 85, 82, 76>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 232, 175,
          183, 230, 177, 130, 229, 156, 176, 229,
          157, 128>>},
      order => 1,
      title =>
      #{en =>
      <<65, 85, 84, 72, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 85, 82, 76>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 232, 175,
          183, 230, 177, 130, 229, 156, 176, 229,
          157, 128>>},
      type => string},
    auth_req_params =>
    #{default =>
    <<99, 108, 105, 101, 110, 116, 105, 100, 61, 37,
      99, 44, 117, 115, 101, 114, 110, 97, 109, 101,
      61, 37, 117, 44, 112, 97, 115, 115, 119, 111,
      114, 100, 61, 37, 80>>,
      description =>
      #{en =>
      <<65, 85, 84, 72, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 80, 97, 114, 97, 109,
        115>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 232, 175,
          183, 230, 177, 130, 229, 143, 130, 230,
          149, 176>>},
      order => 2,
      title =>
      #{en =>
      <<65, 85, 84, 72, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 80, 97, 114, 97, 109,
        115>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 232, 175,
          183, 230, 177, 130, 229, 143, 130, 230,
          149, 176>>},
      type => string},
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
      order => 17,
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
      order => 16,
      title =>
      #{en =>
      <<67, 101, 114, 116, 105, 102, 105, 99, 97,
        116, 101, 32, 70, 105, 108, 101>>,
        zh =>
        <<232, 175, 129, 228, 185, 166, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    http_headers =>
    #{default => #{},
      description =>
      #{en =>
      <<82, 101, 113, 117, 101, 115, 116, 32, 72,
        101, 97, 100, 101, 114>>,
        zh =>
        <<232, 175, 183, 230, 177, 130, 229, 164,
          180>>},
      order => 9, schema => #{},
      title =>
      #{en =>
      <<82, 101, 113, 117, 101, 115, 116, 32, 72,
        101, 97, 100, 101, 114>>,
        zh =>
        <<232, 175, 183, 230, 177, 130, 229, 164,
          180>>},
      type => object},
    http_opts_connect_timeout =>
    #{default => <<53, 115>>,
      description =>
      #{en =>
      <<72, 84, 84, 80, 32, 67, 111, 110, 110,
        101, 99, 116, 32, 84, 105, 109, 101, 111,
        117, 116>>,
        zh =>
        <<72, 84, 84, 80, 32, 67, 111, 110, 110,
          101, 99, 116, 32, 84, 105, 109, 101, 111,
          117, 116>>},
      order => 13,
      title =>
      #{en =>
      <<72, 84, 84, 80, 32, 67, 111, 110, 110,
        101, 99, 116, 32, 84, 105, 109, 101, 111,
        117, 116>>,
        zh =>
        <<72, 84, 84, 80, 32, 67, 111, 110, 110,
          101, 99, 116, 32, 84, 105, 109, 101, 111,
          117, 116>>},
      type => string},
    http_opts_retry_interval =>
    #{default => <<49, 115>>,
      description =>
      #{en =>
      <<82, 101, 116, 114, 121, 32, 73, 110, 116,
        101, 114, 118, 97, 108>>,
        zh =>
        <<233, 135, 141, 232, 175, 149, 233, 151,
          180, 233, 154, 148>>},
      order => 11,
      title =>
      #{en =>
      <<82, 101, 116, 114, 121, 32, 73, 110, 116,
        101, 114, 118, 97, 108>>,
        zh =>
        <<233, 135, 141, 232, 175, 149, 233, 151,
          180, 233, 154, 148>>},
      type => string},
    http_opts_retry_times =>
    #{default => 5,
      description =>
      #{en =>
      <<82, 101, 116, 114, 121, 32, 84, 105, 109,
        101, 115>>,
        zh =>
        <<233, 135, 141, 232, 175, 149, 230, 172,
          161, 230, 149, 176>>},
      order => 10,
      title =>
      #{en =>
      <<82, 101, 116, 114, 121, 32, 84, 105, 109,
        101, 115>>,
        zh =>
        <<233, 135, 141, 232, 175, 149, 230, 172,
          161, 230, 149, 176>>},
      type => number},
    http_opts_timeout =>
    #{default => <<53, 115>>,
      description =>
      #{en =>
      <<72, 84, 84, 80, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 84, 105, 109, 101,
        111, 117, 116>>,
        zh =>
        <<72, 84, 84, 80, 32, 82, 101, 113, 117,
          101, 115, 116, 32, 84, 105, 109, 101,
          111, 117, 116>>},
      order => 12,
      title =>
      #{en =>
      <<72, 84, 84, 80, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 84, 105, 109, 101,
        111, 117, 116>>,
        zh =>
        <<72, 84, 84, 80, 32, 82, 101, 113, 117,
          101, 115, 116, 32, 84, 105, 109, 101,
          111, 117, 116>>},
      type => string},
    keyfile =>
    #{default => <<>>,
      description =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<83, 83, 76, 32, 231, 167, 129, 233, 146,
          165, 230, 150, 135, 228, 187, 182>>},
      order => 15,
      title =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<231, 167, 129, 233, 146, 165, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    method =>
    #{default => <<80, 79, 83, 84>>,
      description =>
      #{en =>
      <<72, 84, 84, 80, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 77, 101, 116, 104,
        111, 100>>,
        zh =>
        <<72, 84, 84, 80, 32, 232, 175, 183, 230,
          177, 130, 230, 150, 185, 230, 179,
          149>>},
      enum => [<<71, 69, 84>>, <<80, 79, 83, 84>>],
      order => 7,
      title =>
      #{en =>
      <<72, 84, 84, 80, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 77, 101, 116, 104,
        111, 100>>,
        zh =>
        <<72, 84, 84, 80, 32, 232, 175, 183, 230,
          177, 130, 230, 150, 185, 230, 179,
          149>>},
      type => string},
    pool_size =>
    #{default => 8,
      description =>
      #{en =>
      <<80, 111, 111, 108, 32, 83, 105, 122, 101,
        32, 102, 111, 114, 32, 72, 84, 84, 80,
        32, 83, 101, 114, 118, 101, 114>>,
        zh =>
        <<72, 84, 84, 80, 32, 83, 101, 114, 118,
          101, 114, 32, 232, 191, 158, 230, 142,
          165, 230, 177, 160, 229, 164, 167, 229,
          176, 143>>},
      order => 18,
      title =>
      #{en =>
      <<80, 111, 111, 108, 32, 83, 105, 122,
        101>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 177,
          160, 229, 164, 167, 229, 176, 143>>},
      type => number},
    req_content_type =>
    #{default =>
    <<97, 112, 112, 108, 105, 99, 97, 116, 105, 111,
      110, 47, 120, 45, 119, 119, 119, 45, 102, 111,
      114, 109, 45, 117, 114, 108, 101, 110, 99, 111,
      100, 101, 100>>,
      description =>
      #{en =>
      <<72, 84, 84, 80, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 67, 111, 110, 116,
        101, 110, 116, 84, 121, 112, 101>>,
        zh =>
        <<72, 84, 84, 80, 32, 232, 175, 183, 230,
          177, 130, 231, 177, 187, 229, 158,
          139>>},
      enum =>
      [<<97, 112, 112, 108, 105, 99, 97, 116, 105, 111,
        110, 47, 106, 115, 111, 110>>,
        <<97, 112, 112, 108, 105, 99, 97, 116, 105, 111,
          110, 47, 120, 45, 119, 119, 119, 45, 102, 111,
          114, 109, 45, 117, 114, 108, 101, 110, 99,
          111, 100, 101, 100>>],
      order => 8,
      title =>
      #{en =>
      <<72, 84, 84, 80, 32, 82, 101, 113, 117,
        101, 115, 116, 32, 67, 111, 110, 116,
        101, 110, 116, 84, 121, 112, 101>>,
        zh =>
        <<72, 84, 84, 80, 32, 232, 175, 183, 230,
          177, 130, 231, 177, 187, 229, 158,
          139>>},
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
      order => 14,
      title =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 83, 83,
        76>>,
        zh =>
        <<229, 188, 128, 229, 144, 175, 32, 83, 83,
          76>>},
      type => boolean},
    super_req =>
    #{default => <<>>,
      description =>
      #{en =>
      <<83, 117, 112, 101, 114, 32, 85, 115, 101,
        114, 32, 82, 101, 113, 117, 101, 115,
        116, 32, 85, 82, 76>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 232, 175, 183, 230,
          177, 130, 229, 156, 176, 229, 157,
          128>>},
      order => 5,
      title =>
      #{en =>
      <<83, 117, 112, 101, 114, 32, 85, 115, 101,
        114, 32, 82, 101, 113, 117, 101, 115,
        116, 32, 85, 82, 76>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 232, 175, 183, 230,
          177, 130, 229, 156, 176, 229, 157,
          128>>},
      type => string},
    super_req_params =>
    #{default => <<>>,
      description =>
      #{en =>
      <<83, 117, 112, 101, 114, 32, 85, 115, 101,
        114, 32, 82, 101, 113, 117, 101, 115,
        116, 32, 80, 97, 114, 97, 109, 115>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 232, 175, 183, 230,
          177, 130, 229, 143, 130, 230, 149,
          176>>},
      order => 6,
      title =>
      #{en =>
      <<83, 117, 112, 101, 114, 32, 85, 115, 101,
        114, 32, 82, 101, 113, 117, 101, 115,
        116, 32, 80, 97, 114, 97, 109, 115>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 232, 175, 183, 230,
          177, 130, 229, 143, 130, 230, 149,
          176>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<72, 84, 84, 80, 32, 65, 85, 84, 72, 47, 65, 67, 76>>,
    zh =>
    <<72, 84, 84, 80, 32, 232, 174, 164, 232, 175, 129, 47,
      232, 174, 191, 233, 151, 174, 230, 142, 167, 229,
      136, 182>>},
  type => auth, update => on_module_update}).


on_module_create(ModuleId, Params) ->
  _ = application:ensure_all_started(gun),
  _ = application:ensure_all_started(gproc),
  case pool_opts(ModuleId, Params) of
    {error, Reason} -> error(Reason);
    PoolOpts ->
      NPoolOpts = inet(PoolOpts),
      PoolSize = pool_size(NPoolOpts),
      Pool = emqx_module_auth_http,
      ok = ensure_pool(emqx_module_auth_http, random,
        [{size, PoolSize}]),
      [ensure_pool_worker(Pool, {Pool, I}, I, NPoolOpts)
        || I <- lists:seq(1, PoolSize)],
      NParams = Params#{pool_name => Pool},
      load_auth_hook(NParams),
      load_acl_hook(NParams),
      #{pool_name => Pool, pool_size => PoolSize}
  end.

on_module_destroy(_ModuleId,
    #{pool_name := PoolName, pool_size := PoolSize}) ->
  emqx:unhook('client.authenticate',
    {emqx_auth_http, check}),
  emqx:unhook('client.check_acl',
    {emqx_acl_http, check_acl}),
  stop_pool(PoolName, PoolSize).

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

pool_opts(ModuleId, Params) ->
  URIs = lists:foldl(fun (Name, Acc) ->
    case maps:get(Name, Params, undefined) of
      <<"">> -> Acc;
      URI ->
        #{host := Host0, port := Port,
          path := Path} =
          uri_string:parse(URI),
        Host = get_addr(binary_to_list(Host0)),
        [{Name, {Host, Port, binary_to_list(Path)}}
          | Acc]
    end
                     end,
    [], [<<"acl_req">>, <<"auth_req">>, <<"super_req">>]),
  case same_host_and_port(URIs) of
    true ->
      {_, {Host, Port, _}} = lists:last(URIs),
      ConnectTimeout =
        emqx_module_utils:parse_timeout(maps:get(<<"http_opts_connect_timeout">>,
          Params, <<"5s">>)),
      Retry = maps:get(<<"http_opts_retry_times">>, Params,
        5),
      RetryTimeout =
        emqx_module_utils:parse_timeout(maps:get(<<"http_opts_retry_interval">>,
          Params, <<"1s">>)),
      PoolSize = maps:get(<<"pool_size">>, Params, 8),
      [{host, Host}, {port, Port}, {pool_size, PoolSize},
        {connect_timeout, ConnectTimeout}, {retry, Retry},
        {retry_timeout, RetryTimeout}]
      ++ transport_opts(ModuleId, Params);
    false -> {error, different_server}
  end.

same_host_and_port([_]) -> true;
same_host_and_port([{_, {Host, Port, _}},
  {_, {Host, Port, _}}]) ->
  true;
same_host_and_port([{_, {Host, Port, _}},
  URI = {_, {Host, Port, _}}
  | Rest]) ->
  same_host_and_port([URI | Rest]);
same_host_and_port(_) -> false.

transport_opts(ModuleId, Params) ->
  SslOptions = ssl_opts(ModuleId, Params),
  case SslOptions of
    [] -> [];
    _ -> [{transport, ssl}, {transport_opts, SslOptions}]
  end.

ssl_opts(ModuleId, Params) ->
  case maps:get(<<"ssl">>, Params, false) of
    true ->
      emqx_module_utils:get_sll_opts(Params, ModuleId);
    _ -> []
  end.

get_addr(Hostname) ->
  case inet:parse_address(Hostname) of
    {ok, {_, _, _, _} = Addr} -> Addr;
    {ok, {_, _, _, _, _, _, _, _} = Addr} -> Addr;
    {error, einval} ->
      case inet:getaddr(Hostname, inet) of
        {error, _} ->
          {ok, Addr} = inet:getaddr(Hostname, inet6), Addr;
        {ok, Addr} -> Addr
      end
  end.

make_http_request(auth_req,
    #{<<"auth_req">> := <<"">>}) ->
  undefined;
make_http_request(auth_req,
    Params = #{<<"auth_req">> := URI}) ->
  #{path := Path} = uri_string:parse(URI),
  Params0 = extract_param(maps:get(<<"auth_req_params">>,
    Params, "")),
  make_http_request2(Params,
    #http_request{path = Path, params = Params0});
make_http_request(acl_req,
    #{<<"acl_req">> := <<"">>}) ->
  undefined;
make_http_request(acl_req,
    Params = #{<<"acl_req">> := URI}) ->
  #{path := Path} = uri_string:parse(URI),
  Params0 = extract_param(maps:get(<<"acl_req_params">>,
    Params, "")),
  make_http_request2(Params,
    #http_request{path = Path, params = Params0});
make_http_request(super_req,
    #{<<"super_req">> := <<"">>}) ->
  undefined;
make_http_request(super_req,
    Params = #{<<"super_req">> := URI}) ->
  #{path := Path} = uri_string:parse(URI),
  Params0 = extract_param(maps:get(<<"super_req_params">>,
    Params, "")),
  make_http_request2(Params,
    #http_request{path = Path, params = Params0}).

make_http_request2(Params, HTTPRequest) ->
  Headers = get_headers(maps:get(<<"http_headers">>,
    Params, #{})),
  Method = get_method(maps:get(<<"method">>, Params,
    <<"POST">>)),
  ContentType = maps:get(<<"req_content_type">>, Params,
    <<"application/x-www-form-urlencoded">>),
  NewHeaders = [{<<"content_type">>, ContentType}
    | Headers],
  RequestTimeout =
    emqx_module_utils:parse_timeout(maps:get(<<"http_opts_connect_timeout">>,
      Params, <<"5s">>)),
  HTTPRequest#http_request{method = Method,
    headers = NewHeaders,
    request_timeout = RequestTimeout}.

inet(PoolOpts) ->
  case proplists:get_value(host, PoolOpts) of
    Host when tuple_size(Host) =:= 8 ->
      TransOpts = proplists:get_value(transport_opts,
        PoolOpts, []),
      NewPoolOpts = proplists:delete(transport_opts,
        PoolOpts),
      [{transport_opts, [inet6 | TransOpts]} | NewPoolOpts];
    _ -> PoolOpts
  end.

load_auth_hook(Params = #{pool_name := PoolName}) ->
  ok = emqx_auth_http:register_metrics(),
  case make_http_request(auth_req, Params) of
    undefined -> ok;
    AuthReq ->
      SuperReq = make_http_request(super_req, Params),
      emqx:hook('client.authenticate',
        {emqx_auth_http, check,
          [#{auth_req => AuthReq, super_req => SuperReq,
            pool_name => PoolName}]})
  end.

load_acl_hook(Params = #{pool_name := PoolName}) ->
  ok = emqx_auth_http:register_metrics(),
  case make_http_request(acl_req, Params) of
    undefined -> ok;
    ACLReq ->
      emqx:hook('client.check_acl',
        {emqx_acl_http, check_acl,
          [#{acl_req => ACLReq, pool_name => PoolName}]})
  end.

extract_param(P) when is_binary(P) ->
  extract_param(b2l(P));
extract_param(P) when is_list(P) ->
  case P of
    "" -> [];
    _ ->
      [list_to_tuple(string:tokens(S, " ="))
        || S <- string:tokens(P, " ,")]
  end.

b2l(B) -> binary_to_list(B).

get_method(<<"GET">>) -> get;
get_method(<<"POST">>) -> post;
get_method(_) -> post.

get_headers([]) -> [];
get_headers(Headers) -> maps:to_list(Headers).

ensure_pool(Pool, Type, Opts) ->
  try gproc_pool:new(Pool, Type, Opts) catch
    error:exists -> ok
  end.

ensure_pool_worker(Pool, Name, Slot, PoolOpts) ->
  try gproc_pool:add_worker(Pool, Name, Slot),
  ClientSpec = #{id => {Pool, Slot},
    start =>
    {emqx_http_client, start_link,
      [Pool, Slot, PoolOpts]},
    restart => transient, shutdown => 5000, type => worker,
    modules => [emqx_http_client]},
  emqx_modules_sup:start_child(ClientSpec)
  catch
    error:exists -> ok
  end.

pool_size(Opts) ->
  Schedulers = erlang:system_info(schedulers),
  proplists:get_value(pool_size, Opts, Schedulers).

stop_pool(Name, Size) ->
  [emqx_modules_sup:stop_child({Name, I})
    || I <- lists:seq(1, Size)],
  Workers = gproc_pool:defined_workers(Name),
  [gproc_pool:remove_worker(Name, WokerName)
    || {WokerName, _, _} <- Workers],
  gproc_pool:delete(Name),
  ok.

