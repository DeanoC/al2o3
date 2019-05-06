MACRO(FILE_GLOB_DIRS_ONLY result dir)

	file(GLOB _all LIST_DIRECTORIES true RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/${dir} CONFIGURE_DEPENDS * )
	file(GLOB _files LIST_DIRECTORIES false RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/${dir} * )

	set(${result} ${_all})

	list(LENGTH _files _filelen)

	if(_filelen)
		list(REMOVE_ITEM ${result} ${_files})
	endif()

ENDMACRO()
