%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:38
%%%-------------------------------------------------------------------
-module(emqx_module_retainer).
-author("root").

-export([on_module_create/2, on_module_destroy/2,
  on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<77, 81, 84, 84, 32, 82, 101, 116, 97, 105, 110, 101,
    114>>,
    zh =>
    <<77, 81, 84, 84, 32, 228, 191, 157, 231, 149, 153,
      230, 182, 136, 230, 129, 175>>},
  destroy => on_module_destroy, name => retainer,
  params =>
  #{expiry_interval =>
  #{default => 0,
    description =>
    #{en =>
    <<69, 120, 112, 105, 114, 121, 32, 105,
      110, 116, 101, 114, 118, 97, 108, 32,
      111, 102, 32, 116, 104, 101, 32, 114,
      101, 116, 97, 105, 110, 101, 100, 32,
      109, 101, 115, 115, 97, 103, 101, 115,
      46, 32, 78, 101, 118, 101, 114, 32, 101,
      120, 112, 105, 114, 101, 32, 105, 102,
      32, 116, 104, 101, 32, 118, 97, 108, 117,
      101, 32, 105, 115, 32, 48, 46>>,
      zh =>
      <<228, 191, 157, 231, 149, 153, 230, 182,
        136, 230, 129, 175, 231, 154, 132, 230,
        156, 137, 230, 149, 136, 230, 156, 159,
        233, 153, 144, 44, 32, 229, 166, 130,
        230, 158, 156, 229, 128, 188, 228, 184,
        186, 48, 44, 32, 229, 136, 153, 230, 176,
        184, 228, 184, 141, 232, 191, 135, 230,
        156, 159>>},
    order => 4,
    title =>
    #{en =>
    <<69, 120, 112, 105, 114, 121, 32, 73, 110,
      116, 101, 114, 118, 97, 108>>,
      zh =>
      <<230, 156, 137, 230, 149, 136, 230, 156,
        159, 233, 153, 144>>},
    type => nember},
    max_payload_size =>
    #{default => <<49, 77, 66>>,
      description =>
      #{en =>
      <<77, 97, 120, 105, 109, 117, 109, 32, 114,
        101, 116, 97, 105, 110, 101, 100, 32,
        109, 101, 115, 115, 97, 103, 101, 32,
        115, 105, 122, 101>>,
        zh =>
        <<230, 156, 128, 229, 164, 167, 228, 191,
          157, 231, 149, 153, 230, 182, 136, 230,
          129, 175, 229, 164, 167, 229, 176,
          143>>},
      order => 3,
      title =>
      #{en =>
      <<83, 116, 111, 114, 97, 103, 101, 32, 84,
        121, 112, 101>>,
        zh =>
        <<230, 156, 128, 229, 164, 167, 228, 191,
          157, 231, 149, 153, 230, 182, 136, 230,
          129, 175, 229, 164, 167, 229, 176,
          143>>},
      type => string},
    max_retained_messages =>
    #{default => 0,
      description =>
      #{en =>
      <<77, 97, 120, 105, 109, 117, 109, 32, 110,
        117, 109, 98, 101, 114, 32, 111, 102, 32,
        114, 101, 116, 97, 105, 110, 101, 100,
        32, 109, 101, 115, 115, 97, 103, 101,
        115, 46, 32, 48, 32, 109, 101, 97, 110,
        115, 32, 110, 111, 32, 108, 105, 109,
        105, 116>>,
        zh =>
        <<230, 156, 128, 229, 164, 167, 228, 191,
          157, 231, 149, 153, 230, 182, 136, 230,
          129, 175, 230, 149, 176, 44, 32, 48, 232,
          161, 168, 231, 164, 186, 230, 178, 161,
          230, 156, 137, 233, 153, 144, 229, 136,
          182>>},
      order => 2,
      title =>
      #{en =>
      <<77, 97, 120, 32, 82, 101, 116, 97, 105,
        110, 101, 114, 32, 77, 115, 103>>,
        zh =>
        <<230, 156, 128, 229, 164, 167, 228, 191,
          157, 231, 149, 153, 230, 182, 136, 230,
          129, 175, 230, 149, 176>>},
      type => number},
    storage_type =>
    #{default => <<114, 97, 109>>,
      description =>
      #{en =>
      <<82, 101, 116, 97, 105, 110, 101, 114, 32,
        77, 101, 115, 115, 97, 103, 101, 32, 83,
        116, 111, 114, 97, 103, 101, 32, 84, 121,
        112, 101>>,
        zh =>
        <<228, 191, 157, 231, 149, 153, 230, 182,
          136, 230, 129, 175, 229, 173, 152, 229,
          130, 168, 231, 177, 187, 229, 158,
          139>>},
      enum =>
      [<<114, 97, 109>>, <<100, 105, 115, 99>>,
        <<100, 105, 115, 99, 95, 111, 110, 108, 121>>],
      order => 1,
      title =>
      #{en =>
      <<83, 116, 111, 114, 97, 103, 101, 32, 84,
        121, 112, 101>>,
        zh =>
        <<229, 173, 152, 229, 130, 168, 231, 177,
          187, 229, 158, 139>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<77, 81, 84, 84, 32, 82, 101, 116, 97, 105, 110, 101,
    114>>,
    zh =>
    <<77, 81, 84, 84, 32, 228, 191, 157, 231, 149, 153,
      230, 182, 136, 230, 129, 175>>},
  type => module, update => on_module_update}).

-vsn("4.2.2").

on_module_create(_ModuleId,
    #{<<"storage_type">> := StorageType,
      <<"max_retained_messages">> := MaxRetainedMessages,
      <<"max_payload_size">> := MaxPayloadSize,
      <<"expiry_interval">> := ExpiryInterval}) ->
  Env = [{storage_type, b2a(StorageType)},
    {max_retained_messages, MaxRetainedMessages},
    {max_payload_size,
      cuttlefish_bytesize:parse(binary_to_list(MaxPayloadSize))},
    {expiry_interval, ExpiryInterval}],
  emqx_modules_sup:start_child(emqx_retainer, worker,
    Env),
  emqx_retainer:load(Env),
  emqx_retainer_cli:load(),
  #{}.

on_module_destroy(_ModuleId, _Params) ->
  emqx_retainer:unload(),
  emqx_retainer_cli:unload(),
  emqx_modules_sup:stop_child(emqx_retainer),
  ok.

on_module_status(_ModuleId, _Params) ->
  #{is_alive => true}.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

b2a(B) when is_binary(B) ->
  list_to_atom(binary_to_list(B)).
