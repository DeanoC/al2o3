set(CMAKE_CXX_STANDARD 14)
set(CMAKE_C_STANDARD 11)
FILE_GLOB_DIRS_ONLY(APPS .)

foreach(APP ${APPS})
    add_subdirectory(${APP})
endforeach()