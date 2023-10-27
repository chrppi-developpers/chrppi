########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(Drogon_FIND_QUIETLY)
    set(Drogon_MESSAGE_MODE VERBOSE)
else()
    set(Drogon_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/DrogonTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${drogon_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(Drogon_VERSION_STRING "1.8.7")
set(Drogon_INCLUDE_DIRS ${drogon_INCLUDE_DIRS_DEBUG} )
set(Drogon_INCLUDE_DIR ${drogon_INCLUDE_DIRS_DEBUG} )
set(Drogon_LIBRARIES ${drogon_LIBRARIES_DEBUG} )
set(Drogon_DEFINITIONS ${drogon_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${drogon_BUILD_MODULES_PATHS_DEBUG} )
    message(${Drogon_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


