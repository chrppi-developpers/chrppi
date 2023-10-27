# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(expected-lite_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(expected-lite_FRAMEWORKS_FOUND_DEBUG "${expected-lite_FRAMEWORKS_DEBUG}" "${expected-lite_FRAMEWORK_DIRS_DEBUG}")

set(expected-lite_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET expected-lite_DEPS_TARGET)
    add_library(expected-lite_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET expected-lite_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${expected-lite_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${expected-lite_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### expected-lite_DEPS_TARGET to all of them
conan_package_library_targets("${expected-lite_LIBS_DEBUG}"    # libraries
                              "${expected-lite_LIB_DIRS_DEBUG}" # package_libdir
                              "${expected-lite_BIN_DIRS_DEBUG}" # package_bindir
                              "${expected-lite_LIBRARY_TYPE_DEBUG}"
                              "${expected-lite_IS_HOST_WINDOWS_DEBUG}"
                              expected-lite_DEPS_TARGET
                              expected-lite_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "expected-lite"    # package_name
                              "${expected-lite_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${expected-lite_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT nonstd::expected-lite #############

        set(expected-lite_nonstd_expected-lite_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(expected-lite_nonstd_expected-lite_FRAMEWORKS_FOUND_DEBUG "${expected-lite_nonstd_expected-lite_FRAMEWORKS_DEBUG}" "${expected-lite_nonstd_expected-lite_FRAMEWORK_DIRS_DEBUG}")

        set(expected-lite_nonstd_expected-lite_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET expected-lite_nonstd_expected-lite_DEPS_TARGET)
            add_library(expected-lite_nonstd_expected-lite_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET expected-lite_nonstd_expected-lite_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'expected-lite_nonstd_expected-lite_DEPS_TARGET' to all of them
        conan_package_library_targets("${expected-lite_nonstd_expected-lite_LIBS_DEBUG}"
                              "${expected-lite_nonstd_expected-lite_LIB_DIRS_DEBUG}"
                              "${expected-lite_nonstd_expected-lite_BIN_DIRS_DEBUG}" # package_bindir
                              "${expected-lite_nonstd_expected-lite_LIBRARY_TYPE_DEBUG}"
                              "${expected-lite_nonstd_expected-lite_IS_HOST_WINDOWS_DEBUG}"
                              expected-lite_nonstd_expected-lite_DEPS_TARGET
                              expected-lite_nonstd_expected-lite_LIBRARIES_TARGETS
                              "_DEBUG"
                              "expected-lite_nonstd_expected-lite"
                              "${expected-lite_nonstd_expected-lite_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET nonstd::expected-lite
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_LIBRARIES_TARGETS}>
                     APPEND)

        if("${expected-lite_nonstd_expected-lite_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET nonstd::expected-lite
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         expected-lite_nonstd_expected-lite_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET nonstd::expected-lite PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET nonstd::expected-lite PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET nonstd::expected-lite PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET nonstd::expected-lite PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET nonstd::expected-lite PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${expected-lite_nonstd_expected-lite_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET nonstd::expected-lite PROPERTY INTERFACE_LINK_LIBRARIES nonstd::expected-lite APPEND)

########## For the modules (FindXXX)
set(expected-lite_LIBRARIES_DEBUG nonstd::expected-lite)
