# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(optional-lite_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(optional-lite_FRAMEWORKS_FOUND_DEBUG "${optional-lite_FRAMEWORKS_DEBUG}" "${optional-lite_FRAMEWORK_DIRS_DEBUG}")

set(optional-lite_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET optional-lite_DEPS_TARGET)
    add_library(optional-lite_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET optional-lite_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${optional-lite_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${optional-lite_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### optional-lite_DEPS_TARGET to all of them
conan_package_library_targets("${optional-lite_LIBS_DEBUG}"    # libraries
                              "${optional-lite_LIB_DIRS_DEBUG}" # package_libdir
                              "${optional-lite_BIN_DIRS_DEBUG}" # package_bindir
                              "${optional-lite_LIBRARY_TYPE_DEBUG}"
                              "${optional-lite_IS_HOST_WINDOWS_DEBUG}"
                              optional-lite_DEPS_TARGET
                              optional-lite_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "optional-lite"    # package_name
                              "${optional-lite_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${optional-lite_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT nonstd::optional-lite #############

        set(optional-lite_nonstd_optional-lite_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(optional-lite_nonstd_optional-lite_FRAMEWORKS_FOUND_DEBUG "${optional-lite_nonstd_optional-lite_FRAMEWORKS_DEBUG}" "${optional-lite_nonstd_optional-lite_FRAMEWORK_DIRS_DEBUG}")

        set(optional-lite_nonstd_optional-lite_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET optional-lite_nonstd_optional-lite_DEPS_TARGET)
            add_library(optional-lite_nonstd_optional-lite_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET optional-lite_nonstd_optional-lite_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'optional-lite_nonstd_optional-lite_DEPS_TARGET' to all of them
        conan_package_library_targets("${optional-lite_nonstd_optional-lite_LIBS_DEBUG}"
                              "${optional-lite_nonstd_optional-lite_LIB_DIRS_DEBUG}"
                              "${optional-lite_nonstd_optional-lite_BIN_DIRS_DEBUG}" # package_bindir
                              "${optional-lite_nonstd_optional-lite_LIBRARY_TYPE_DEBUG}"
                              "${optional-lite_nonstd_optional-lite_IS_HOST_WINDOWS_DEBUG}"
                              optional-lite_nonstd_optional-lite_DEPS_TARGET
                              optional-lite_nonstd_optional-lite_LIBRARIES_TARGETS
                              "_DEBUG"
                              "optional-lite_nonstd_optional-lite"
                              "${optional-lite_nonstd_optional-lite_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET nonstd::optional-lite
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_LIBRARIES_TARGETS}>
                     APPEND)

        if("${optional-lite_nonstd_optional-lite_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET nonstd::optional-lite
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         optional-lite_nonstd_optional-lite_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET nonstd::optional-lite PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET nonstd::optional-lite PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET nonstd::optional-lite PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET nonstd::optional-lite PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET nonstd::optional-lite PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${optional-lite_nonstd_optional-lite_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET nonstd::optional-lite PROPERTY INTERFACE_LINK_LIBRARIES nonstd::optional-lite APPEND)

########## For the modules (FindXXX)
set(optional-lite_LIBRARIES_DEBUG nonstd::optional-lite)
