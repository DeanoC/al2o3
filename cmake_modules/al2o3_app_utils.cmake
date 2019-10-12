

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

MACRO(ADD_GUI_APP AppName Src Deps)
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
		SET(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
		target_link_libraries(${AppName} PRIVATE stdc++ "-framework Foundation" "-framework Cocoa" objc)
		set( INFO_PLIST_IN "NONE")
		set( ENTITLEMENTS_PLIST "NONE")

		foreach (s ${_src})
			get_filename_component(sname ${s} NAME)
			if( "Info.plist.in" STREQUAL ${sname})
				set( INFO_PLIST_IN ${s})
				configure_file(${INFO_PLIST_IN} ${CMAKE_CURRENT_BINARY_DIR}/Info.plist.in COPYONLY)
			endif()
			if( "entitlements.plist" STREQUAL ${sname} )
				set( ENTITLEMENTS_PLIST ${s})
				configure_file(${ENTITLEMENTS_PLIST} ${CMAKE_CURRENT_BINARY_DIR}/${AppName}.entitlements COPYONLY)
			endif()

		endforeach ()

		if( EXISTS ${INFO_PLIST_IN} AND EXISTS ${ENTITLEMENTS_PLIST} )
			set_target_properties(${AppName} PROPERTIES
					MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_BINARY_DIR}/Info.plist.in
					MACOSX_BUNDLE_GUI_IDENTIFIER com.al2o3.${AppName}
					XCODE_ATTRIBUTE_CODE_SIGN_ENTITLEMENTS "${CMAKE_CURRENT_LIST_DIR}/${AppName}.entitlements"
					)
		elseif( EXISTS ${INFO_PLIST_IN})
			set_target_properties(${AppName} PROPERTIES
					MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_BINARY_DIR}/Info.plist.in
					MACOSX_BUNDLE_GUI_IDENTIFIER com.al2o3.${AppName}
					)
		else()
			set_target_properties(${AppName} PROPERTIES
					MACOSX_BUNDLE_GUI_IDENTIFIER com.al2o3.${AppName} )
		endif()

		if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)
			configure_file(${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
					${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/LICENSE COPYONLY)
		endif()

		if(EXISTS ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/LIBRARY_LICENSES)
			file(REMOVE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/LIBRARY_LICENSES)
		endif()

		file(GLOB _licenses ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/*_LICENSE )
		foreach (_licensefile ${_licenses})
			get_filename_component(_liclibname ${_licensefile} NAME)
			file(READ ${_licensefile} tmp)

			set(header "\r\n" ${_liclibname} "\r\n-------------------------------------\r\n")
			file(APPEND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/LIBRARY_LICENSES ${header})
			file(APPEND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/LIBRARY_LICENSES ${tmp})
		endforeach()

	endif()
ENDMACRO()
