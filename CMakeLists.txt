cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

include (FetchContent)
include (cmake_modules/download_module.cmake)

option(FETCH_CMAKE_UTILS_FROM_REPO "Fetch the cmake_utils takes some time, default it to use interal copy" 0)

if(${FETCH_CMAKE_UTILS_FROM_REPO})
	download_project(
			PROJ al2o3_cmake_utils
			GIT_REPOSITORY https://github.com/DeanoC/al2o3_cmake_utils
			GIT_TAG master
	)
	set( al2o3_cmake_modules ${al2o3_cmake_utils_SOURCE_DIR})
else()
	set( al2o3_cmake_modules ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules)
endif()

include (${al2o3_cmake_modules}/fetch_utils.cmake)
include (${al2o3_cmake_modules}/app_utils.cmake)
include (${al2o3_cmake_modules}/dir_utils.cmake)
include (${al2o3_cmake_modules}/lib_utils.cmake)
include (${al2o3_cmake_modules}/test_utils.cmake)

option(BUILD_TESTS "Build Test executubles" ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/out_libs)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/out_bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/out_bin)

set(LIB_BASE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/libs/)
#set(APP_BASE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/apps/)

add_subdirectory(src)