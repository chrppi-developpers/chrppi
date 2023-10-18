########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND variant-lite_COMPONENT_NAMES nonstd::variant-lite)
list(REMOVE_DUPLICATES variant-lite_COMPONENT_NAMES)
set(variant-lite_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(variant-lite_PACKAGE_FOLDER_DEBUG "/home/app/.conan2/p/varia4f720eaf9ec7d/p")
set(variant-lite_BUILD_MODULES_PATHS_DEBUG )


set(variant-lite_INCLUDE_DIRS_DEBUG "${variant-lite_PACKAGE_FOLDER_DEBUG}/include")
set(variant-lite_RES_DIRS_DEBUG )
set(variant-lite_DEFINITIONS_DEBUG )
set(variant-lite_SHARED_LINK_FLAGS_DEBUG )
set(variant-lite_EXE_LINK_FLAGS_DEBUG )
set(variant-lite_OBJECTS_DEBUG )
set(variant-lite_COMPILE_DEFINITIONS_DEBUG )
set(variant-lite_COMPILE_OPTIONS_C_DEBUG )
set(variant-lite_COMPILE_OPTIONS_CXX_DEBUG )
set(variant-lite_LIB_DIRS_DEBUG )
set(variant-lite_BIN_DIRS_DEBUG )
set(variant-lite_LIBRARY_TYPE_DEBUG UNKNOWN)
set(variant-lite_IS_HOST_WINDOWS_DEBUG 0)
set(variant-lite_LIBS_DEBUG )
set(variant-lite_SYSTEM_LIBS_DEBUG )
set(variant-lite_FRAMEWORK_DIRS_DEBUG )
set(variant-lite_FRAMEWORKS_DEBUG )
set(variant-lite_BUILD_DIRS_DEBUG )
set(variant-lite_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(variant-lite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${variant-lite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${variant-lite_COMPILE_OPTIONS_C_DEBUG}>")
set(variant-lite_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${variant-lite_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${variant-lite_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${variant-lite_EXE_LINK_FLAGS_DEBUG}>")


set(variant-lite_COMPONENTS_DEBUG nonstd::variant-lite)
########### COMPONENT nonstd::variant-lite VARIABLES ############################################

set(variant-lite_nonstd_variant-lite_INCLUDE_DIRS_DEBUG "${variant-lite_PACKAGE_FOLDER_DEBUG}/include")
set(variant-lite_nonstd_variant-lite_LIB_DIRS_DEBUG )
set(variant-lite_nonstd_variant-lite_BIN_DIRS_DEBUG )
set(variant-lite_nonstd_variant-lite_LIBRARY_TYPE_DEBUG UNKNOWN)
set(variant-lite_nonstd_variant-lite_IS_HOST_WINDOWS_DEBUG 0)
set(variant-lite_nonstd_variant-lite_RES_DIRS_DEBUG )
set(variant-lite_nonstd_variant-lite_DEFINITIONS_DEBUG )
set(variant-lite_nonstd_variant-lite_OBJECTS_DEBUG )
set(variant-lite_nonstd_variant-lite_COMPILE_DEFINITIONS_DEBUG )
set(variant-lite_nonstd_variant-lite_COMPILE_OPTIONS_C_DEBUG "")
set(variant-lite_nonstd_variant-lite_COMPILE_OPTIONS_CXX_DEBUG "")
set(variant-lite_nonstd_variant-lite_LIBS_DEBUG )
set(variant-lite_nonstd_variant-lite_SYSTEM_LIBS_DEBUG )
set(variant-lite_nonstd_variant-lite_FRAMEWORK_DIRS_DEBUG )
set(variant-lite_nonstd_variant-lite_FRAMEWORKS_DEBUG )
set(variant-lite_nonstd_variant-lite_DEPENDENCIES_DEBUG )
set(variant-lite_nonstd_variant-lite_SHARED_LINK_FLAGS_DEBUG )
set(variant-lite_nonstd_variant-lite_EXE_LINK_FLAGS_DEBUG )
set(variant-lite_nonstd_variant-lite_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(variant-lite_nonstd_variant-lite_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${variant-lite_nonstd_variant-lite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${variant-lite_nonstd_variant-lite_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${variant-lite_nonstd_variant-lite_EXE_LINK_FLAGS_DEBUG}>
)
set(variant-lite_nonstd_variant-lite_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${variant-lite_nonstd_variant-lite_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${variant-lite_nonstd_variant-lite_COMPILE_OPTIONS_C_DEBUG}>")