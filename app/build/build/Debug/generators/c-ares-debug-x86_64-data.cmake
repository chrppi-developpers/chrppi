########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND c-ares_COMPONENT_NAMES c-ares::cares)
list(REMOVE_DUPLICATES c-ares_COMPONENT_NAMES)
set(c-ares_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(c-ares_PACKAGE_FOLDER_DEBUG "/home/quentin/.conan2/p/b/c-are30ddf1d94dd73/p")
set(c-ares_BUILD_MODULES_PATHS_DEBUG )


set(c-ares_INCLUDE_DIRS_DEBUG )
set(c-ares_RES_DIRS_DEBUG )
set(c-ares_DEFINITIONS_DEBUG "-DCARES_STATICLIB")
set(c-ares_SHARED_LINK_FLAGS_DEBUG )
set(c-ares_EXE_LINK_FLAGS_DEBUG )
set(c-ares_OBJECTS_DEBUG )
set(c-ares_COMPILE_DEFINITIONS_DEBUG "CARES_STATICLIB")
set(c-ares_COMPILE_OPTIONS_C_DEBUG )
set(c-ares_COMPILE_OPTIONS_CXX_DEBUG )
set(c-ares_LIB_DIRS_DEBUG "${c-ares_PACKAGE_FOLDER_DEBUG}/lib")
set(c-ares_BIN_DIRS_DEBUG )
set(c-ares_LIBRARY_TYPE_DEBUG STATIC)
set(c-ares_IS_HOST_WINDOWS_DEBUG 0)
set(c-ares_LIBS_DEBUG cares)
set(c-ares_SYSTEM_LIBS_DEBUG rt)
set(c-ares_FRAMEWORK_DIRS_DEBUG )
set(c-ares_FRAMEWORKS_DEBUG )
set(c-ares_BUILD_DIRS_DEBUG )
set(c-ares_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(c-ares_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${c-ares_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${c-ares_COMPILE_OPTIONS_C_DEBUG}>")
set(c-ares_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${c-ares_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${c-ares_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${c-ares_EXE_LINK_FLAGS_DEBUG}>")


set(c-ares_COMPONENTS_DEBUG c-ares::cares)
########### COMPONENT c-ares::cares VARIABLES ############################################

set(c-ares_c-ares_cares_INCLUDE_DIRS_DEBUG )
set(c-ares_c-ares_cares_LIB_DIRS_DEBUG "${c-ares_PACKAGE_FOLDER_DEBUG}/lib")
set(c-ares_c-ares_cares_BIN_DIRS_DEBUG )
set(c-ares_c-ares_cares_LIBRARY_TYPE_DEBUG STATIC)
set(c-ares_c-ares_cares_IS_HOST_WINDOWS_DEBUG 0)
set(c-ares_c-ares_cares_RES_DIRS_DEBUG )
set(c-ares_c-ares_cares_DEFINITIONS_DEBUG "-DCARES_STATICLIB")
set(c-ares_c-ares_cares_OBJECTS_DEBUG )
set(c-ares_c-ares_cares_COMPILE_DEFINITIONS_DEBUG "CARES_STATICLIB")
set(c-ares_c-ares_cares_COMPILE_OPTIONS_C_DEBUG "")
set(c-ares_c-ares_cares_COMPILE_OPTIONS_CXX_DEBUG "")
set(c-ares_c-ares_cares_LIBS_DEBUG cares)
set(c-ares_c-ares_cares_SYSTEM_LIBS_DEBUG rt)
set(c-ares_c-ares_cares_FRAMEWORK_DIRS_DEBUG )
set(c-ares_c-ares_cares_FRAMEWORKS_DEBUG )
set(c-ares_c-ares_cares_DEPENDENCIES_DEBUG )
set(c-ares_c-ares_cares_SHARED_LINK_FLAGS_DEBUG )
set(c-ares_c-ares_cares_EXE_LINK_FLAGS_DEBUG )
set(c-ares_c-ares_cares_NO_SONAME_MODE_DEBUG FALSE)

# COMPOUND VARIABLES
set(c-ares_c-ares_cares_LINKER_FLAGS_DEBUG
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${c-ares_c-ares_cares_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${c-ares_c-ares_cares_SHARED_LINK_FLAGS_DEBUG}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${c-ares_c-ares_cares_EXE_LINK_FLAGS_DEBUG}>
)
set(c-ares_c-ares_cares_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${c-ares_c-ares_cares_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${c-ares_c-ares_cares_COMPILE_OPTIONS_C_DEBUG}>")