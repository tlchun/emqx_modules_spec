%%%-------------------------------------------------------------------
%%% @author root
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 12月 2020 下午7:35
%%%-------------------------------------------------------------------
-module(emqx_module_auth_mongo).
-author("root").

-export([on_module_create/2, on_module_destroy/2,
  on_module_status/2, on_module_update/4]).

-module_type(#{create => on_module_create,
  description =>
  #{en =>
  <<77, 111, 110, 103, 111, 68, 66, 32, 65, 85, 84, 72,
    47, 65, 67, 76>>,
    zh =>
    <<77, 111, 110, 103, 111, 68, 66, 32, 232, 174, 164,
      232, 175, 129, 47, 232, 174, 191, 233, 151, 174, 230,
      142, 167, 229, 136, 182>>},
  destroy => on_module_destroy,
  name => mongo_authentication,
  params =>
  #{acl_query_collection =>
  #{default => <<109, 113, 116, 116, 95, 97, 99, 108>>,
    description =>
    #{en =>
    <<65, 99, 108, 32, 81, 117, 101, 114, 121,
      32, 67, 111, 108, 108, 101, 99, 116, 105,
      111, 110>>,
      zh =>
      <<232, 174, 191, 233, 151, 174, 230, 142,
        167, 229, 136, 182, 230, 159, 165, 232,
        175, 162, 233, 155, 134, 229, 144,
        136>>},
    order => 12, required => false,
    title =>
    #{en =>
    <<65, 99, 108, 32, 81, 117, 101, 114, 121,
      32, 67, 111, 108, 108, 101, 99, 116, 105,
      111, 110>>,
      zh =>
      <<232, 174, 191, 233, 151, 174, 230, 142,
        167, 229, 136, 182, 230, 159, 165, 232,
        175, 162, 233, 155, 134, 229, 144,
        136>>},
    type => string},
    acl_query_selectors =>
    #{default => #{},
      description =>
      #{en =>
      <<65, 99, 108, 32, 81, 117, 101, 114, 121,
        32, 83, 101, 108, 101, 99, 116, 111, 114,
        115>>,
        zh =>
        <<232, 174, 191, 233, 151, 174, 230, 142,
          167, 229, 136, 182, 230, 159, 165, 232,
          175, 162, 229, 143, 130, 230, 149,
          176>>},
      items =>
      #{schema =>
      #{acl_query_selector =>
      #{default =>
      <<117, 115, 101, 114, 110, 97,
        109, 101, 61, 37, 117>>,
        description =>
        #{en =>
        <<70, 105, 101, 108,
          100>>,
          zh =>
          <<230, 159, 165, 232,
            175, 162, 230, 157,
            161, 228, 187, 182,
            229, 173, 151, 230,
            174, 181>>},
        required => true,
        title =>
        #{en =>
        <<83, 101, 108, 101, 99,
          116, 111, 114, 32, 70,
          105, 101, 108, 100>>,
          zh =>
          <<230, 159, 165, 232,
            175, 162, 230, 157,
            161, 228, 187, 182,
            229, 173, 151, 230,
            174, 181>>},
        type => string}},
        type => object},
      order => 13, required => false,
      title =>
      #{en =>
      <<65, 99, 108, 32, 81, 117, 101, 114, 121,
        32, 83, 101, 108, 101, 99, 116, 111, 114,
        115>>,
        zh =>
        <<232, 174, 191, 233, 151, 174, 230, 142,
          167, 229, 136, 182, 230, 159, 165, 232,
          175, 162, 229, 143, 130, 230, 149,
          176>>},
      type => array},
    auth_query_collection =>
    #{default =>
    <<109, 113, 116, 116, 95, 117, 115, 101, 114>>,
      description =>
      #{en =>
      <<65, 117, 116, 104, 32, 81, 117, 101, 114,
        121, 32, 67, 111, 108, 108, 101, 99, 116,
        105, 111, 110>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 159,
          165, 232, 175, 162, 233, 155, 134, 229,
          144, 136>>},
      order => 9, required => false,
      title =>
      #{en =>
      <<65, 117, 116, 104, 32, 81, 117, 101, 114,
        121, 32, 67, 111, 108, 108, 101, 99, 116,
        105, 111, 110>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 159,
          165, 232, 175, 162, 233, 155, 134, 229,
          144, 136>>},
      type => string},
    auth_query_password_field =>
    #{default => <<112, 97, 115, 115, 119, 111, 114, 100>>,
      description =>
      #{en =>
      <<77, 113, 116, 116, 32, 65, 117, 116, 104,
        32, 70, 105, 101, 108, 100>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 159,
          165, 232, 175, 162, 229, 173, 151, 230,
          174, 181, 229, 144, 141, 44, 32, 229,
          164, 154, 228, 184, 170, 229, 173, 151,
          230, 174, 181, 228, 189, 191, 231, 148,
          168, 233, 128, 151, 229, 143, 183, 229,
          136, 134, 233, 154, 148>>},
      order => 10, required => false,
      title =>
      #{en =>
      <<77, 113, 116, 116, 32, 65, 117, 116, 104,
        32, 70, 105, 101, 108, 100>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 159,
          165, 232, 175, 162, 229, 173, 151, 230,
          174, 181, 229, 144, 141>>},
      type => string},
    auth_query_password_hash =>
    #{default => <<115, 104, 97, 50, 53, 54>>,
      description =>
      #{en =>
      <<80, 97, 115, 115, 119, 111, 114, 100, 32,
        72, 97, 115, 104>>,
        zh =>
        <<229, 175, 134, 231, 160, 129, 229, 138,
          160, 229, 175, 134, 230, 150, 185, 229,
          188, 143>>},
      enum =>
      [<<112, 108, 97, 105, 110>>, <<109, 100, 53>>,
        <<115, 104, 97>>, <<115, 104, 97, 50, 53, 54>>,
        <<115, 104, 97, 53, 49, 50>>,
        <<98, 99, 114, 121, 112, 116>>,
        <<115, 97, 108, 116, 44, 112, 108, 97, 105,
          110>>,
        <<112, 108, 97, 105, 110, 44, 115, 97, 108,
          116>>,
        <<115, 97, 108, 116, 44, 109, 100, 53>>,
        <<109, 100, 53, 44, 115, 97, 108, 116>>,
        <<115, 97, 108, 116, 44, 115, 104, 97>>,
        <<115, 104, 97, 44, 115, 97, 108, 116>>,
        <<115, 97, 108, 116, 44, 115, 104, 97, 50, 53,
          54>>,
        <<115, 104, 97, 50, 53, 54, 44, 115, 97, 108,
          116>>,
        <<115, 97, 108, 116, 44, 115, 104, 97, 53, 49,
          50>>,
        <<115, 104, 97, 53, 49, 50, 44, 115, 97, 108,
          116>>,
        <<115, 97, 108, 116, 44, 98, 99, 114, 121, 112,
          116>>,
        <<98, 99, 114, 121, 112, 116, 44, 115, 97, 108,
          116>>],
      order => 8, required => false,
      title =>
      #{en =>
      <<80, 97, 115, 115, 119, 111, 114, 100, 32,
        72, 97, 115, 104>>,
        zh =>
        <<229, 175, 134, 231, 160, 129, 229, 138,
          160, 229, 175, 134, 230, 150, 185, 229,
          188, 143>>},
      type => string},
    auth_query_selector =>
    #{default =>
    <<117, 115, 101, 114, 110, 97, 109, 101, 61, 37,
      117>>,
      description =>
      #{en =>
      <<65, 117, 116, 104, 32, 81, 117, 101, 114,
        121, 32, 83, 101, 108, 101, 99, 116, 111,
        114, 115>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 157,
          161, 228, 187, 182, 229, 173, 151, 230,
          174, 181>>},
      order => 11,
      title =>
      #{en =>
      <<65, 117, 116, 104, 32, 81, 117, 101, 114,
        121, 32, 83, 101, 108, 101, 99, 116, 111,
        114, 115>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 157,
          161, 228, 187, 182, 229, 173, 151, 230,
          174, 181>>},
      type => string},
    auth_source =>
    #{default => <<97, 100, 109, 105, 110>>,
      description =>
      #{en =>
      <<65, 117, 116, 104, 32, 83, 111, 117, 114,
        99, 101>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 186,
          144>>},
      order => 6,
      title =>
      #{en =>
      <<65, 117, 116, 104, 32, 83, 111, 117, 114,
        99, 101>>,
        zh =>
        <<232, 174, 164, 232, 175, 129, 230, 186,
          144>>},
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
      order => 22,
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
      order => 21,
      title =>
      #{en =>
      <<67, 101, 114, 116, 105, 102, 105, 99, 97,
        116, 101, 32, 70, 105, 108, 101>>,
        zh =>
        <<232, 175, 129, 228, 185, 166, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    database =>
    #{default => <<109, 113, 116, 116>>,
      description =>
      #{en => <<68, 97, 116, 97, 98, 97, 115, 101>>,
        zh =>
        <<230, 149, 176, 230, 141, 174, 229, 186,
          147, 229, 144, 141>>},
      order => 7, required => true,
      title =>
      #{en => <<68, 97, 116, 97, 98, 97, 115, 101>>,
        zh =>
        <<230, 149, 176, 230, 141, 174, 229, 186,
          147, 229, 144, 141>>},
      type => string},
    keyfile =>
    #{default => <<>>,
      description =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<83, 83, 76, 32, 231, 167, 129, 233, 146,
          165, 230, 150, 135, 228, 187, 182>>},
      order => 20,
      title =>
      #{en => <<75, 101, 121, 32, 70, 105, 108, 101>>,
        zh =>
        <<231, 167, 129, 233, 146, 165, 230, 150,
          135, 228, 187, 182>>},
      type => file},
    login =>
    #{default => <<>>,
      description =>
      #{en => <<85, 115, 101, 114, 110, 97, 109, 101>>,
        zh =>
        <<231, 148, 168, 230, 136, 183, 229, 144,
          141>>},
      order => 4, required => false,
      title =>
      #{en =>
      <<85, 115, 101, 114, 32, 78, 97, 109,
        101>>,
        zh =>
        <<231, 148, 168, 230, 136, 183, 229, 144,
          141>>},
      type => string},
    password =>
    #{default => <<>>,
      description =>
      #{en => <<80, 97, 115, 115, 119, 111, 114, 100>>,
        zh => <<229, 175, 134, 231, 160, 129>>},
      order => 5, required => false,
      title =>
      #{en => <<80, 97, 115, 115, 119, 111, 114, 100>>,
        zh => <<229, 175, 134, 231, 160, 129>>},
      type => password},
    pool_size =>
    #{default => 8,
      description =>
      #{en =>
      <<84, 104, 101, 32, 83, 105, 122, 101, 32,
        111, 102, 32, 67, 111, 110, 110, 101, 99,
        116, 105, 111, 110, 32, 80, 111, 111,
        108>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 177,
          160, 229, 164, 167, 229, 176, 143>>},
      order => 3,
      title =>
      #{en =>
      <<80, 111, 111, 108, 32, 83, 105, 122,
        101>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 177,
          160, 229, 164, 167, 229, 176, 143>>},
      type => number},
    r_mode =>
    #{default => <<117, 110, 100, 101, 102>>,
      description =>
      #{en =>
      <<82, 101, 97, 100, 32, 109, 111, 100,
        101>>,
        zh =>
        <<232, 175, 187, 230, 168, 161, 229, 188,
          143>>},
      enum =>
      [<<117, 110, 100, 101, 102>>,
        <<109, 97, 115, 116, 101, 114>>,
        <<115, 108, 97, 118, 101, 45, 111, 107>>],
      order => 18, required => false,
      title =>
      #{en =>
      <<82, 101, 97, 100, 32, 109, 111, 100,
        101>>,
        zh =>
        <<232, 175, 187, 230, 168, 161, 229, 188,
          143>>},
      type => string},
    server =>
    #{default =>
    <<49, 50, 55, 46, 48, 46, 48, 46, 49, 58, 50, 55,
      48, 49, 55>>,
      description =>
      #{en =>
      <<77, 111, 110, 103, 111, 68, 66, 32, 83,
        101, 114, 118, 101, 114, 32, 65, 100,
        100, 114, 101, 115, 115>>,
        zh =>
        <<77, 111, 110, 103, 111, 68, 66, 32, 230,
          156, 141, 229, 138, 161, 229, 153, 168,
          229, 156, 176, 229, 157, 128>>},
      order => 2, required => true,
      title =>
      #{en =>
      <<77, 111, 110, 103, 111, 68, 66, 32, 83,
        101, 114, 118, 101, 114>>,
        zh =>
        <<77, 111, 110, 103, 111, 68, 66, 32, 230,
          156, 141, 229, 138, 161, 229, 153,
          168>>},
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
      order => 19,
      title =>
      #{en =>
      <<69, 110, 97, 98, 108, 101, 32, 83, 83,
        76>>,
        zh =>
        <<229, 188, 128, 229, 144, 175, 32, 83, 83,
          76>>},
      type => boolean},
    super_query_collection =>
    #{default => <<>>,
      description =>
      #{en =>
      <<83, 117, 112, 101, 114, 32, 85, 115, 101,
        114, 32, 81, 117, 101, 114, 121, 32, 67,
        111, 108, 108, 101, 99, 116, 105, 111,
        110>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 230, 159, 165, 232,
          175, 162, 233, 155, 134, 229, 144,
          136>>},
      order => 14, required => false,
      title =>
      #{en =>
      <<83, 117, 112, 101, 114, 32, 85, 115, 101,
        114, 32, 81, 117, 101, 114, 121, 32, 67,
        111, 108, 108, 101, 99, 116, 105, 111,
        110>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 230, 159, 165, 232,
          175, 162, 233, 155, 134, 229, 144,
          136>>},
      type => string},
    super_query_field =>
    #{default => <<>>,
      description =>
      #{en =>
      <<83, 117, 112, 101, 114, 32, 85, 115, 101,
        114, 32, 81, 117, 101, 114, 121, 32, 70,
        105, 101, 108, 100>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 230, 159, 165, 232,
          175, 162, 229, 173, 151, 230, 174,
          181>>},
      order => 15, required => false,
      title =>
      #{en =>
      <<83, 117, 112, 101, 114, 32, 85, 115, 101,
        114, 32, 81, 117, 101, 114, 121, 32, 70,
        105, 101, 108, 100>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 230, 159, 165, 232,
          175, 162, 229, 173, 151, 230, 174,
          181>>},
      type => string},
    super_query_selector =>
    #{default => <<>>,
      description =>
      #{en =>
      <<83, 117, 112, 101, 114, 85, 115, 101,
        114, 32, 83, 101, 108, 101, 99, 116, 111,
        114, 32, 70, 105, 101, 108, 100>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 230, 159, 165, 232,
          175, 162, 230, 157, 161, 228, 187, 182,
          229, 173, 151, 230, 174, 181>>},
      order => 16,
      title =>
      #{en =>
      <<83, 117, 112, 101, 114, 85, 115, 101,
        114, 32, 83, 101, 108, 101, 99, 116, 111,
        114, 32, 70, 105, 101, 108, 100>>,
        zh =>
        <<232, 182, 133, 231, 186, 167, 231, 148,
          168, 230, 136, 183, 230, 159, 165, 232,
          175, 162, 230, 157, 161, 228, 187, 182,
          229, 173, 151, 230, 174, 181>>},
      type => string},
    type =>
    #{default => <<115, 105, 110, 103, 108, 101>>,
      description =>
      #{en => <<84, 121, 112, 101>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 168,
          161, 229, 188, 143>>},
      enum =>
      [<<115, 105, 110, 103, 108, 101>>,
        <<117, 110, 107, 110, 111, 119, 110>>,
        <<115, 104, 97, 114, 101, 100>>, <<114, 115>>],
      items =>
      #{rs =>
      #{topology_connect_timeout_ms =>
      #{default => <<50, 48, 115>>,
        description =>
        #{en =>
        <<84, 111, 112, 111, 108,
          111, 103, 121, 32, 67,
          111, 110, 110, 101, 99,
          116, 32, 116, 105, 109,
          101, 111, 117, 116, 40,
          109, 115, 41>>,
          zh =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 67,
            111, 110, 110, 101, 99,
            116, 32, 116, 105, 109,
            101, 111, 117, 116, 40,
            109, 115, 41>>},
        order => 6,
        title =>
        #{en =>
        <<84, 111, 112, 111, 108,
          111, 103, 121, 32, 67,
          111, 110, 110, 101, 99,
          116, 32, 116, 105, 109,
          101, 111, 117, 116, 40,
          109, 115, 41>>,
          zh =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 67,
            111, 110, 110, 101, 99,
            116, 32, 116, 105, 109,
            101, 111, 117, 116, 40,
            109, 115, 41>>},
        type => string},
        topology_heartbeat_frequency_ms =>
        #{default => <<49, 115>>,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 72,
            101, 97, 114, 116, 98,
            101, 97, 116, 32, 102,
            114, 101, 113, 117,
            101, 110, 99, 121, 40,
            109, 115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 72,
              101, 97, 114, 116, 98,
              101, 97, 116, 32, 102,
              114, 101, 113, 117,
              101, 110, 99, 121, 40,
              109, 115, 41>>},
          order => 10,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 72,
            101, 97, 114, 116, 98,
            101, 97, 116, 32, 102,
            114, 101, 113, 117,
            101, 110, 99, 121, 40,
            109, 115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 72,
              101, 97, 114, 116, 98,
              101, 97, 116, 32, 102,
              114, 101, 113, 117,
              101, 110, 99, 121, 40,
              109, 115, 41>>},
          type => string},
        topology_local_threshold_ms =>
        #{default => <<49, 115>>,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 76,
            111, 99, 97, 108, 32,
            84, 104, 114, 101, 115,
            104, 111, 108, 100, 32,
            84, 105, 109, 115, 40,
            109, 115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 76,
              111, 99, 97, 108, 32,
              84, 104, 114, 101, 115,
              104, 111, 108, 100, 32,
              84, 105, 109, 115, 40,
              109, 115, 41>>},
          order => 5,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 76,
            111, 99, 97, 108, 32,
            84, 104, 114, 101, 115,
            104, 111, 108, 100, 32,
            84, 105, 109, 115, 40,
            109, 115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 76,
              111, 99, 97, 108, 32,
              84, 104, 114, 101, 115,
              104, 111, 108, 100, 32,
              84, 105, 109, 115, 40,
              109, 115, 41>>},
          type => string},
        topology_max_overflow =>
        #{default => 0,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 77,
            97, 120, 32, 79, 118,
            101, 114, 102, 108,
            111, 119>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 77,
              97, 120, 32, 79, 118,
              101, 114, 102, 108,
              111, 119>>},
          order => 2,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 77,
            97, 120, 32, 79, 118,
            101, 114, 102, 108,
            111, 119>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 77,
              97, 120, 32, 79, 118,
              101, 114, 102, 108,
              111, 119>>},
          type => number},
        topology_min_heartbeat_frequency_ms =>
        #{default => <<49, 115>>,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 77,
            105, 110, 32, 72, 101,
            97, 114, 116, 98, 101,
            97, 116, 32, 70, 114,
            101, 113, 117, 101,
            110, 99, 121, 40, 109,
            115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 77,
              105, 110, 32, 72, 101,
              97, 114, 116, 98, 101,
              97, 116, 32, 70, 114,
              101, 113, 117, 101,
              110, 99, 121, 40, 109,
              115, 41>>},
          order => 11,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 77,
            105, 110, 32, 72, 101,
            97, 114, 116, 98, 101,
            97, 116, 32, 70, 114,
            101, 113, 117, 101,
            110, 99, 121, 40, 109,
            115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 77,
              105, 110, 32, 72, 101,
              97, 114, 116, 98, 101,
              97, 116, 32, 70, 114,
              101, 113, 117, 101,
              110, 99, 121, 40, 109,
              115, 41>>},
          type => string},
        topology_overflow_check_period =>
        #{default => <<49, 115>>,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 79,
            118, 101, 114, 102,
            108, 111, 119, 32, 67,
            104, 101, 99, 107, 32,
            80, 101, 114, 105, 111,
            100>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 79,
              118, 101, 114, 102,
              108, 111, 119, 32, 67,
              104, 101, 99, 107, 32,
              80, 101, 114, 105, 111,
              100>>},
          order => 4,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 79,
            118, 101, 114, 102,
            108, 111, 119, 32, 67,
            104, 101, 99, 107, 32,
            80, 101, 114, 105, 111,
            100>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 79,
              118, 101, 114, 102,
              108, 111, 119, 32, 67,
              104, 101, 99, 107, 32,
              80, 101, 114, 105, 111,
              100>>},
          type => string},
        topology_overflow_ttl =>
        #{default => <<49, 115>>,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 79,
            118, 101, 114, 102,
            108, 111, 119, 32, 84,
            84, 76>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 79,
              118, 101, 114, 102,
              108, 111, 119, 32, 84,
              84, 76>>},
          order => 3,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 79,
            118, 101, 114, 102,
            108, 111, 119, 32, 84,
            84, 76>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 79,
              118, 101, 114, 102,
              108, 111, 119, 32, 84,
              84, 76>>},
          type => string},
        topology_pool_size =>
        #{default => 1,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 80,
            111, 111, 108, 32, 83,
            105, 122, 101>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 80,
              111, 111, 108, 32, 83,
              105, 122, 101>>},
          order => 1,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 80,
            111, 111, 108, 32, 83,
            105, 122, 101>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 80,
              111, 111, 108, 32, 83,
              105, 122, 101>>},
          type => number},
        topology_server_selection_timeout_ms =>
        #{default => <<51, 48, 115>>,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 83,
            101, 114, 118, 101,
            114, 32, 83, 101, 108,
            101, 99, 116, 105, 111,
            110, 32, 84, 105, 109,
            101, 111, 117, 116, 40,
            109, 115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 83,
              101, 114, 118, 101,
              114, 32, 83, 101, 108,
              101, 99, 116, 105, 111,
              110, 32, 84, 105, 109,
              101, 111, 117, 116, 40,
              109, 115, 41>>},
          order => 8,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 83,
            101, 114, 118, 101,
            114, 32, 83, 101, 108,
            101, 99, 116, 105, 111,
            110, 32, 84, 105, 109,
            101, 111, 117, 116, 40,
            109, 115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 83,
              101, 114, 118, 101,
              114, 32, 83, 101, 108,
              101, 99, 116, 105, 111,
              110, 32, 84, 105, 109,
              101, 111, 117, 116, 40,
              109, 115, 41>>},
          type => string},
        topology_socket_timeout_ms =>
        #{default =>
        <<49, 48, 48, 109, 115>>,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 83,
            111, 99, 107, 101, 116,
            32, 116, 105, 109, 101,
            111, 117, 116, 40, 109,
            115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 83,
              111, 99, 107, 101, 116,
              32, 116, 105, 109, 101,
              111, 117, 116, 40, 109,
              115, 41>>},
          order => 7,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 83,
            111, 99, 107, 101, 116,
            32, 116, 105, 109, 101,
            111, 117, 116, 40, 109,
            115, 41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 83,
              111, 99, 107, 101, 116,
              32, 116, 105, 109, 101,
              111, 117, 116, 40, 109,
              115, 41>>},
          type => string},
        topology_wait_queue_timeout_ms =>
        #{default => <<49, 115>>,
          description =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 87,
            97, 105, 116, 32, 81,
            117, 101, 117, 101, 32,
            116, 105, 109, 111,
            117, 116, 40, 109, 115,
            41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 87,
              97, 105, 116, 32, 81,
              117, 101, 117, 101, 32,
              116, 105, 109, 111,
              117, 116, 40, 109, 115,
              41>>},
          order => 9,
          title =>
          #{en =>
          <<84, 111, 112, 111, 108,
            111, 103, 121, 32, 87,
            97, 105, 116, 32, 81,
            117, 101, 117, 101, 32,
            116, 105, 109, 111,
            117, 116, 40, 109, 115,
            41>>,
            zh =>
            <<84, 111, 112, 111, 108,
              111, 103, 121, 32, 87,
              97, 105, 116, 32, 81,
              117, 101, 117, 101, 32,
              116, 105, 109, 111,
              117, 116, 40, 109, 115,
              41>>},
          type => string}},
        shared =>
        #{rs_set_name =>
        #{default => <<>>,
          description =>
          #{en =>
          <<82, 101, 112, 108, 105,
            99, 97, 32, 83, 101,
            116>>,
            zh =>
            <<82, 101, 112, 108, 105,
              99, 97, 32, 83, 101,
              116>>},
          order => 1, required => true,
          title =>
          #{en =>
          <<82, 101, 112, 108, 105,
            99, 97, 32, 83, 101,
            116>>,
            zh =>
            <<82, 101, 112, 108, 105,
              99, 97, 32, 83, 101,
              116>>},
          type => string}},
        single => #{}, unknown => #{}},
      order => 1, required => true,
      title =>
      #{en => <<84, 121, 112, 101>>,
        zh =>
        <<232, 191, 158, 230, 142, 165, 230, 168,
          161, 229, 188, 143>>},
      type => cfgselect},
    w_mode =>
    #{default => <<117, 110, 100, 101, 102>>,
      description =>
      #{en =>
      <<87, 114, 105, 116, 101, 32, 109, 111,
        100, 101>>,
        zh =>
        <<229, 134, 153, 230, 168, 161, 229, 188,
          143>>},
      enum =>
      [<<117, 110, 100, 101, 102>>,
        <<115, 97, 102, 101>>,
        <<117, 110, 115, 97, 102, 101>>],
      order => 17, required => false,
      title =>
      #{en =>
      <<87, 114, 105, 116, 101, 32, 109, 111,
        100, 101>>,
        zh =>
        <<229, 134, 153, 230, 168, 161, 229, 188,
          143>>},
      type => string}},
  status => on_module_status,
  title =>
  #{en =>
  <<77, 111, 110, 103, 111, 68, 66, 32, 65, 85, 84, 72,
    47, 65, 67, 76>>,
    zh =>
    <<77, 111, 110, 103, 111, 68, 66, 32, 232, 174, 164,
      232, 175, 129, 47, 232, 174, 191, 233, 151, 174, 230,
      142, 167, 229, 136, 182>>},
  type => auth, update => on_module_update}).

