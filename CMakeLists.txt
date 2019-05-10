cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
include (FetchContent)

option(FETCH_CMAKE_UTILS_FROM_REPO "Fetch the cmake_utils takes some time, default it to use interal copy" 0)

if(${FETCH_CMAKE_UTILS_FROM_REPO})
	include (cmake_modules/download_module.cmake)
	download_project(
			PROJ al2o3_cmake_utils
			GIT_REPOSITORY https://github.com/DeanoC/al2o3_cmake_utils
			GIT_TAG master
	)
	set( al2o3_cmake_modules ${al2o3_cmake_utils_SOURCE_DIR})
else()
	set( al2o3_cmake_modules ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules)
endif()

set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${al2o3_cmake_modules})

include (al2o3_fetch_utils)
include (al2o3_app_utils)
include (al2o3_dir_utils)
include (al2o3_lib_utils)
include (al2o3_test_utils)

include (base/fetchdeclare_cmakelists.txt)
