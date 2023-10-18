########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(Trantor_FIND_QUIETLY)
    set(Trantor_MESSAGE_MODE VERBOSE)
else()
    set(Trantor_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/TrantorTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${trantor_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(Trantor_VERSION_STRING "1.5.14")
set(Trantor_INCLUDE_DIRS ${trantor_INCLUDE_DIRS_DEBUG} )
set(Trantor_INCLUDE_DIR ${trantor_INCLUDE_DIRS_DEBUG} )
set(Trantor_LIBRARIES ${trantor_LIBRARIES_DEBUG} )
set(Trantor_DEFINITIONS ${trantor_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${trantor_BUILD_MODULES_PATHS_DEBUG} )
    message(${Trantor_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


