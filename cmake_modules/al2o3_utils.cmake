MACRO(SET_MIN_VERSIONS)

	cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
	# Fix behavior of CMAKE_CXX_STANDARD when targeting macOS.
	if (POLICY CMP0025)
		cmake_policy(SET CMP0025 NEW)
	endif ()

	set(CMAKE_CXX_STANDARD 17)
	set(CMAKE_C_STANDARD 11)

ENDMACRO()
