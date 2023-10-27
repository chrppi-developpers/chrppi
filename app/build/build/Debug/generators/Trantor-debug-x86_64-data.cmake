########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(trantor_COMPONENT_NAMES "")
list(APPEND trantor_FIND_DEPENDENCY_NAMES c-ares OpenSSL)
list(REMOVE_DUPLICATES trantor_FIND_DEPENDENCY_NAMES)
set(c-ares_FIND_MODE "NO_MODULE")
set(OpenSSL_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(trantor_PACKAGE_FOLDER_DEBUG "/home/quentin/.conan2/p/b/trantc2947e1ce2550/p")
set(trantor_BUILD_MODULES_PATHS_DEBUG )


set(trantor_INCLUDE_DIRS_DEBUG "${trantor_PACKAGE_FOLDER_DEBUG}/include")
set(trantor_RES_DIRS_DEBUG )
set(trantor_DEFINITIONS_DEBUG )
set(trantor_SHARED_LINK_FLAGS_DEBUG )
set(trantor_EXE_LINK_FLAGS_DEBUG )
set(trantor_OBJECTS_DEBUG )
set(trantor_COMPILE_DEFINITIONS_DEBUG )
set(trantor_COMPILE_OPTIONS_C_DEBUG )
set(trantor_COMPILE_OPTIONS_CXX_DEBUG )
set(trantor_LIB_DIRS_DEBUG "${trantor_PACKAGE_FOLDER_DEBUG}/lib")
set(trantor_BIN_DIRS_DEBUG )
set(trantor_LIBRARY_TYPE_DEBUG STATIC)
set(trantor_IS_HOST_WINDOWS_DEBUG 0)
set(trantor_LIBS_DEBUG trantor)
set(trantor_SYSTEM_LIBS_DEBUG pthread m)
set(trantor_FRAMEWORK_DIRS_DEBUG )
set(trantor_FRAMEWORKS_DEBUG )
set(trantor_BUILD_DIRS_DEBUG )
set(trantor_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(trantor_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${trantor_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${trantor_COMPILE_OPTIONS_C_DEBUG}>")
set(trantor_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${trantor_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${trantor_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${trantor_EXE_LINK_FLAGS_DEBUG}>")


set(trantor_COMPONENTS_DEBUG )