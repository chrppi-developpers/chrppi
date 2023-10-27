# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(drogon_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(drogon_FRAMEWORKS_FOUND_DEBUG "${drogon_FRAMEWORKS_DEBUG}" "${drogon_FRAMEWORK_DIRS_DEBUG}")

set(drogon_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET drogon_DEPS_TARGET)
    add_library(drogon_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET drogon_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${drogon_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${drogon_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:Trantor::Trantor;JsonCpp::JsonCpp;openssl::openssl;libuuid::libuuid;boost::boost;ZLIB::ZLIB>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### drogon_DEPS_TARGET to all of them
conan_package_library_targets("${drogon_LIBS_DEBUG}"    # libraries
                              "${drogon_LIB_DIRS_DEBUG}" # package_libdir
                              "${drogon_BIN_DIRS_DEBUG}" # package_bindir
                              "${drogon_LIBRARY_TYPE_DEBUG}"
                              "${drogon_IS_HOST_WINDOWS_DEBUG}"
                              drogon_DEPS_TARGET
                              drogon_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "drogon"    # package_name
                              "${drogon_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${drogon_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET Drogon::Drogon
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${drogon_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${drogon_LIBRARIES_TARGETS}>
                 APPEND)

    if("${drogon_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET Drogon::Drogon
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     drogon_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET Drogon::Drogon
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${drogon_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET Drogon::Drogon
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${drogon_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET Drogon::Drogon
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${drogon_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET Drogon::Drogon
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${drogon_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET Drogon::Drogon
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${drogon_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(drogon_LIBRARIES_DEBUG Drogon::Drogon)
