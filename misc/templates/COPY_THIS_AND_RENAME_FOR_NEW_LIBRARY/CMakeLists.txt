set(LibName INSERT_LIBRARY_NAME_HERE)
project(${LibName})

set(Interface
		)
set(Src
		)
set(Deps)
ADD_LIB(${LibName} "${Interface}" "${Src}" "${Deps}")

set( Tests
		)
set( TestDeps
		)
ADD_LIB_TESTS(${LibName} "${Interface}" "${Tests}" "${TestDeps}")
