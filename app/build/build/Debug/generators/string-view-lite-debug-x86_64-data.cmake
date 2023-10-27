########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND string-view-lite_COMPONENT_NAMES nonstd::string-view-lite)
list(REMOVE_DUPLICATES string-view-lite_COMPONENT_NAMES)
set(string-view-lite_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(string-view-lite_PACKAGE_FOLDER_DEBUG "/home/quentin/.conan2/p/strin06e2118a14c4c/p")
set(string-view-lite_BUILD_MODULES_PATHS_DEBUG )


set(string-view-lite_INCLUDE_DIRS_DEBUG "${string-view-lite_PACKAGE_FOLDER_DEBUG}/include")
set(string-view-lite_RES_DIRS_DEBUG )
set(string-view-lite_DEFINITIONS_DEBUG )
set(string-view-lite_SHARED_LINK_FLAGS_DEBUG )
set(string-view-lite_EXE_LINK_FLAGS_DEBUG )
set(string-view-lite_OBJECTS_DEBUG )
set(string-view-lite_COMPILE_DEFINITIONS_DEBUG )
set(string-view-lite_COMPILE_OPTIONS_C_DEBUG )
set(string-view-lite_COMPILE_OPTIONS_CXX_DEBUG )
set(string-view-lite_LIB_DIRS_DEBUG )
set(string-view-lite_BIN_DIRS_DEBUG )
set(string-view-lite_LIBRARY_TYPE_DEBUG UNKNOWN)
set(string-view-lite_IS_HOST_WINDOWS_DEBUG 0)
set(string-view-lite_LIBS_DEBUG )
set(string-view-lite_SYSTEM_LIBS_DEBUG )
set(string-view-lite_FRAMEWORK_DIRS_DEBUG )
set(string-view-lite_FRAMEWORKS_DEBUG )
set(string-view-lite_BUILD_DIRS_DEBUG )
set(string-view-lite_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(string-view-lite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${string-view-lite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${string-view-lite_COMPILE_OPTIONS_C_DEBUG}>")
set(string-view-lite_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${string-view-lite_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${string-view-lite_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${string-view-lite_EXE_LINK_FLAGS_DEBUG}>")


set(string-view-lite_COMPONENTS_DEBUG nonstd::string-view-lite)
########### COMPONENT nonstd::string-view-lite VARIABLES ############################################

set(string-view-lite_nonstd_string-view-lite_INCLUDE_DIRS_DEBUG "${string-view-lite_PACKAGE_FOLDER_DEBUG}/include")
set(string-view-lite_nonstd_string-view-lite_LIB_DIRS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_BIN_DIRS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_LIBRARY_TYPE_DEBUG UNKNOWN)
set(string-view-lite_nonstd_string-view-lite_IS_HOST_WINDOWS_DEBUG 0)
set(string-view-lite_nonstd_string-view-lite_RES_DIRS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_DEFINITIONS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_OBJECTS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_COMPILE_DEFINITIONS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_COMPILE_OPTIONS_C_DEBUG "")
set(string-view-lite_nonstd_string-view-lite_COMPILE_OPTIONS_CXX_DEBUG "")
set(string-view-lite_nonstd_string-view-lite_LIBS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_SYSTEM_LIBS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_FRAMEWORK_DIRS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_FRAMEWORKS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_DEPENDENCIES_DEBUG )
set(string-view-lite_nonstd_string-view-lite_SHARED_LINK_FLAGS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_EXE_LINK_FLAGS_DEBUG )
set(string-view-lite_nonstd_string-view-lite_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(string-view-lite_nonstd_string-view-lite_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${string-view-lite_nonstd_string-view-lite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${string-view-lite_nonstd_string-view-lite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${string-view-lite_nonstd_string-view-lite_EXE_LINK_FLAGS_DEBUG}>
)
set(string-view-lite_nonstd_string-view-lite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${string-view-lite_nonstd_string-view-lite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${string-view-lite_nonstd_string-view-lite_COMPILE_OPTIONS_C_DEBUG}>")