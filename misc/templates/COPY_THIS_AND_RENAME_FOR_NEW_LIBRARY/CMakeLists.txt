set(LibName INSERT_LIBRARY_NAME_HERE)
project(${LibName})

set(Interface
		)
set(Src
		)
set(Deps
        al2o3_platform)
ADD_LIB(${LibName} "${Interface}" "${Src}" "${Deps}")

set( Tests
		)
set( TestDeps
		catch2 )
ADD_LIB_TESTS(${LibName} "${Interface}" "${Tests}" "${TestDeps}")
