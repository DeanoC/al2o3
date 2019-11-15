MACRO(ADD_LINK_TIME_INTERFACE LibName Headers Deps)
	set(_headers ${Headers})
	list(TRANSFORM _headers PREPEND include/${LibName}/ )

	set(_deps ${Deps})

	add_library( ${LibName}_interface INTERFACE )
	foreach (_dep ${_deps})
		get_filename_component(deplibname ${_dep} NAME)
		FETCH_DEPENDENCY(${deplibname})
		target_link_libraries(${LibName}_interface INTERFACE ${deplibname})
	endforeach ()

	target_include_directories( ${LibName}_interface
			INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include )
	if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)
		configure_file(${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
				${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${LibName}_LICENSE COPYONLY)
	endif()
ENDMACRO()

MACRO(ADD_LINK_TIME_IMPL BaseName ImplName Headers Src Deps)
	set(_headers ${Headers})
	set(Libname ${BaseName}_impl_${ImplName})

	list(TRANSFORM _headers PREPEND include/${BaseName}/${ImplName}/ )

	set(_deps ${Deps} ${BaseName}_interface)
	set(_srcs ${Src})

	if(DEFINED _srcs)
		list(LENGTH _srcs _SrcLength)
	endif()

	if(_SrcLength)
		list(TRANSFORM _srcs PREPEND src/ )
		add_library( ${LibName} ${_srcs} ${_headers} )
		foreach (_dep ${_deps})
			get_filename_component(deplibname ${_dep} NAME)
			FETCH_DEPENDENCY(${deplibname})
			target_link_libraries(${LibName} PUBLIC ${deplibname})
		endforeach ()

		target_include_directories( ${LibName}
				PUBLIC
				${CMAKE_CURRENT_SOURCE_DIR}/include
				PRIVATE
				${CMAKE_CURRENT_SOURCE_DIR}/src )
		if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)
			configure_file(${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
					${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${LibName}_LICENSE COPYONLY)
		endif()
	else()
		add_library( ${LibName} INTERFACE )
		foreach (_dep ${_deps})
			get_filename_component(deplibname ${_dep} NAME)
			FETCH_DEPENDENCY(${deplibname})
			target_link_libraries(${LibName} INTERFACE ${deplibname})
		endforeach ()

		target_include_directories( ${LibName}
				INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include )
		if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)
			configure_file(${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
					${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${LibName}_LICENSE COPYONLY)
		endif()
	endif()
ENDMACRO()

MACRO(ADD_LINK_TIME_INTERFACE2 LibName Headers Deps)
	set(_headers ${Headers})

	set(_deps ${Deps})

	add_library( ${LibName}_interface INTERFACE )
	foreach (_dep ${_deps})
		get_filename_component(deplibname ${_dep} NAME)
		FETCH_DEPENDENCY(${deplibname})
		target_link_libraries(${LibName}_interface INTERFACE ${deplibname})
	endforeach ()

	target_include_directories( ${LibName}_interface
			INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include )

	if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)
		configure_file(${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
				${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${LibName}_LICENSE COPYONLY)
	endif()

ENDMACRO()

MACRO(ADD_LINK_TIME_IMPL2 BaseName ImplName Src Deps)
	set(_headers ${Headers})
	set(Libname ${BaseName}_impl_${ImplName})

	set(_deps ${Deps} ${BaseName}_interface)
	set(_srcs ${Src})

	if(DEFINED _srcs)
		list(LENGTH _srcs _SrcLength)
	endif()

	set(_absResources "")
	if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/resources)
		file(GLOB_RECURSE _absResources CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/resources/*)
	endif()

	add_library( ${LibName} ${_srcs} ${_absResources} )
	foreach (_dep ${_deps})
		get_filename_component(deplibname ${_dep} NAME)
		FETCH_DEPENDENCY(${deplibname})
		target_link_libraries(${LibName} PUBLIC ${deplibname})
	endforeach ()

	target_include_directories( ${LibName}
			PUBLIC
			${CMAKE_CURRENT_SOURCE_DIR}/include
			PRIVATE
			${CMAKE_CURRENT_SOURCE_DIR}/src )

	if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)
		configure_file(${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
				${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${LibName}_LICENSE COPYONLY)
	endif()

	if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/resources)
		foreach(_absResource ${_absResources})
			file(RELATIVE_PATH _relResource ${CMAKE_CURRENT_SOURCE_DIR}/resources/ ${_absResource})
			file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/resources/${_relResource} DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/)
		endforeach()
	endif()

ENDMACRO()
