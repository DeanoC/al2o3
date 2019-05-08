# al2o3
al2o3 (Aluminium Oxide) is a distrubition of libraries for games. It designed to offer the simplicity of a package manager like Debians APT but for source code libraries and with minimal dependency. In fact its 7 lines to setup (cut and paste from below) and another 3 for a basic exe using libraries within the al2o3 framework.

Its based on CMake and github and relys on al2o3 basically being a curated list of libraries. Libraries are availible with C bindings, C++ bindings and coming soon rust binding. Swift is also another language waiting in the wings.

The actual libraries are pulled from many open source projects, with often thin interfaces to make them work well together and in the same style as each other.

Assuming you have a modern version of CMake, adding 

```
include(FetchContent)
FetchContent_Declare( al2o3 GIT_REPOSITORY https://github.com/DeanoC/al2o3 GIT_TAG master )
FetchContent_GetProperties(al2o3)
if(NOT al2o3_POPULATED)
	FetchContent_Populate(al2o3)
	add_subdirectory(${al2o3_SOURCE_DIR})
endif()

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
