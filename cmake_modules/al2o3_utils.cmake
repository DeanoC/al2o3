MACRO(SET_MIN_VERSIONS)

	cmake_minimum_required(VERSION 3.12.4 FATAL_ERROR)
	# Fix behavior of CMAKE_CXX_STANDARD when targeting macOS.
	if (POLICY CMP0025)
		cmake_policy(SET CMP0025 NEW)
	endif ()

	set(CMAKE_CXX_STANDARD 17)
	set(CMAKE_C_STANDARD 11)

ENDMACRO()

MACRO(INIT_AL2O3 _SOURCE_DIR )
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${_SOURCE_DIR}/out_libs)
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${_SOURCE_DIR}/out_bin)
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${_SOURCE_DIR}/out_bin)
	set(LIB_BASE_PATH ${_SOURCE_DIR}/src/libs/)
ENDMACRO()

if(APPLE)
	# We need to compile the interface builder *.xib files to *.nib files to add to the bundle
	# Make sure we can find the 'ibtool' program. If we can NOT find it we skip generation of this project
	FIND_PROGRAM( IBTOOL ibtool HINTS "/usr/bin" "${OSX_DEVELOPER_ROOT}/usr/bin" )
	if ( ${IBTOOL} STREQUAL "IBTOOL-NOTFOUND" )
		MESSAGE( SEND_ERROR "ibtool can not be found" )
	ENDIF()
endif()
