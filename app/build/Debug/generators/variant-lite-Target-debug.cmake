# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(variant-lite_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(variant-lite_FRAMEWORKS_FOUND_DEBUG "${variant-lite_FRAMEWORKS_DEBUG}" "${variant-lite_FRAMEWORK_DIRS_DEBUG}")

set(variant-lite_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET variant-lite_DEPS_TARGET)
    add_library(variant-lite_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET variant-lite_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${variant-lite_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${variant-lite_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### variant-lite_DEPS_TARGET to all of them
conan_package_library_targets("${variant-lite_LIBS_DEBUG}"    # libraries
                              "${variant-lite_LIB_DIRS_DEBUG}" # package_libdir
                              "${variant-lite_BIN_DIRS_DEBUG}" # package_bindir
                              "${variant-lite_LIBRARY_TYPE_DEBUG}"
                              "${variant-lite_IS_HOST_WINDOWS_DEBUG}"
                              variant-lite_DEPS_TARGET
                              variant-lite_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "variant-lite"    # package_name
                              "${variant-lite_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${variant-lite_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT nonstd::variant-lite #############

        set(variant-lite_nonstd_variant-lite_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(variant-lite_nonstd_variant-lite_FRAMEWORKS_FOUND_DEBUG "${variant-lite_nonstd_variant-lite_FRAMEWORKS_DEBUG}" "${variant-lite_nonstd_variant-lite_FRAMEWORK_DIRS_DEBUG}")

        set(variant-lite_nonstd_variant-lite_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET variant-lite_nonstd_variant-lite_DEPS_TARGET)
            add_library(variant-lite_nonstd_variant-lite_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET variant-lite_nonstd_variant-lite_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'variant-lite_nonstd_variant-lite_DEPS_TARGET' to all of them
        conan_package_library_targets("${variant-lite_nonstd_variant-lite_LIBS_DEBUG}"
                              "${variant-lite_nonstd_variant-lite_LIB_DIRS_DEBUG}"
                              "${variant-lite_nonstd_variant-lite_BIN_DIRS_DEBUG}" # package_bindir
                              "${variant-lite_nonstd_variant-lite_LIBRARY_TYPE_DEBUG}"
                              "${variant-lite_nonstd_variant-lite_IS_HOST_WINDOWS_DEBUG}"
                              variant-lite_nonstd_variant-lite_DEPS_TARGET
                              variant-lite_nonstd_variant-lite_LIBRARIES_TARGETS
                              "_DEBUG"
                              "variant-lite_nonstd_variant-lite"
                              "${variant-lite_nonstd_variant-lite_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET nonstd::variant-lite
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_LIBRARIES_TARGETS}>
                     APPEND)

        if("${variant-lite_nonstd_variant-lite_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET nonstd::variant-lite
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         variant-lite_nonstd_variant-lite_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET nonstd::variant-lite PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET nonstd::variant-lite PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET nonstd::variant-lite PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET nonstd::variant-lite PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET nonstd::variant-lite PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${variant-lite_nonstd_variant-lite_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET nonstd::variant-lite PROPERTY INTERFACE_LINK_LIBRARIES nonstd::variant-lite APPEND)

########## For the modules (FindXXX)
set(variant-lite_LIBRARIES_DEBUG nonstd::variant-lite)
