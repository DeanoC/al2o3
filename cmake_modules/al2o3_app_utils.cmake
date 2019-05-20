

MACRO(ADD_CONSOLE_APP AppName Src Deps)
	set(_src ${Src})
	set(_deps ${Deps} )
	add_executable(${AppName} ${_src})
	target_link_libraries(${AppName} PRIVATE ${LibName})
	foreach (_dep ${_deps})
		get_filename_component(deplibname ${_dep} NAME)
		FETCH_DEPENDENCY(${deplibname})
		target_link_libraries(${AppName} PRIVATE ${deplibname})
	endforeach ()

	if (APPLE)
		target_link_libraries(${AppName} PRIVATE stdc++ "-framework Foundation" "-framework Cocoa" objc)
	endif ()
ENDMACRO()

MACRO(ADD_GUI_APP AppName Src Deps)
	set(_src ${Src})
	set(_deps ${Deps} )

	if(APPLE)
		list(APPEND _src ${LIB_BASE_PATH}/level0/guishell/src/apple/appdelegate.h)
		list(APPEND _src ${LIB_BASE_PATH}/level0/guishell/src/apple/appdelegate.m)
		list(APPEND _src ${LIB_BASE_PATH}/level0/guishell/src/apple/macresources/MainMenu.nib)
	endif()

	add_executable(${AppName}  WIN32 MACOSX_BUNDLE ${_src})
	target_link_libraries(${AppName} ${LibName} core guishell)
	foreach (_dep ${_deps})
		get_filename_component(deplibname ${_dep} NAME)
		target_link_libraries(${AppName} ${deplibname})
	endforeach ()
	if(APPLE)
		set_target_properties(${AppName} PROPERTIES
				MACOSX_BUNDLE_GUI_IDENTIFIER com.wryd.${AppName}
				MACOSX_BUNDLE_INFO_PLIST ${LIB_BASE_PATH}/level0/guishell/src/apple/macresources/Info.plist.in
				RESOURCE ${LIB_BASE_PATH}/level0/guishell/src/apple/macresources/MainMenu.nib
				)
	endif()

ENDMACRO()
