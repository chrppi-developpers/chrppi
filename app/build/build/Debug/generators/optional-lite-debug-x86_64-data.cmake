########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND optional-lite_COMPONENT_NAMES nonstd::optional-lite)
list(REMOVE_DUPLICATES optional-lite_COMPONENT_NAMES)
set(optional-lite_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(optional-lite_PACKAGE_FOLDER_DEBUG "/home/quentin/.conan2/p/optioe6869b41bf51b/p")
set(optional-lite_BUILD_MODULES_PATHS_DEBUG )


set(optional-lite_INCLUDE_DIRS_DEBUG "${optional-lite_PACKAGE_FOLDER_DEBUG}/include")
set(optional-lite_RES_DIRS_DEBUG )
set(optional-lite_DEFINITIONS_DEBUG )
set(optional-lite_SHARED_LINK_FLAGS_DEBUG )
set(optional-lite_EXE_LINK_FLAGS_DEBUG )
set(optional-lite_OBJECTS_DEBUG )
set(optional-lite_COMPILE_DEFINITIONS_DEBUG )
set(optional-lite_COMPILE_OPTIONS_C_DEBUG )
set(optional-lite_COMPILE_OPTIONS_CXX_DEBUG )
set(optional-lite_LIB_DIRS_DEBUG )
set(optional-lite_BIN_DIRS_DEBUG )
set(optional-lite_LIBRARY_TYPE_DEBUG UNKNOWN)
set(optional-lite_IS_HOST_WINDOWS_DEBUG 0)
set(optional-lite_LIBS_DEBUG )
set(optional-lite_SYSTEM_LIBS_DEBUG )
set(optional-lite_FRAMEWORK_DIRS_DEBUG )
set(optional-lite_FRAMEWORKS_DEBUG )
set(optional-lite_BUILD_DIRS_DEBUG )
set(optional-lite_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(optional-lite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${optional-lite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${optional-lite_COMPILE_OPTIONS_C_DEBUG}>")
set(optional-lite_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${optional-lite_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${optional-lite_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${optional-lite_EXE_LINK_FLAGS_DEBUG}>")


set(optional-lite_COMPONENTS_DEBUG nonstd::optional-lite)
########### COMPONENT nonstd::optional-lite VARIABLES ############################################

set(optional-lite_nonstd_optional-lite_INCLUDE_DIRS_DEBUG "${optional-lite_PACKAGE_FOLDER_DEBUG}/include")
set(optional-lite_nonstd_optional-lite_LIB_DIRS_DEBUG )
set(optional-lite_nonstd_optional-lite_BIN_DIRS_DEBUG )
set(optional-lite_nonstd_optional-lite_LIBRARY_TYPE_DEBUG UNKNOWN)
set(optional-lite_nonstd_optional-lite_IS_HOST_WINDOWS_DEBUG 0)
set(optional-lite_nonstd_optional-lite_RES_DIRS_DEBUG )
set(optional-lite_nonstd_optional-lite_DEFINITIONS_DEBUG )
set(optional-lite_nonstd_optional-lite_OBJECTS_DEBUG )
set(optional-lite_nonstd_optional-lite_COMPILE_DEFINITIONS_DEBUG )
set(optional-lite_nonstd_optional-lite_COMPILE_OPTIONS_C_DEBUG "")
set(optional-lite_nonstd_optional-lite_COMPILE_OPTIONS_CXX_DEBUG "")
set(optional-lite_nonstd_optional-lite_LIBS_DEBUG )
set(optional-lite_nonstd_optional-lite_SYSTEM_LIBS_DEBUG )
set(optional-lite_nonstd_optional-lite_FRAMEWORK_DIRS_DEBUG )
set(optional-lite_nonstd_optional-lite_FRAMEWORKS_DEBUG )
set(optional-lite_nonstd_optional-lite_DEPENDENCIES_DEBUG )
set(optional-lite_nonstd_optional-lite_SHARED_LINK_FLAGS_DEBUG )
set(optional-lite_nonstd_optional-lite_EXE_LINK_FLAGS_DEBUG )
set(optional-lite_nonstd_optional-lite_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(optional-lite_nonstd_optional-lite_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${optional-lite_nonstd_optional-lite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${optional-lite_nonstd_optional-lite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${optional-lite_nonstd_optional-lite_EXE_LINK_FLAGS_DEBUG}>
)
set(optional-lite_nonstd_optional-lite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${optional-lite_nonstd_optional-lite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${optional-lite_nonstd_optional-lite_COMPILE_OPTIONS_C_DEBUG}>")