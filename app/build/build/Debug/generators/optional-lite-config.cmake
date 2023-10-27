########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(optional-lite_FIND_QUIETLY)
    set(optional-lite_MESSAGE_MODE VERBOSE)
else()
    set(optional-lite_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/optional-liteTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${optional-lite_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(optional-lite_VERSION_STRING "3.5.0")
set(optional-lite_INCLUDE_DIRS ${optional-lite_INCLUDE_DIRS_DEBUG} )
set(optional-lite_INCLUDE_DIR ${optional-lite_INCLUDE_DIRS_DEBUG} )
set(optional-lite_LIBRARIES ${optional-lite_LIBRARIES_DEBUG} )
set(optional-lite_DEFINITIONS ${optional-lite_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${optional-lite_BUILD_MODULES_PATHS_DEBUG} )
    message(${optional-lite_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


