%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:37
%%%-------------------------------------------------------------------
-module(emqx_module_proto_lwm2m).
-author("root").

-include("../include/emqx_module_spec_listener.hrl").

-export([on_module_create/2, on_module_destroy/2,
  on_module_update/4, on_module_status/2]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<69, 77, 81, 32, 88, 32, 76, 119, 77, 50, 77, 32, 71,
    97, 116, 101, 119, 97, 121>>,
    zh =>
    <<69, 77, 81, 32, 88, 32, 76, 119, 77, 50, 77, 32, 230,
      142, 165, 229, 133, 165, 231, 189, 145, 229, 133,
      179>>},
  destroy => on_module_destroy, name => lwm2m_protocol,
  params =>
  #{auto_observe =>
  #{default => false,
    description => #{en => <<>>, zh => <<>>}, order => 4,
    required => false,
    title =>
    #{en =>
    <<65, 117, 116, 111, 32, 79, 98, 115, 101,
      114, 118, 101>>,
      zh =>
      <<232, 135, 170, 229, 138, 168, 32, 79, 98,
        115, 101, 114, 118, 101>>},
    type => boolean},
    command_topic =>
    #{default => <<100, 110, 47, 35>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 116, 111, 112, 105, 99,
        32, 115, 117, 98, 115, 99, 114, 105, 98,
        101, 100, 32, 98, 121, 32, 116, 104, 101,
        32, 108, 119, 109, 50, 109, 32, 99, 108,
        105, 101, 110, 116, 32, 97, 102, 116,
        101, 114, 32, 105, 116, 32, 105, 115, 32,
        99, 111, 110, 110, 101, 99, 116, 101,
        100>>,
        zh =>
        <<228, 184, 139, 232, 161, 140, 230, 142,
          167, 229, 136, 182, 229, 145, 189, 228,
          187, 164, 228, 184, 187, 233, 162, 152,
          239, 188, 140, 76, 119, 77, 50, 77, 32,
          229, 174, 162, 230, 136, 183, 231, 171,
          175, 232, 191, 158, 230, 142, 165, 229,
          144, 142, 228, 188, 154, 232, 135, 170,
          229, 138, 168, 232, 174, 162, 233, 152,
          133, 232, 175, 165, 228, 184, 187, 233,
          162, 152>>},
      order => 6, required => true,
      title =>
      #{en =>
      <<67, 111, 109, 109, 97, 110, 100, 32, 84,
        111, 112, 105, 99>>,
        zh =>
        <<228, 184, 139, 232, 161, 140, 229, 145,
          189, 228, 187, 164, 228, 184, 187, 233,
          162, 152>>},
      type => string},
    lifetime_max =>
    #{default => 864000,
      description => #{en => <<>>, zh => <<>>}, order => 2,
      required => true,
      title =>
      #{en =>
      <<77, 97, 120, 105, 110, 117, 109, 32, 76,
        105, 102, 101, 116, 105, 109, 101>>,
        zh =>
        <<230, 156, 128, 229, 164, 167, 229, 191,
          131, 232, 183, 179, 230, 151, 182, 233,
          151, 180>>},
      type => number},
    lifetime_min =>
    #{default => 1,
      description => #{en => <<>>, zh => <<>>}, order => 1,
      required => true,
      title =>
      #{en =>
      <<77, 105, 110, 105, 109, 117, 109, 32, 76,
        105, 102, 101, 116, 105, 109, 101>>,
        zh =>
        <<230, 156, 128, 229, 176, 143, 229, 191,
          131, 232, 183, 179, 230, 151, 182, 233,
          151, 180>>},
      type => number},
    listener =>
    #{common =>
    #{acceptors =>
    #{default => 8,
      description =>
      #{en =>
      <<84, 104, 101, 32, 110, 117,
        109, 98, 101, 114, 32, 111,
        102, 32, 97, 99, 99, 101,
        111, 112, 116, 111, 114, 115,
        44, 32, 73, 116, 32, 106,
        117, 115, 116, 32, 119, 111,
        114, 107, 115, 32, 102, 111,
        114, 32, 84, 67, 80, 47, 83,
        83, 76, 47, 68, 84, 76, 83,
        32, 115, 111, 99, 107, 101,
        116>>,
        zh =>
        <<230, 142, 165, 230, 148, 182,
          229, 153, 168, 230, 149, 176,
          233, 135, 143, 239, 188, 140,
          230, 137, 167, 232, 161, 140,
          32, 97, 99, 99, 101, 112,
          116, 32, 230, 147, 141, 228,
          189, 156, 231, 154, 132, 232,
          191, 155, 231, 168, 139, 230,
          149, 176, 233, 135, 143, 239,
          188, 140, 228, 187, 133, 229,
          175, 185, 32, 84, 67, 80, 47,
          83, 83, 76, 47, 68, 84, 76,
          83, 32, 83, 111, 99, 107,
          101, 116, 32, 230, 156, 137,
          230, 149, 136>>},
      order => 1, required => true,
      title =>
      #{en =>
      <<65, 99, 99, 101, 112, 116,
        111, 114, 115>>,
        zh =>
        <<230, 142, 165, 230, 148, 182,
          229, 153, 168, 230, 149, 176,
          233, 135, 143>>},
      type => number},
      active_n =>
      #{default => 100,
        description =>
        #{en =>
        <<83, 112, 101, 99, 105, 102,
          121, 32, 116, 104, 101, 32,
          123, 97, 99, 116, 105, 118,
          101, 44, 32, 78, 125, 32,
          111, 112, 116, 105, 111, 110,
          32, 102, 111, 114, 32, 116,
          104, 101, 32, 83, 111, 99,
          107, 101, 116>>,
          zh =>
          <<232, 174, 190, 231, 189, 174,
            32, 83, 111, 99, 107, 101,
            116, 32, 231, 154, 132, 32,
            123, 97, 99, 116, 105, 118,
            101, 44, 32, 78, 125, 32,
            233, 128, 137, 233, 161,
            185>>},
        order => 2, required => true,
        title =>
        #{en =>
        <<65, 99, 116, 105, 118, 101,
          78>>,
          zh =>
          <<65, 99, 116, 105, 118, 101,
            78>>},
        type => number},
      max_conn_rate =>
      #{default => 1000,
        description =>
        #{en =>
        <<65, 108, 108, 111, 119, 101,
          100, 32, 99, 111, 110, 110,
          101, 99, 116, 105, 111, 110,
          115, 32, 112, 101, 114, 32,
          115, 101, 99, 111, 110,
          100>>,
          zh =>
          <<232, 175, 165, 231, 155, 145,
            229, 144, 172, 229, 153, 168,
            230, 175, 143, 231, 167, 146,
            229, 133, 129, 232, 174, 184,
            231, 154, 132, 230, 156, 128,
            229, 164, 167, 232, 191, 158,
            230, 142, 165, 228, 184, 170,
            230, 149, 176>>},
        order => 3, required => false,
        title =>
        #{en =>
        <<77, 97, 120, 32, 67, 111,
          110, 110, 101, 99, 116, 105,
          111, 110, 32, 82, 97, 116,
          101>>,
          zh =>
          <<230, 156, 128, 229, 164, 167,
            232, 191, 158, 230, 142, 165,
            233, 128, 159, 231, 142,
            135>>},
        type => number},
      max_connections =>
      #{default => 1000000,
        description =>
        #{en =>
        <<84, 104, 101, 32, 109, 97,
          120, 105, 109, 117, 109, 32,
          99, 111, 110, 110, 101, 99,
          116, 105, 111, 110, 115, 32,
          111, 102, 32, 108, 105, 115,
          116, 101, 110, 101, 114>>,
          zh =>
          <<232, 175, 165, 231, 155, 145,
            229, 144, 172, 229, 153, 168,
            229, 133, 129, 232, 174, 184,
            231, 154, 132, 230, 156, 128,
            229, 164, 167, 232, 191, 158,
            230, 142, 165, 230, 149,
            176>>},
        order => 4, required => false,
        title =>
        #{en =>
        <<77, 97, 120, 32, 67, 111,
          110, 110, 101, 99, 116, 105,
          111, 110, 115>>,
          zh =>
          <<230, 156, 128, 229, 164, 167,
            232, 191, 158, 230, 142, 165,
            230, 149, 176>>},
        type => number},
      proxy_protocol =>
      #{default => false,
        description =>
        #{en =>
        <<69, 110, 97, 98, 108, 101,
          32, 116, 104, 101, 32, 80,
          114, 111, 120, 121, 32, 80,
          114, 111, 116, 111, 99, 111,
          108, 32, 86, 49, 47, 50, 32,
          105, 102, 32, 116, 104, 101,
          32, 69, 77, 81, 32, 88, 32,
          99, 108, 117, 115, 116, 101,
          114, 32, 105, 115, 32, 100,
          101, 112, 108, 111, 121, 101,
          100, 32, 98, 101, 104, 105,
          110, 100, 32, 72, 65, 80,
          114, 111, 120, 121, 32, 111,
          114, 32, 78, 103, 105, 110,
          120>>,
          zh =>
          <<229, 188, 128, 229, 144, 175,
            32, 80, 114, 111, 120, 121,
            32, 80, 114, 111, 116, 111,
            99, 111, 108, 32, 86, 49, 47,
            50, 239, 188, 140, 229, 166,
            130, 230, 158, 156, 32, 69,
            77, 81, 32, 88, 32, 233, 155,
            134, 231, 190, 164, 233, 131,
            168, 231, 189, 178, 229, 156,
            168, 32, 72, 65, 80, 114,
            111, 120, 121, 32, 230, 136,
            150, 32, 78, 103, 105, 110,
            120, 32, 229, 144, 142>>},
        order => 5, required => false,
        title =>
        #{en =>
        <<80, 114, 111, 120, 121, 32,
          80, 114, 111, 116, 111, 99,
          111, 108>>,
          zh =>
          <<229, 188, 128, 229, 144, 175,
            32, 80, 114, 111, 120, 121,
            32, 80, 114, 111, 116, 111,
            99, 111, 108>>},
        type => boolean},
      proxy_protocol_timeout =>
      #{default => 3000,
        description =>
        #{en =>
        <<84, 104, 101, 32, 116, 105,
          109, 101, 111, 117, 116, 32,
          102, 111, 114, 32, 97, 99,
          99, 101, 112, 116, 105, 110,
          103, 32, 112, 114, 111, 120,
          121, 32, 112, 114, 111, 116,
          111, 99, 111, 108, 44, 32,
          69, 77, 81, 32, 88, 32, 119,
          105, 108, 108, 32, 99, 108,
          111, 115, 101, 32, 116, 104,
          101, 32, 84, 67, 80, 32, 99,
          111, 110, 110, 101, 99, 116,
          105, 111, 110, 32, 105, 102,
          32, 110, 111, 32, 112, 114,
          111, 120, 121, 32, 112, 114,
          111, 116, 111, 99, 111, 108,
          32, 112, 97, 99, 107, 101,
          116, 32, 114, 101, 99, 101,
          118, 105, 101, 100, 32, 119,
          105, 116, 104, 105, 110, 32,
          116, 104, 101, 32, 116, 105,
          109, 101, 111, 117, 116>>,
          zh =>
          <<229, 164, 132, 231, 144, 134,
            32, 80, 114, 111, 120, 121,
            32, 80, 114, 111, 116, 111,
            99, 111, 108, 32, 231, 154,
            132, 232, 182, 133, 230, 151,
            182, 230, 151, 182, 233, 151,
            180, 239, 188, 140, 229, 166,
            130, 230, 158, 156, 232, 182,
            133, 232, 191, 135, 232, 175,
            165, 230, 151, 182, 233, 151,
            180, 230, 156, 170, 230, 148,
            182, 229, 136, 176, 32, 80,
            114, 111, 120, 121, 32, 80,
            114, 111, 116, 111, 99, 111,
            108, 32, 231, 154, 132, 230,
            138, 165, 230, 150, 135, 239,
            188, 140, 69, 77, 81, 32, 88,
            32, 229, 176, 134, 229, 133,
            179, 233, 151, 173, 232, 175,
            165, 32, 84, 67, 80, 32, 232,
            191, 158, 230, 142, 165>>},
        order => 6, required => false,
        title =>
        #{en =>
        <<80, 114, 111, 120, 121, 32,
          80, 114, 111, 116, 111, 99,
          111, 108, 32, 84, 105, 109,
          101, 111, 117, 116>>,
          zh =>
          <<80, 114, 111, 120, 121, 32,
            80, 114, 111, 116, 111, 99,
            111, 108, 32, 229, 164, 132,
            231, 144, 134, 232, 182, 133,
            230, 151, 182, 230, 151, 182,
            233, 151, 180>>},
        type => number},
      recbuf =>
      #{default => 2048,
        description =>
        #{en =>
        <<84, 104, 101, 32, 114, 101,
          99, 101, 105, 118, 101, 32,
          98, 117, 102, 102, 101, 114,
          32, 111, 102, 32, 115, 111,
          99, 107, 101, 116, 32, 40,
          111, 115, 32, 107, 101, 114,
          110, 101, 108, 41>>,
          zh =>
          <<83, 111, 99, 107, 101, 116,
            32, 230, 142, 165, 230, 148,
            182, 231, 188, 147, 229, 134,
            178, 229, 140, 186, 229, 164,
            167, 229, 176, 143, 32, 40,
            230, 147, 141, 228, 189, 156,
            231, 179, 187, 231, 187, 159,
            229, 134, 133, 230, 160, 184,
            231, 186, 167, 41>>},
        order => 8, required => false,
        title =>
        #{en =>
        <<82, 101, 99, 101, 105, 118,
          101, 32, 66, 117, 102, 102,
          101, 114>>,
          zh =>
          <<230, 142, 165, 230, 148, 182,
            231, 188, 147, 229, 134, 178,
            229, 140, 186>>},
        type => number},
      reuseaddr =>
      #{default => true,
        description =>
        #{en =>
        <<84, 104, 101, 32, 83, 79, 95,
          82, 69, 85, 83, 69, 65, 68,
          68, 82, 32, 102, 108, 97,
          103, 32, 102, 111, 114, 32,
          108, 105, 115, 116, 101, 110,
          101, 114>>,
          zh =>
          <<232, 174, 190, 231, 189, 174,
            32, 83, 111, 99, 107, 101,
            116, 32, 231, 154, 132, 32,
            83, 79, 95, 82, 69, 85, 83,
            69, 65, 68, 68, 82, 32, 230,
            160, 135, 232, 175, 134>>},
        order => 9, required => false,
        title =>
        #{en =>
        <<83, 79, 95, 82, 69, 85, 83,
          69, 65, 68, 68, 82, 32, 70,
          108, 97, 103>>,
          zh =>
          <<83, 79, 95, 82, 69, 85, 83,
            69, 65, 68, 68, 82, 32, 230,
            160, 135, 232, 175, 134>>},
        type => boolean},
      sndbuf =>
      #{default => 2048,
        description =>
        #{en =>
        <<84, 104, 101, 32, 115, 101,
          110, 100, 32, 98, 117, 102,
          102, 101, 114, 32, 111, 102,
          32, 115, 111, 99, 107, 101,
          116, 32, 40, 111, 115, 32,
          107, 101, 114, 110, 101, 108,
          41>>,
          zh =>
          <<83, 111, 99, 107, 101, 116,
            32, 229, 143, 145, 233, 128,
            129, 231, 188, 147, 229, 134,
            178, 229, 140, 186, 229, 164,
            167, 229, 176, 143, 32, 40,
            230, 147, 141, 228, 189, 156,
            231, 179, 187, 231, 187, 159,
            229, 134, 133, 230, 160, 184,
            231, 186, 167, 41>>},
        order => 7, required => false,
        title =>
        #{en =>
        <<83, 101, 110, 100, 32, 66,
          117, 102, 102, 101, 114>>,
          zh =>
          <<229, 143, 145, 233, 128, 129,
            231, 188, 147, 229, 134, 178,
            229, 140, 186>>},
        type => number}},
      dtls_options =>
      #{cacertfile =>
      #{default => <<>>,
        description =>
        #{en =>
        <<84, 104, 101, 32, 67, 65, 32,
          99, 101, 114, 116, 105, 102,
          105, 99, 97, 116, 101, 32,
          102, 105, 108, 101, 32, 112,
          97, 116, 104>>,
          zh =>
          <<67, 65, 32, 232, 175, 129,
            228, 185, 166, 230, 150, 135,
            228, 187, 182, 232, 183, 175,
            229, 190, 132>>},
        order => 6, required => false,
        title =>
        #{en =>
        <<67, 65, 32, 67, 101, 114,
          116, 102, 105, 108, 101>>,
          zh =>
          <<67, 65, 32, 232, 175, 129,
            228, 185, 166, 230, 150, 135,
            228, 187, 182>>},
        type => file},
        certfile =>
        #{default => <<>>,
          description =>
          #{en =>
          <<84, 104, 101, 32, 99, 101,
            114, 116, 105, 102, 105, 99,
            97, 116, 101, 32, 102, 105,
            108, 101, 32, 112, 97, 116,
            104>>,
            zh =>
            <<232, 175, 129, 228, 185, 166,
              232, 183, 175, 229, 190,
              132>>},
          order => 4, required => false,
          title =>
          #{en =>
          <<67, 101, 114, 116, 102, 105,
            108, 101>>,
            zh =>
            <<232, 175, 129, 228, 185, 166,
              230, 150, 135, 228, 187,
              182>>},
          type => file},
        ciphers =>
        #{default =>
        <<100, 101, 102, 97, 117, 108, 116>>,
          description => #{en => <<>>, zh => <<>>},
          enum =>
          [<<100, 101, 102, 97, 117, 108,
            116>>,
            <<112, 115, 107>>],
          order => 2, required => true,
          title =>
          #{en =>
          <<67, 105, 112, 104, 101, 114,
            115>>,
            zh =>
            <<229, 138, 160, 229, 175, 134,
              229, 165, 151, 228, 187,
              182>>},
          type => string},
        fail_if_no_peer_cert =>
        #{default => false,
          description => #{en => <<>>, zh => <<>>},
          order => 7, required => false,
          title =>
          #{en =>
          <<102, 97, 105, 108, 95, 105,
            102, 95, 110, 111, 95, 112,
            101, 101, 114, 95, 99, 101,
            114, 116>>,
            zh =>
            <<229, 133, 179, 233, 151, 173,
              230, 151, 160, 232, 175, 129,
              228, 185, 166, 229, 174, 162,
              230, 136, 183, 231, 171, 175,
              232, 191, 158, 230, 142,
              165>>},
          type => boolean},
        keyfile =>
        #{default => <<>>,
          description =>
          #{en =>
          <<84, 104, 101, 32, 75, 101,
            121, 32, 102, 105, 108, 101,
            32, 112, 97, 116, 104>>,
            zh =>
            <<231, 167, 152, 233, 146, 165,
              230, 150, 135, 228, 187, 182,
              232, 183, 175, 229, 190,
              132>>},
          order => 5, required => false,
          title =>
          #{en =>
          <<75, 101, 121, 102, 105, 108,
            101>>,
            zh =>
            <<229, 175, 134, 233, 146, 165,
              230, 150, 135, 228, 187,
              182>>},
          type => file},
        verify =>
        #{default =>
        <<118, 101, 114, 105, 102, 121, 95,
          110, 111, 110, 101>>,
          description => #{en => <<>>, zh => <<>>},
          enum =>
          [<<118, 101, 114, 105, 102, 121, 95,
            110, 111, 110, 101>>,
            <<118, 101, 114, 105, 102, 121, 95,
              112, 101, 101, 114>>],
          order => 3, required => true,
          title =>
          #{en =>
          <<86, 101, 114, 105, 102,
            121>>,
            zh =>
            <<230, 160, 161, 233, 170, 140,
              231, 177, 187, 229, 158,
              139>>},
          type => string},
        versions =>
        #{default =>
        <<100, 116, 108, 115, 118, 49, 46,
          50, 44, 100, 116, 108, 115, 118,
          49>>,
          description => #{en => <<>>, zh => <<>>},
          enum =>
          [<<100, 116, 108, 115, 118, 49, 46,
            50, 44, 100, 116, 108, 115, 118,
            49>>,
            <<100, 116, 108, 115, 118, 49, 46,
              50>>,
            <<100, 116, 108, 115, 118, 49>>],
          order => 1, required => true,
          title =>
          #{en =>
          <<68, 84, 76, 83, 32, 86, 101,
            114, 115, 105, 111, 110>>,
            zh =>
            <<68, 84, 76, 83, 32, 229, 141,
              143, 232, 174, 174, 231, 137,
              136, 230, 156, 172>>},
          type => string}},
      protocol =>
      #{listen_on =>
      #{default =>
      <<48, 46, 48, 46, 48, 46, 48, 58, 53,
        54, 56, 51>>,
        description => #{en => <<>>, zh => <<>>},
        order => 1, required => true,
        title =>
        #{en =>
        <<76, 105, 115, 116, 101, 110,
          101, 114>>,
          zh =>
          <<231, 155, 145, 229, 144, 172,
            229, 156, 176, 229, 157,
            128>>},
        type => string},
        listener_type =>
        #{default => <<117, 100, 112>>,
          description => #{en => <<>>, zh => <<>>},
          enum =>
          [<<117, 100, 112>>,
            <<100, 116, 108, 115>>],
          order => 2, required => true,
          title =>
          #{en =>
          <<76, 105, 115, 116, 101, 110,
            101, 114, 32, 84, 121, 112,
            101>>,
            zh =>
            <<231, 155, 145, 229, 144, 172,
              231, 177, 187, 229, 158,
              139>>},
          type => string}},
      udp_options => #{}},
    mountpoint =>
    #{default =>
    <<108, 119, 109, 50, 109, 47, 37, 101, 47>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 109, 111, 117, 110,
        116, 112, 105, 110, 116, 32, 102, 111,
        114, 32, 99, 108, 105, 101, 110, 116, 32,
        115, 117, 98, 115, 99, 114, 105, 98, 101,
        100, 32, 116, 111, 112, 105, 99>>,
        zh =>
        <<229, 174, 162, 230, 136, 183, 231, 171,
          175, 228, 184, 187, 233, 162, 152, 231,
          154, 132, 230, 140, 130, 232, 189, 189,
          231, 130, 185>>},
      order => 5, required => true,
      title =>
      #{en =>
      <<77, 111, 117, 110, 116, 112, 111, 105,
        110, 116>>,
        zh =>
        <<230, 140, 130, 232, 189, 189, 231, 130,
          185>>},
      type => string},
    notify_topic =>
    #{default =>
    <<117, 112, 47, 110, 111, 116, 105, 102, 121>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 116, 111, 112, 105, 99,
        32, 116, 111, 32, 119, 104, 105, 99, 104,
        32, 116, 104, 101, 32, 108, 119, 109, 50,
        109, 32, 99, 108, 105, 101, 110, 116, 39,
        115, 32, 110, 111, 116, 105, 102, 121,
        32, 105, 115, 32, 112, 117, 98, 108, 105,
        115, 104, 101, 100>>,
        zh =>
        <<228, 184, 138, 232, 161, 140, 233, 128,
          154, 231, 159, 165, 228, 184, 187, 233,
          162, 152, 239, 188, 140, 76, 119, 77, 50,
          77, 32, 229, 174, 162, 230, 136, 183,
          231, 171, 175, 232, 191, 158, 230, 142,
          165, 229, 144, 142, 228, 188, 154, 232,
          135, 170, 229, 138, 168, 232, 174, 162,
          233, 152, 133, 232, 175, 165, 228, 184,
          187, 233, 162, 152>>},
      order => 8, required => true,
      title =>
      #{en =>
      <<78, 111, 116, 105, 102, 121, 32, 84, 111,
        112, 105, 99>>,
        zh =>
        <<228, 184, 138, 232, 161, 140, 233, 128,
          154, 231, 159, 165, 228, 184, 187, 233,
          162, 152>>},
      type => string},
    qmode_time_window =>
    #{default => 22,
      description => #{en => <<>>, zh => <<>>}, order => 3,
      required => true,
      title =>
      #{en =>
      <<81, 77, 111, 100, 101, 32, 84, 105, 109,
        101, 32, 87, 105, 110, 100, 111, 119>>,
        zh =>
        <<81, 77, 111, 100, 101, 32, 231, 170, 151,
          229, 143, 163>>},
      type => number},
    register_topic =>
    #{default => <<117, 112, 47, 114, 101, 115, 112>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 116, 111, 112, 105, 99,
        32, 116, 111, 32, 119, 104, 105, 99, 104,
        32, 116, 104, 101, 32, 108, 119, 109, 50,
        109, 32, 99, 108, 105, 101, 110, 116, 39,
        115, 32, 114, 101, 103, 105, 115, 116,
        101, 114, 32, 105, 115, 32, 112, 117, 98,
        108, 105, 115, 104, 101, 100>>,
        zh =>
        <<230, 179, 168, 229, 134, 140, 230, 182,
          136, 230, 129, 175, 228, 184, 187, 233,
          162, 152, 239, 188, 140, 76, 119, 77, 50,
          77, 32, 229, 174, 162, 230, 136, 183,
          231, 171, 175, 232, 191, 158, 230, 142,
          165, 229, 144, 142, 228, 188, 154, 232,
          135, 170, 229, 138, 168, 232, 174, 162,
          233, 152, 133, 232, 175, 165, 228, 184,
          187, 233, 162, 152>>},
      order => 8, required => true,
      title =>
      #{en =>
      <<82, 101, 103, 105, 115, 116, 101, 114,
        32, 84, 111, 112, 105, 99>>,
        zh =>
        <<230, 179, 168, 229, 134, 140, 230, 182,
          136, 230, 129, 175, 228, 184, 187, 233,
          162, 152>>},
      type => string},
    response_topic =>
    #{default => <<117, 112, 47, 114, 101, 115, 112>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 116, 111, 112, 105, 99,
        32, 116, 111, 32, 119, 104, 105, 99, 104,
        32, 116, 104, 101, 32, 108, 119, 109, 50,
        109, 32, 99, 108, 105, 101, 110, 116, 39,
        115, 32, 114, 101, 115, 112, 111, 110,
        115, 101, 32, 105, 115, 32, 112, 117, 98,
        108, 105, 115, 104, 101, 100>>,
        zh =>
        <<228, 184, 138, 232, 161, 140, 229, 186,
          148, 231, 173, 148, 228, 184, 187, 233,
          162, 152, 239, 188, 140, 76, 119, 77, 50,
          77, 32, 229, 174, 162, 230, 136, 183,
          231, 171, 175, 232, 191, 158, 230, 142,
          165, 229, 144, 142, 228, 188, 154, 232,
          135, 170, 229, 138, 168, 232, 174, 162,
          233, 152, 133, 232, 175, 165, 228, 184,
          187, 233, 162, 152>>},
      order => 7, required => true,
      title =>
      #{en =>
      <<82, 101, 115, 112, 111, 110, 115, 101,
        32, 84, 111, 112, 105, 99>>,
        zh =>
        <<228, 184, 138, 232, 161, 140, 229, 186,
          148, 231, 173, 148, 228, 184, 187, 233,
          162, 152>>},
      type => string},
    update_topic =>
    #{default => <<117, 112, 47, 114, 101, 115, 112>>,
      description =>
      #{en =>
      <<84, 104, 101, 32, 116, 111, 112, 105, 99,
        32, 116, 111, 32, 119, 104, 105, 99, 104,
        32, 116, 104, 101, 32, 108, 119, 109, 50,
        109, 32, 99, 108, 105, 101, 110, 116, 39,
        115, 32, 117, 112, 100, 97, 116, 101, 32,
        105, 115, 32, 112, 117, 98, 108, 105,
        115, 104, 101, 100>>,
        zh =>
        <<230, 155, 180, 230, 150, 176, 230, 182,
          136, 230, 129, 175, 228, 184, 187, 233,
          162, 152, 239, 188, 140, 76, 119, 77, 50,
          77, 32, 229, 174, 162, 230, 136, 183,
          231, 171, 175, 232, 191, 158, 230, 142,
          165, 229, 144, 142, 228, 188, 154, 232,
          135, 170, 229, 138, 168, 232, 174, 162,
          233, 152, 133, 232, 175, 165, 228, 184,
          187, 233, 162, 152>>},
      order => 9, required => true,
      title =>
      #{en =>
      <<85, 112, 100, 97, 116, 101, 32, 84, 111,
        112, 105, 99>>,
        zh =>
        <<230, 155, 180, 230, 150, 176, 230, 182,
          136, 230, 129, 175, 228, 184, 187, 233,
          162, 152>>},
      type => string},
    xml_dir =>
    #{default =>
    <<101, 116, 99, 47, 108, 119, 109, 50, 109, 95,
      120, 109, 108>>,
      description =>
      #{en =>
      <<68, 105, 114, 101, 99, 116, 111, 114,
        121, 32, 119, 104, 101, 114, 101, 32,
        116, 104, 101, 32, 111, 98, 106, 101, 99,
        116, 32, 100, 101, 102, 105, 110, 105,
        116, 105, 111, 110, 32, 102, 105, 108,
        101, 115, 32, 99, 97, 110, 32, 98, 101,
        32, 102, 111, 117, 110, 100>>,
        zh =>
        <<229, 175, 185, 232, 177, 161, 229, 174,
          154, 228, 185, 137, 231, 154, 132, 32,
          88, 77, 76, 32, 230, 150, 135, 228, 187,
          182, 232, 183, 175, 229, 190, 132>>},
      order => 10, required => true,
      title =>
      #{en =>
      <<88, 77, 76, 32, 68, 105, 114, 101, 99,
        116, 111, 114, 121>>,
        zh =>
        <<88, 77, 76, 32, 230, 150, 135, 228, 187,
          182, 232, 183, 175, 229, 190, 132>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<76, 119, 77, 50, 77, 32, 71, 97, 116, 101, 119, 97,
    121>>,
    zh =>
    <<76, 119, 77, 50, 77, 32, 230, 142, 165, 229, 133,
      165, 231, 189, 145, 229, 133, 179>>},
  type => protocol, update => on_module_update}).

