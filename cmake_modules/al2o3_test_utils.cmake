MACRO(ADD_LIB_TESTS LibName Headers Tests Deps)
	get_property(_build_tests GLOBAL PROPERTY GLOBAL_BUILD_TESTS)
	if(_build_tests)
		set(_headers ${Headers})
		list(TRANSFORM _headers PREPEND include/${LibName}/ )

		set(_tests ${Tests})
		set(_deps ${Deps} )

		if (DEFINED _tests)
			list(LENGTH _tests _TestsLength)
		endif ()
		if (_TestsLength)
			list(TRANSFORM _tests PREPEND tests/)
			add_executable(test_${LibName} ${_tests} ${_headers})
			foreach (_dep ${_deps})
				get_filename_component(deplibname ${_dep} NAME)
				FETCH_DEPENDENCY(${deplibname})
				target_link_libraries(test_${LibName} PRIVATE ${deplibname})
			endforeach ()
			target_link_libraries(test_${LibName} PRIVATE ${LibName})
			target_include_directories(test_${LibName} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/tests)
			if (APPLE)
				target_link_libraries(test_${LibName} PRIVATE stdc++ "-framework Foundation" "-framework Cocoa" objc)
			endif ()
		endif ()
	endif()
ENDMACRO()

MACRO(ADD_LIB_GUITESTS LibName Headers Tests Deps ShellInterface)
	if(BUILD_TESTS)
		set(_headers ${Headers})
		list(TRANSFORM _headers PREPEND include/${LibName}/ )

		set(_tests ${Tests})
		set(_deps ${Deps} )

		if (DEFINED _tests)
			list(LENGTH _tests _TestsLength)
		endif ()
		if (_TestsLength)
			list(TRANSFORM _tests PREPEND tests/)
			add_executable(test_${LibName} WIN32 MACOSX_BUNDLE ${_tests} ${_headers})
			foreach (_dep ${_deps})
				get_filename_component(deplibname ${_dep} NAME)
				FETCH_DEPENDENCY(${deplibname})
				target_link_libraries(test_${LibName} PRIVATE ${deplibname})
			endforeach ()
			target_link_libraries(test_${LibName} PRIVATE ${LibName})
			target_include_directories(test_${LibName} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/tests)
			if (APPLE)
				if( NOT "Info.plist.in" IN_LIST Tests)
					configure_file(${${ShellInterface}_SOURCE_DIR}/default_macresources/Info.plist.in
							${CMAKE_CURRENT_BINARY_DIR}/Info.plist.in COPYONLY)
				endif()
				set(_src_mainmenu_xib ${${ShellInterface}_SOURCE_DIR}/default_macresources/MainMenu.xib)

				if(  "MainMenu.xib" IN_LIST Tests)
					set(_src_mainmenu_xib ${CMAKE_CURRENT_SOURCE_DIR}/Src/MainMenu.xib)
				endif()
				target_sources(test_${LibName} PRIVATE MainMenu.nib)

				add_custom_command(
						OUTPUT MainMenu.nib
						COMMAND ${IBTOOL} --output-format binary1 --compile MainMenu.nib ${_src_mainmenu_xib}
				)

				if( NOT "appdelegate.h" IN_LIST Tests)
					target_sources(test_${LibName} PRIVATE ${${ShellInterface}_SOURCE_DIR}/default_macresources/appdelegate.h)
					target_sources(test_${LibName} PRIVATE ${${ShellInterface}_SOURCE_DIR}/default_macresources/appdelegate.m)
				endif()
				target_link_libraries(test_${LibName} PRIVATE stdc++ "-framework Foundation" "-framework Cocoa" objc)
				set_target_properties(test_${LibName} PROPERTIES
						MACOSX_BUNDLE_GUI_IDENTIFIER com.al2o3.test_${LibName}
						MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_BINARY_DIR}/Info.plist.in
						RESOURCE MainMenu.nib
						)
			endif()
		endif ()
	endif()
ENDMACRO()
