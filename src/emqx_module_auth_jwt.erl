%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:34
%%%-------------------------------------------------------------------
-module(emqx_module_auth_jwt).
-author("root").

-export([on_module_create/2, on_module_destroy/2, on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create,
  description =>
  #{en => <<74, 87, 84, 32, 65, 85, 84, 72>>,
    zh => <<74, 87, 84, 32, 232, 174, 164, 232, 175, 129>>},
  destroy => on_module_destroy,
  name => jwt_authentication,
  params =>
  #{claims =>
  #{default => #{},
    description =>
    #{en =>
    <<84, 104, 101, 32, 67, 104, 101, 99, 107,
      108, 105, 115, 116, 32, 111, 102, 32, 67,
      108, 97, 105, 109, 115, 32, 116, 111, 32,
      86, 97, 108, 105, 100, 97, 116, 101>>,
      zh =>
      <<232, 166, 129, 233, 170, 140, 232, 175,
        129, 231, 154, 132, 229, 163, 176, 230,
        152, 142, 229, 173, 151, 230, 174, 181,
        229, 136, 151, 232, 161, 168>>},
    order => 6, schema => #{},
    title =>
    #{en => <<67, 108, 97, 105, 109, 115>>,
      zh =>
      <<229, 163, 176, 230, 152, 142, 229, 173,
        151, 230, 174, 181, 229, 136, 151, 232,
        161, 168>>},
    type => object},
    from =>
    #{default => <<112, 97, 115, 115, 119, 111, 114, 100>>,
      description =>
      #{en => <<70, 114, 111, 109>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 157,
          165, 230, 186, 144>>},
      enum =>
      [<<112, 97, 115, 115, 119, 111, 114, 100>>,
        <<117, 115, 101, 114, 110, 97, 109, 101>>],
      order => 1,
      title =>
      #{en => <<70, 114, 111, 109>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 157,
          165, 230, 186, 144>>}},
    jwks_addr =>
    #{default => <<>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 115, 101, 114, 118,
        101, 114, 32, 72, 84, 84, 80, 47, 72, 84,
        84, 80, 83, 32, 97, 100, 100, 114, 101,
        115, 115, 32, 102, 111, 114, 32, 74, 83,
        79, 78, 32, 87, 101, 98, 32, 75, 101,
        121, 115>>,
        zh =>
        <<74, 83, 79, 78, 32, 87, 101, 98, 32, 75,
          101, 121, 115, 32, 231, 154, 132, 32, 72,
          84, 84, 80, 47, 72, 84, 84, 80, 83, 32,
          230, 156, 141, 229, 138, 161, 229, 153,
          168, 229, 156, 176, 229, 157, 128>>},
      order => 4,
      title =>
      #{en =>
      <<74, 87, 75, 115, 32, 65, 100, 100, 114>>,
        zh =>
        <<74, 87, 75, 115, 32, 230, 156, 141, 229,
          138, 161, 229, 153, 168, 229, 156, 176,
          229, 157, 128>>},
      type => string},
    pubkey =>
    #{default => <<>>,
      description =>
      #{en =>
      <<82, 83, 65, 32, 111, 114, 32, 69, 67, 68,
        83, 65, 32, 112, 117, 98, 108, 105, 99,
        32, 107, 101, 121, 32, 102, 105, 108,
        101>>,
        zh =>
        <<82, 83, 65, 230, 136, 150, 69, 67, 68,
          83, 65, 229, 133, 172, 233, 146, 165,
          230, 150, 135, 228, 187, 182>>},
      order => 3,
      title =>
      #{en => <<80, 117, 98, 107, 101, 121>>,
        zh =>
        <<229, 133, 172, 233, 146, 165, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    secret =>
    #{default => <<115, 101, 99, 114, 101, 116>>,
      description =>
      #{en => <<83, 101, 99, 114, 101, 116>>,
        zh => <<229, 175, 134, 233, 146, 165>>},
      order => 2,
      title =>
      #{en => <<83, 101, 99, 114, 101, 116>>,
        zh => <<229, 175, 134, 233, 146, 165>>},
      type => password},
    verify_claims =>
    #{default => false,
      description =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 116, 111,
        32, 86, 101, 114, 105, 102, 121, 32, 67,
        108, 97, 105, 109, 115, 32, 70, 105, 101,
        108, 100, 115>>,
        zh =>
        <<229, 144, 175, 231, 148, 168, 233, 170,
          140, 232, 175, 129, 229, 163, 176, 230,
          152, 142, 229, 173, 151, 230, 174,
          181>>},
      order => 5,
      title =>
      #{en =>
      <<86, 101, 114, 105, 102, 121, 32, 67, 108,
        97, 105, 109, 115>>,
        zh =>
        <<233, 170, 140, 232, 175, 129, 229, 163,
          176, 230, 152, 142, 229, 173, 151, 230,
          174, 181>>},
      type => boolean}},
  status => on_module_status,
  title =>
  #{en => <<74, 87, 84, 32, 65, 85, 84, 72>>,
    zh => <<74, 87, 84, 32, 232, 174, 164, 232, 175, 129>>},
  type => auth, update => on_module_update}).


on_module_create(ModId, Params) ->
  _ = application:ensure_all_started(jose),
  ok = emqx_auth_jwt:register_metrics(),
  PubKey = case maps:get(<<"pubkey">>, Params, <<>>) of
             <<>> -> undefined;
             V0 -> emqx_module_utils:save_upload_file(V0, ModId)
           end,
  Secret = case maps:get(<<"secret">>, Params, <<>>) of
             <<>> -> undefined;
             V1 -> b2l(V1)
           end,
  JwksAddr = case maps:get(<<"jwks_addr">>, Params, <<>>)
             of
               <<>> -> undefined;
               V2 -> b2l(V2)
             end,
  JwtSvrOpts = [{K, V}
    || {K, V}
      <- [{secret, Secret}, {pubkey, PubKey},
        {jwks_addr, JwksAddr}, {interval, 300000}],
    V /= undefined],
  Checklist = case maps:get(<<"verify_claims">>, Params)
              of
                true ->
                  maps:to_list(maps:get(<<"claims">>, Params, #{}));
                _ -> []
              end,
  {ok, SvrPid} = emqx_auth_jwt_svr:start_link(JwtSvrOpts),
  AuthEnv = #{pid => SvrPid,
    from =>
    binary_to_existing_atom(maps:get(<<"from">>, Params,
      <<"password">>),
      utf8),
    checklists => Checklist},
  load_auth_hook(AuthEnv),
  #{auth_env => AuthEnv}.

load_auth_hook(AuthEnv) ->
  emqx:hook('client.authenticate',
    fun emqx_auth_jwt:check/3, [AuthEnv]).

on_module_destroy(_ModId, State) ->
  case maps:get(auth_env, State, undefined) of
    undefined -> ok;
    #{pid := SvrPid} -> gen_server:stop(SvrPid)
  end,
  emqx:unhook('client.authenticate',
    fun emqx_auth_jwt:check/3).

on_module_status(_ModId, #{}) -> #{is_alive => true}.

on_module_update(_ModId, Params, Config, Config) ->
  Params;
on_module_update(ModId, Params, _OldConfig, Config) ->
  on_module_destroy(ModId, Params),
  on_module_create(ModId, Config).

b2l(B) when is_binary(B) -> binary_to_list(B).