-vsn("4.2.2").

on_module_create(ModuleId,
    #{<<"database">> := Database} = Params) ->
  _ = application:ensure_all_started(ecpool),
  _ = application:ensure_all_started(mongodb),
  WorkerOptions = get_worker_options(ModuleId, Params),
  TestOpts = [{database, Database}] ++
    host_port(hd(proplists:get_value(hosts,
      WorkerOptions))),
  {ok, _TestConn} = mc_worker_api:connect(TestOpts),
  PoolName =
    start_resource(emqx_module_utils:pool_name(emqx_module_auth_mongo,
      ModuleId),
      WorkerOptions),
  load_auth_hook(Params, PoolName),
  load_acl_hook(Params, PoolName),
  #{pool => PoolName}.

on_module_destroy(_ModuleId, #{pool := PoolName}) ->
  stop_resource(PoolName).

on_module_status(_ModuleId, #{}) -> #{is_alive => true}.

on_module_update(_ModuleId, Params, Config, Config) ->
  Params;
on_module_update(ModuleId, Params, _OldConfig,
    Config) ->
  on_module_destroy(ModuleId, Params),
  on_module_create(ModuleId, Config).

start_resource(PoolName, Options) ->
  {ok, _} = ecpool:start_sup_pool(PoolName,
    emqx_auth_mongo, Options),
  PoolName.

stop_resource(PoolName) ->
  emqx:unhook('client.authenticate',
    fun emqx_auth_mongo:check/3),
  emqx:unhook('client.check_acl',
    fun emqx_acl_mongo:check_acl/5),
  ecpool:stop_sup_pool(PoolName).

load_auth_hook(Params, PoolName) ->
  case maps:get(<<"auth_query_collection">>, Params, <<>>)
  of
    <<>> -> ok;
    Collection ->
      Superquery = case maps:get(<<"super_query_collection">>,
        Params, <<>>)
                   of
                     <<>> -> undefined;
                     SupperCollection ->
                       get_super_options(Params, SupperCollection)
                   end,
      Opts = #{pool => PoolName,
        authquery => get_auth_options(Params, Collection),
        superquery => Superquery},
      ok = emqx:hook('client.authenticate',
        fun emqx_auth_mongo:check/3, [Opts]),
      emqx_auth_mongo:register_metrics()
  end.

load_acl_hook(Params, PoolName) ->
  case maps:get(<<"acl_query_collection">>, Params, <<>>)
  of
    <<>> -> ok;
    Collection ->
      Opts = #{pool => PoolName,
        aclquery => get_acl_options(Params, Collection)},
      ok = emqx:hook('client.check_acl',
        fun emqx_acl_mongo:check_acl/5, [Opts]),
      emqx_acl_mongo:register_metrics()
  end.

get_worker_options(ModuleId, Params) ->
  Hosts = string:tokens(b2l(maps:get(<<"server">>, Params,
    <<"127.0.0.1:27017">>)),
    " ,"),
  PoolSize = maps:get(<<"pool">>, Params, 8),
  SslOpts = case maps:get(<<"ssl">>, Params, false) of
              true ->
                [{ssl, true},
                  {ssl_opts,
                    emqx_modules_untils:get_ssl_opts(Params, ModuleId)}];
              _ -> []
            end,
  Type = list_to_atom(b2l(maps:get(<<"type">>, Params,
    <<"single">>))),
  RsTypeOpts = case Type of
                 shared ->
                   {rs, maps:get(<<"rs_set_name">>, Params, <<"">>)};
                 _ -> Type
               end,
  WorkerOptions = worker_opts(Params) ++ SslOpts,
  [{type, RsTypeOpts}, {hosts, Hosts},
    {options, get_topology_opts(Params)},
    {worker_options, WorkerOptions}, {auto_reconnect, 1},
    {pool_size, PoolSize}].

get_auth_options(Params, Collection) ->
  {authquery, Collection,
    parse_fields(b2l(maps:get(<<"auth_query_password_field">>,
      Params, <<"password">>))),
    emqx_module_utils:password_hash(b2l(maps:get(<<"auth_query_password_hash">>,
      Params, <<"sha256">>))),
    parse_selector(maps:get(<<"auth_query_selector">>,
      Params, <<"username=%u">>))}.

get_acl_options(Params, Collection) ->
  Selectors = maps:get(<<"acl_query_selectors">>, Params,
    []),
  {aclquery, Collection,
    [parse_selector(maps:get(<<"acl_query_selector">>,
      Selector, <<"username=%u">>))
      || Selector <- Selectors]}.

get_super_options(Params, Collection) ->
  {superquery, Collection,
    maps:get(<<"super_query_field">>, Params,
      <<"is_superuser">>),
    parse_selector(maps:get(<<"super_query_selector">>,
      Params, <<"username=%u">>))}.

b2l(B) when is_binary(B) -> binary_to_list(B).

parse_selector(SelectorStr)
  when is_binary(SelectorStr) ->
  lists:map(fun (S) ->
    case string:tokens(S, " =") of
      [Field, Val] ->
        {list_to_binary(Field), list_to_binary(Val)};
      _ -> {<<"username">>, <<"%u">>}
    end
            end,
    string:tokens(binary_to_list(SelectorStr), " ,")).

parse_fields(L) when is_list(L) ->
  [erlang:list_to_binary(E)
    || E <- string:tokens(L, " ,")].

worker_opts(Params) -> worker_opts(Params, []).

worker_opts(Params = #{<<"login">> := <<>>}, Acc) ->
  worker_opts(maps:remove(<<"login">>, Params), Acc);
worker_opts(Params = #{<<"login">> := Login}, Acc) ->
  worker_opts(maps:remove(<<"login">>, Params),
    [{login, Login} | Acc]);
worker_opts(Params = #{<<"password">> := <<>>}, Acc) ->
  worker_opts(maps:remove(<<"password">>, Params), Acc);
worker_opts(Params = #{<<"password">> := Passwd},
    Acc) ->
  worker_opts(maps:remove(<<"password">>, Params),
    [{password, Passwd} | Acc]);
worker_opts(Params = #{<<"w_mode">> := WMode}, Acc) ->
  worker_opts(maps:remove(<<"w_mode">>, Params),
    [{w_mode, b2a(WMode)} | Acc]);
worker_opts(Params = #{<<"r_mode">> := RMode}, Acc) ->
  worker_opts(maps:remove(<<"r_mode">>, Params),
    [{r_mode, b2a(RMode)} | Acc]);
worker_opts(Params = #{<<"database">> := DB}, Acc) ->
  worker_opts(maps:remove(<<"database">>, Params),
    [{database, DB} | Acc]);
worker_opts(Params = #{<<"auth_source">> := AuthSource},
    Acc) ->
  worker_opts(maps:remove(<<"auth_source">>, Params),
    [{auth_source, AuthSource} | Acc]);
worker_opts(_Params, Acc) -> Acc.

get_topology_opts(Params) ->
  get_topology_opts(Params, []).

get_topology_opts(Params =
  #{<<"topology_local_threshold_ms">> := V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_local_threshold_ms">>,
    Params),
    [{localThresholdMS, emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params =
  #{<<"topology_min_heartbeat_frequency_ms">> := V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_min_heartbeat_frequency_ms">>,
    Params),
    [{connectTimeoutMS, emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params =
  #{<<"topology_socket_timeout_ms">> := V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_socket_timeout_ms">>,
    Params),
    [{socketTimeoutMS, emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params =
  #{<<"topology_connect_timeout_ms">> := V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_connect_timeout_ms">>,
    Params),
    [{serverSelectionTimeoutMS,
      emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params =
  #{<<"topology_heartbeat_frequency_ms">> := V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_heartbeat_frequency_ms">>,
    Params),
    [{waitQueueTimeoutMS,
      emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params =
  #{<<"topology_server_selection_timeout_ms">> := V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_server_selection_timeout_ms">>,
    Params),
    [{heartbeatFrequencyMS,
      emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params =
  #{<<"topology_wait_queue_timeout_ms">> := V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_wait_queue_timeout_ms">>,
    Params),
    [{minHeartbeatFrequencyMS,
      emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params = #{<<"topology_overflow_ttl">>
:= V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_overflow_ttl">>,
    Params),
    [{overflow_ttl, emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params =
  #{<<"topology_overflow_check_period">> := V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_overflow_check_period">>,
    Params),
    [{overflow_check_period,
      emqx_module_utils:parse_timeout(V)}
      | Acc]);
get_topology_opts(Params = #{<<"topology_max_overflow">>
:= V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_max_overflow">>,
    Params),
    [{max_overflow, V} | Acc]);
get_topology_opts(Params = #{<<"topology_pool_size">> :=
V},
    Acc) ->
  get_topology_opts(maps:remove(<<"topology_pool_size">>,
    Params),
    [{pool_size, V} | Acc]);
get_topology_opts(_Params, Acc) -> Acc.

b2a(B) -> binary_to_atom(B, utf8).

host_port(HostPort) ->
  case string:split(HostPort, ":") of
    [Host, Port] ->
      {ok, Host1} = inet:parse_address(Host),
      [{host, Host1}, {port, list_to_integer(Port)}];
    [Host] ->
      {ok, Host1} = inet:parse_address(Host), [{host, Host1}]
  end.
