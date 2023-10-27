########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND expected-lite_COMPONENT_NAMES nonstd::expected-lite)
list(REMOVE_DUPLICATES expected-lite_COMPONENT_NAMES)
set(expected-lite_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(expected-lite_PACKAGE_FOLDER_DEBUG "/home/quentin/.conan2/p/expeca6c3c5a6cc8d3/p")
set(expected-lite_BUILD_MODULES_PATHS_DEBUG )


set(expected-lite_INCLUDE_DIRS_DEBUG "${expected-lite_PACKAGE_FOLDER_DEBUG}/include")
set(expected-lite_RES_DIRS_DEBUG )
set(expected-lite_DEFINITIONS_DEBUG )
set(expected-lite_SHARED_LINK_FLAGS_DEBUG )
set(expected-lite_EXE_LINK_FLAGS_DEBUG )
set(expected-lite_OBJECTS_DEBUG )
set(expected-lite_COMPILE_DEFINITIONS_DEBUG )
set(expected-lite_COMPILE_OPTIONS_C_DEBUG )
set(expected-lite_COMPILE_OPTIONS_CXX_DEBUG )
set(expected-lite_LIB_DIRS_DEBUG )
set(expected-lite_BIN_DIRS_DEBUG )
set(expected-lite_LIBRARY_TYPE_DEBUG UNKNOWN)
set(expected-lite_IS_HOST_WINDOWS_DEBUG 0)
set(expected-lite_LIBS_DEBUG )
set(expected-lite_SYSTEM_LIBS_DEBUG )
set(expected-lite_FRAMEWORK_DIRS_DEBUG )
set(expected-lite_FRAMEWORKS_DEBUG )
set(expected-lite_BUILD_DIRS_DEBUG )
set(expected-lite_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(expected-lite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${expected-lite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${expected-lite_COMPILE_OPTIONS_C_DEBUG}>")
set(expected-lite_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${expected-lite_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${expected-lite_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${expected-lite_EXE_LINK_FLAGS_DEBUG}>")


set(expected-lite_COMPONENTS_DEBUG nonstd::expected-lite)
########### COMPONENT nonstd::expected-lite VARIABLES ############################################

set(expected-lite_nonstd_expected-lite_INCLUDE_DIRS_DEBUG "${expected-lite_PACKAGE_FOLDER_DEBUG}/include")
set(expected-lite_nonstd_expected-lite_LIB_DIRS_DEBUG )
set(expected-lite_nonstd_expected-lite_BIN_DIRS_DEBUG )
set(expected-lite_nonstd_expected-lite_LIBRARY_TYPE_DEBUG UNKNOWN)
set(expected-lite_nonstd_expected-lite_IS_HOST_WINDOWS_DEBUG 0)
set(expected-lite_nonstd_expected-lite_RES_DIRS_DEBUG )
set(expected-lite_nonstd_expected-lite_DEFINITIONS_DEBUG )
set(expected-lite_nonstd_expected-lite_OBJECTS_DEBUG )
set(expected-lite_nonstd_expected-lite_COMPILE_DEFINITIONS_DEBUG )
set(expected-lite_nonstd_expected-lite_COMPILE_OPTIONS_C_DEBUG "")
set(expected-lite_nonstd_expected-lite_COMPILE_OPTIONS_CXX_DEBUG "")
set(expected-lite_nonstd_expected-lite_LIBS_DEBUG )
set(expected-lite_nonstd_expected-lite_SYSTEM_LIBS_DEBUG )
set(expected-lite_nonstd_expected-lite_FRAMEWORK_DIRS_DEBUG )
set(expected-lite_nonstd_expected-lite_FRAMEWORKS_DEBUG )
set(expected-lite_nonstd_expected-lite_DEPENDENCIES_DEBUG )
set(expected-lite_nonstd_expected-lite_SHARED_LINK_FLAGS_DEBUG )
set(expected-lite_nonstd_expected-lite_EXE_LINK_FLAGS_DEBUG )
set(expected-lite_nonstd_expected-lite_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(expected-lite_nonstd_expected-lite_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${expected-lite_nonstd_expected-lite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${expected-lite_nonstd_expected-lite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${expected-lite_nonstd_expected-lite_EXE_LINK_FLAGS_DEBUG}>
)
set(expected-lite_nonstd_expected-lite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${expected-lite_nonstd_expected-lite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${expected-lite_nonstd_expected-lite_COMPILE_OPTIONS_C_DEBUG}>")