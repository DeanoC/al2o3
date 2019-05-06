MACRO(ADD_LIB LibName Headers Src Deps)
	set(_headers ${Headers})
	list(TRANSFORM _headers PREPEND include/${LibName}/ )

	set(_deps ${Deps})
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
	else()
		add_library( ${LibName} INTERFACE )
		foreach (_dep ${_deps})
			get_filename_component(deplibname ${_dep} NAME)
			FETCH_DEPENDENCY(${deplibname})
			target_link_libraries(${LibName} INTERFACE ${deplibname})
		endforeach ()

		target_include_directories( ${LibName}
				INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include )
	endif()
ENDMACRO()