on_module_create(ModId, Config) ->
  _ = application:ensure_all_started(lwm2m_coap),
  ListenerCfgs =
    emqx_module_utils:parse_proto_option(ModId, Config),
  emqx_modules_sup:start_child(emqx_lwm2m_cm_sup,
    supervisor),
  application:set_env(emqx_lwm2m, xml_dir,
    binary_to_list(maps:get(<<"xml_dir">>, Config))),
  emqx_modules_sup:start_child(emqx_lwm2m_xml_object_db,
    worker),
  lwm2m_coap_server:start_registry(),
  lwm2m_coap_server_registry:add_handler([<<"rd">>],
    emqx_lwm2m_coap_resource, undefined),
  Listeners = lists:map(fun ({Proto, ListenOn,
    Options}) ->
    emqx_lwm2m_coap_server:start_listener({Proto,
      ListenOn,
      Options}),
    {Proto, ListenOn}
                        end,
    ListenerCfgs),
  #{listeners => Listeners}.

on_module_destroy(_ModId, #{listeners := Listeners}) ->
  lwm2m_coap_server_registry:remove_handler([<<"rd">>],
    emqx_lwm2m_coap_resource,
    undefined),
  [begin
     emqx_lwm2m_coap_server:stop_listener({Proto, ListenOn,
       []})
   end
    || {Proto, ListenOn} <- Listeners],
  ok.

on_module_update(_ModId, State, Config, Config) ->
  State;
on_module_update(ModId, State, _OldConfig, Config) ->
  on_module_destroy(ModId, State),
  on_module_create(ModId, Config).

on_module_status(_ModId, #{listeners := Listeners}) ->
  Names = [listener_name(Proto, ListenOn)
    || {Proto, ListenOn} <- Listeners],
  case [ListenerName
    || {ListenerName, _} <- esockd:listeners(),
    lists:member(ListenerName, Names)]
  of
    [] -> #{is_alive => false};
    [_ | _] -> #{is_alive => true}
  end.

listener_name(udp, ListenOn) -> {'lwm2m:udp', ListenOn};
listener_name(dtls, ListenOn) ->
  {'lwm2m:dtls', ListenOn}.


