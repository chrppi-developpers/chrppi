# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(c-ares_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(c-ares_FRAMEWORKS_FOUND_DEBUG "${c-ares_FRAMEWORKS_DEBUG}" "${c-ares_FRAMEWORK_DIRS_DEBUG}")

set(c-ares_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET c-ares_DEPS_TARGET)
    add_library(c-ares_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET c-ares_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${c-ares_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${c-ares_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### c-ares_DEPS_TARGET to all of them
conan_package_library_targets("${c-ares_LIBS_DEBUG}"    # libraries
                              "${c-ares_LIB_DIRS_DEBUG}" # package_libdir
                              "${c-ares_BIN_DIRS_DEBUG}" # package_bindir
                              "${c-ares_LIBRARY_TYPE_DEBUG}"
                              "${c-ares_IS_HOST_WINDOWS_DEBUG}"
                              c-ares_DEPS_TARGET
                              c-ares_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "c-ares"    # package_name
                              "${c-ares_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${c-ares_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Debug ########################################

    ########## COMPONENT c-ares::cares #############

        set(c-ares_c-ares_cares_FRAMEWORKS_FOUND_DEBUG "")
        conan_find_apple_frameworks(c-ares_c-ares_cares_FRAMEWORKS_FOUND_DEBUG "${c-ares_c-ares_cares_FRAMEWORKS_DEBUG}" "${c-ares_c-ares_cares_FRAMEWORK_DIRS_DEBUG}")

        set(c-ares_c-ares_cares_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET c-ares_c-ares_cares_DEPS_TARGET)
            add_library(c-ares_c-ares_cares_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET c-ares_c-ares_cares_DEPS_TARGET
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_FRAMEWORKS_FOUND_DEBUG}>
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_SYSTEM_LIBS_DEBUG}>
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_DEPENDENCIES_DEBUG}>
                     APPEND)

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'c-ares_c-ares_cares_DEPS_TARGET' to all of them
        conan_package_library_targets("${c-ares_c-ares_cares_LIBS_DEBUG}"
                              "${c-ares_c-ares_cares_LIB_DIRS_DEBUG}"
                              "${c-ares_c-ares_cares_BIN_DIRS_DEBUG}" # package_bindir
                              "${c-ares_c-ares_cares_LIBRARY_TYPE_DEBUG}"
                              "${c-ares_c-ares_cares_IS_HOST_WINDOWS_DEBUG}"
                              c-ares_c-ares_cares_DEPS_TARGET
                              c-ares_c-ares_cares_LIBRARIES_TARGETS
                              "_DEBUG"
                              "c-ares_c-ares_cares"
                              "${c-ares_c-ares_cares_NO_SONAME_MODE_DEBUG}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET c-ares::cares
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_OBJECTS_DEBUG}>
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_LIBRARIES_TARGETS}>
                     APPEND)

        if("${c-ares_c-ares_cares_LIBS_DEBUG}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET c-ares::cares
                         PROPERTY INTERFACE_LINK_LIBRARIES
                         c-ares_c-ares_cares_DEPS_TARGET
                         APPEND)
        endif()

        set_property(TARGET c-ares::cares PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_LINKER_FLAGS_DEBUG}> APPEND)
        set_property(TARGET c-ares::cares PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_INCLUDE_DIRS_DEBUG}> APPEND)
        set_property(TARGET c-ares::cares PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_LIB_DIRS_DEBUG}> APPEND)
        set_property(TARGET c-ares::cares PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_COMPILE_DEFINITIONS_DEBUG}> APPEND)
        set_property(TARGET c-ares::cares PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Debug>:${c-ares_c-ares_cares_COMPILE_OPTIONS_DEBUG}> APPEND)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET c-ares::cares PROPERTY INTERFACE_LINK_LIBRARIES c-ares::cares APPEND)

########## For the modules (FindXXX)
set(c-ares_LIBRARIES_DEBUG c-ares::cares)
