project(catch2)
set(LibName catch2)

set(Interface
		catch2.hpp
		)
set(Src
		)

FetchContent_MakeAvailable(al2o3_platform)

download_project(
		PROJ CatchOrg_Catch2
		GIT_REPOSITORY https://github.com/catchorg/Catch2
		GIT_TAG master
)
set(Deps
		al2o3_platform
		)

ADD_LIB(${LibName} "${Interface}" "${Src}" "${Deps}")
target_include_directories(${LibName} INTERFACE ${CatchOrg_Catch2_SOURCE_DIR})

set( Tests
		runner.cpp
		)
set( TestDeps
		)
ADD_LIB_TESTS(${LibName} "${Interface}" "${Tests}" "${TestDeps}")
