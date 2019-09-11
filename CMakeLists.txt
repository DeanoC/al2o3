include (FetchContent)

set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules)

include(al2o3_utils)
include(al2o3_fetch_utils)
include(al2o3_app_utils)
include(al2o3_dir_utils)
include(al2o3_lib_utils)
include(al2o3_test_utils)
include(al2o3_linktimeinterface)

# include the library lists
include(base_fetchdeclare_cmakelists.txt)
include(utils_fetchdeclare_cmakelists.txt)
include(data_fetchdeclare_cmakelists.txt)
include(gfx_fetchdeclare_cmakelists.txt)
include(input_fetchdeclare_cmakelists.txt)
include(lua_fetchdeclare_cmakelists.txt)
include(render_fetchdeclare_cmakelists.txt)
include(physics_fetchdeclare_cmakelists.txt)
