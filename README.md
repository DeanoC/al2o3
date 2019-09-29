# al2o3
al2o3 (Aluminium Oxide) is a distrubition of libraries for games. It designed to offer the simplicity of a package manager like Debians APT but for source code libraries with minimal friction to you the user of a particular library. A short boot strap peices of CMAKE (below) hooks your cmake up to the al2o3 distrubition. There you can easily add a depedency on any of the libraries it supports and it will download, compile, link and setup paths to the public interfaces for you.

Its based on CMake (min 3.12.4) uses github (any git repo really) and relys on al2o3 basically being a curated list of libraries. Libraries are availible with C bindings, a few C++ bindings and coming soon rust bindings. Swift is also another language waiting in the wings. The none C bindings are at the bottom end of long list of things to do but will happen.

Theres a github project page https://github.com/users/DeanoC/projects/1

The actual libraries are pulled from many open source projects, with often thin interfaces to make them work well together and in the same style as each other.

The libraries supported are in the fetchdeclare_cmakelist.txt files. Yes I need to a lists and docs etc.

Assuming you have a modern version of CMake, adding 

```
get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
	option(unittests "unittests" OFF)
	get_filename_component(_PARENT_DIR ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)
	set_property(GLOBAL PROPERTY GLOBAL_FETCHDEPS_BASE ${_PARENT_DIR}/al2o3 )
	include(FetchContent)
	FetchContent_Declare( al2o3 GIT_REPOSITORY https://github.com/DeanoC/al2o3 GIT_TAG master )
	FetchContent_GetProperties(al2o3)
	if(NOT al2o3_POPULATED)
		FetchContent_Populate(al2o3)
		add_subdirectory(${al2o3_SOURCE_DIR} ${al2o3_BINARY_DIR})
	endif()
	INIT_AL2O3(${CMAKE_CURRENT_SOURCE_DIR})
endif ()
````
will set it up ready to go, then 

```
set(Src main.c)
set(Deps al2o3_platform)
ADD_CONSOLE_APP(appname "${Src}" "${Deps}")
```
would add a console application using the al2o3_platform library. You can also add you own target dependency in the same list. If you 
don't want to use the `ADD_CONSOLE_APP` macro, its pretty easy to use the al2o3 libraries yourself via something like

```
FETCH_DEPENDENCY(al2o3_platform)
target_link_libraries(appname al2o3_platform)
```
