FILE_GLOB_DIRS_ONLY(LIBS .)

include(fetchdeclare_cmakelists.txt)

foreach(LIB ${LIBS})
	add_subdirectory(${LIB})
endforeach()