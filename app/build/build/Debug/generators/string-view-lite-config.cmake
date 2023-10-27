########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(string-view-lite_FIND_QUIETLY)
    set(string-view-lite_MESSAGE_MODE VERBOSE)
else()
    set(string-view-lite_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/string-view-liteTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${string-view-lite_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(string-view-lite_VERSION_STRING "1.7.0")
set(string-view-lite_INCLUDE_DIRS ${string-view-lite_INCLUDE_DIRS_DEBUG} )
set(string-view-lite_INCLUDE_DIR ${string-view-lite_INCLUDE_DIRS_DEBUG} )
set(string-view-lite_LIBRARIES ${string-view-lite_LIBRARIES_DEBUG} )
set(string-view-lite_DEFINITIONS ${string-view-lite_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${string-view-lite_BUILD_MODULES_PATHS_DEBUG} )
    message(${string-view-lite_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


