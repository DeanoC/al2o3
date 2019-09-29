

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
	set_target_properties(${AppName} 
		PROPERTIES
			RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} )


	if (APPLE)
		target_link_libraries(${AppName} PRIVATE stdc++ "-framework Foundation" "-framework Cocoa" objc)
	endif ()
ENDMACRO()

MACRO(ADD_GUI_APP AppName Src Deps ShellInterface)
	set(_src ${Src})
	set(_deps ${Deps} )
	add_executable(${AppName} WIN32 MACOSX_BUNDLE ${_src} ${_headers})
	target_link_libraries(${AppName} PRIVATE ${LibName})
	foreach (_dep ${_deps})
		get_filename_component(deplibname ${_dep} NAME)
		FETCH_DEPENDENCY(${deplibname})
		target_link_libraries(${AppName} PRIVATE ${deplibname})
	endforeach ()
	set_target_properties(${AppName} 
		PROPERTIES
			RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} )

	if (APPLE)
		if( NOT "Info.plist.in" IN_LIST Src)
			configure_file(${${ShellInterface}_SOURCE_DIR}/default_macresources/Info.plist.in
					${CMAKE_CURRENT_BINARY_DIR}/Info.plist.in COPYONLY)
		endif()
		set(_src_mainmenu_xib ${${ShellInterface}_SOURCE_DIR}/default_macresources/MainMenu.xib)

		if(  "MainMenu.xib" IN_LIST Tests)
			set(_src_mainmenu_xib ${CMAKE_CURRENT_SOURCE_DIR}/Src/MainMenu.xib)
		endif()
		target_sources(${AppName} PRIVATE MainMenu.nib)

		add_custom_command(
				OUTPUT MainMenu.nib
				COMMAND ${IBTOOL} --output-format binary1 --compile MainMenu.nib ${_src_mainmenu_xib}
		)

		if( NOT "appdelegate.h" IN_LIST Tests)
			target_sources(${AppName} PRIVATE ${${ShellInterface}_SOURCE_DIR}/default_macresources/appdelegate.h)
			target_sources(${AppName} PRIVATE ${${ShellInterface}_SOURCE_DIR}/default_macresources/appdelegate.m)
		endif()
		target_link_libraries(${AppName} PRIVATE stdc++ "-framework Foundation" "-framework Cocoa" objc)
		set_target_properties(${AppName} PROPERTIES
				MACOSX_BUNDLE_GUI_IDENTIFIER com.al2o3.${AppName}
				MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_BINARY_DIR}/Info.plist.in
				RESOURCE MainMenu.nib
				)
	endif()
ENDMACRO()
