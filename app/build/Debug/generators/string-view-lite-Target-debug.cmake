# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(string-view-lite_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(string-view-lite_FRAMEWORKS_FOUND_DEBUG "${string-view-lite_FRAMEWORKS_DEBUG}" "${string-view-lite_FRAMEWORK_DIRS_DEBUG}")

set(string-view-lite_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET string-view-lite_DEPS_TARGET)
    add_library(string-view-lite_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET string-view-lite_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${string-view-lite_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${string-view-lite_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### string-view-lite_DEPS_TARGET to all of them
conan_package_library_targets("${string-view-lite_LIBS_DEBUG}"    # libraries
                              "${string-view-lite_LIB_DIRS_DEBUG}" # package_libdir
                              "${string-view-lite_BIN_DIRS_DEBUG}" # package_bindir
                              "${string-view-lite_LIBRARY_TYPE_DEBUG}"
                              "${string-view-lite_IS_HOST_WINDOWS_DEBUG}"
                              string-view-lite_DEPS_TARGET
                              string-view-lite_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "string-view-lite"    # package_name
                              "${string-view-lite_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${string-view-lite_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT nonstd::string-view-lite #############

        set(string-view-lite_nonstd_string-view-lite_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(string-view-lite_nonstd_string-view-lite_FRAMEWORKS_FOUND_DEBUG "${string-view-lite_nonstd_string-view-lite_FRAMEWORKS_DEBUG}" "${string-view-lite_nonstd_string-view-lite_FRAMEWORK_DIRS_DEBUG}")

        set(string-view-lite_nonstd_string-view-lite_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET string-view-lite_nonstd_string-view-lite_DEPS_TARGET)
            add_library(string-view-lite_nonstd_string-view-lite_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET string-view-lite_nonstd_string-view-lite_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'string-view-lite_nonstd_string-view-lite_DEPS_TARGET' to all of them
        conan_package_library_targets("${string-view-lite_nonstd_string-view-lite_LIBS_DEBUG}"
                              "${string-view-lite_nonstd_string-view-lite_LIB_DIRS_DEBUG}"
                              "${string-view-lite_nonstd_string-view-lite_BIN_DIRS_DEBUG}" # package_bindir
                              "${string-view-lite_nonstd_string-view-lite_LIBRARY_TYPE_DEBUG}"
                              "${string-view-lite_nonstd_string-view-lite_IS_HOST_WINDOWS_DEBUG}"
                              string-view-lite_nonstd_string-view-lite_DEPS_TARGET
                              string-view-lite_nonstd_string-view-lite_LIBRARIES_TARGETS
                              "_DEBUG"
                              "string-view-lite_nonstd_string-view-lite"
                              "${string-view-lite_nonstd_string-view-lite_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET nonstd::string-view-lite
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_LIBRARIES_TARGETS}>
                     APPEND)

        if("${string-view-lite_nonstd_string-view-lite_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET nonstd::string-view-lite
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         string-view-lite_nonstd_string-view-lite_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET nonstd::string-view-lite PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET nonstd::string-view-lite PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET nonstd::string-view-lite PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET nonstd::string-view-lite PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET nonstd::string-view-lite PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${string-view-lite_nonstd_string-view-lite_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET nonstd::string-view-lite PROPERTY INTERFACE_LINK_LIBRARIES nonstd::string-view-lite APPEND)

########## For the modules (FindXXX)
set(string-view-lite_LIBRARIES_DEBUG nonstd::string-view-lite)
