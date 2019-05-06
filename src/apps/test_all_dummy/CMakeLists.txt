set(AppName test_all_dummy)
project(${AppName})

set(Src
        dummy.c
        )

set(Deps
        al2o3_platform
        al2o3_catch2
        al2o3_tinystl
        )

ADD_CONSOLE_APP(${AppName} "${Src}" "${Deps}")
