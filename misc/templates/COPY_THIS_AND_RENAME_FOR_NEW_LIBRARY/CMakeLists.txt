cmake_minimum_required(VERSION 3.14)

set(LibName INSERT_LIBRARY_NAME_HERE)
project(${LibName})

include(FetchContent)
FetchContent_Declare( al2o3 GIT_REPOSITORY https://github.com/DeanoC/al2o3 GIT_TAG master )
FetchContent_GetProperties(al2o3)
if(NOT al2o3_POPULATED)
	FetchContent_Populate(al2o3)
endif()
add_subdirectory(${al2o3_SOURCE_DIR})

set(Interface
		)
set(Src
		)
set(Deps
        al2o3_platform)
ADD_LIB(${LibName} "${Interface}" "${Src}" "${Deps}")

set( Tests
		)
set( TestDeps
		al203_catch2 )
ADD_LIB_TESTS(${LibName} "${Interface}" "${Tests}" "${TestDeps}")
