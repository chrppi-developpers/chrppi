########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(variant-lite_FIND_QUIETLY)
    set(variant-lite_MESSAGE_MODE VERBOSE)
else()
    set(variant-lite_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/variant-liteTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${variant-lite_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(variant-lite_VERSION_STRING "2.0.0")
set(variant-lite_INCLUDE_DIRS ${variant-lite_INCLUDE_DIRS_DEBUG} )
set(variant-lite_INCLUDE_DIR ${variant-lite_INCLUDE_DIRS_DEBUG} )
set(variant-lite_LIBRARIES ${variant-lite_LIBRARIES_DEBUG} )
set(variant-lite_DEFINITIONS ${variant-lite_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${variant-lite_BUILD_MODULES_PATHS_DEBUG} )
    message(${variant-lite_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


