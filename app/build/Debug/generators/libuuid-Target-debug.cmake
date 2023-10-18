# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(util-linux-libuuid_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(util-linux-libuuid_FRAMEWORKS_FOUND_DEBUG "${util-linux-libuuid_FRAMEWORKS_DEBUG}" "${util-linux-libuuid_FRAMEWORK_DIRS_DEBUG}")

set(util-linux-libuuid_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET util-linux-libuuid_DEPS_TARGET)
    add_library(util-linux-libuuid_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET util-linux-libuuid_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${util-linux-libuuid_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${util-linux-libuuid_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### util-linux-libuuid_DEPS_TARGET to all of them
conan_package_library_targets("${util-linux-libuuid_LIBS_DEBUG}"    # libraries
                              "${util-linux-libuuid_LIB_DIRS_DEBUG}" # package_libdir
                              "${util-linux-libuuid_BIN_DIRS_DEBUG}" # package_bindir
                              "${util-linux-libuuid_LIBRARY_TYPE_DEBUG}"
                              "${util-linux-libuuid_IS_HOST_WINDOWS_DEBUG}"
                              util-linux-libuuid_DEPS_TARGET
                              util-linux-libuuid_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "util-linux-libuuid"    # package_name
                              "${util-linux-libuuid_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${util-linux-libuuid_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${util-linux-libuuid_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${util-linux-libuuid_LIBRARIES_TARGETS}>
                 APPEND)

    if("${util-linux-libuuid_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET libuuid::libuuid
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     util-linux-libuuid_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${util-linux-libuuid_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${util-linux-libuuid_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${util-linux-libuuid_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${util-linux-libuuid_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET libuuid::libuuid
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${util-linux-libuuid_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(util-linux-libuuid_LIBRARIES_DEBUG libuuid::libuuid)
