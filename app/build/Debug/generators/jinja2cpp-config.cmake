########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(jinja2cpp_FIND_QUIETLY)
    set(jinja2cpp_MESSAGE_MODE VERBOSE)
else()
    set(jinja2cpp_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/jinja2cppTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${jinja2cpp_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(jinja2cpp_VERSION_STRING "1.2.1")
set(jinja2cpp_INCLUDE_DIRS ${jinja2cpp_INCLUDE_DIRS_DEBUG} )
set(jinja2cpp_INCLUDE_DIR ${jinja2cpp_INCLUDE_DIRS_DEBUG} )
set(jinja2cpp_LIBRARIES ${jinja2cpp_LIBRARIES_DEBUG} )
set(jinja2cpp_DEFINITIONS ${jinja2cpp_DEFINITIONS_DEBUG} )

# Only the first installed configuration is included to avoid the collision
foreach(_BUILD_MODULE ${jinja2cpp_BUILD_MODULES_PATHS_DEBUG} )
    message(${jinja2cpp_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


