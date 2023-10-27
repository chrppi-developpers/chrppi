########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(drogon_COMPONENT_NAMES "")
list(APPEND drogon_FIND_DEPENDENCY_NAMES Trantor jsoncpp OpenSSL libuuid Boost ZLIB)
list(REMOVE_DUPLICATES drogon_FIND_DEPENDENCY_NAMES)
set(Trantor_FIND_MODE "NO_MODULE")
set(jsoncpp_FIND_MODE "NO_MODULE")
set(OpenSSL_FIND_MODE "NO_MODULE")
set(libuuid_FIND_MODE "NO_MODULE")
set(Boost_FIND_MODE "NO_MODULE")
set(ZLIB_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(drogon_PACKAGE_FOLDER_DEBUG "/home/quentin/.conan2/p/b/drogoe13c2ac524dca/p")
set(drogon_BUILD_MODULES_PATHS_DEBUG )


set(drogon_INCLUDE_DIRS_DEBUG "${drogon_PACKAGE_FOLDER_DEBUG}/include")
set(drogon_RES_DIRS_DEBUG )
set(drogon_DEFINITIONS_DEBUG )
set(drogon_SHARED_LINK_FLAGS_DEBUG )
set(drogon_EXE_LINK_FLAGS_DEBUG )
set(drogon_OBJECTS_DEBUG )
set(drogon_COMPILE_DEFINITIONS_DEBUG )
set(drogon_COMPILE_OPTIONS_C_DEBUG )
set(drogon_COMPILE_OPTIONS_CXX_DEBUG )
set(drogon_LIB_DIRS_DEBUG "${drogon_PACKAGE_FOLDER_DEBUG}/lib")
set(drogon_BIN_DIRS_DEBUG )
set(drogon_LIBRARY_TYPE_DEBUG STATIC)
set(drogon_IS_HOST_WINDOWS_DEBUG 0)
set(drogon_LIBS_DEBUG drogon)
set(drogon_SYSTEM_LIBS_DEBUG )
set(drogon_FRAMEWORK_DIRS_DEBUG )
set(drogon_FRAMEWORKS_DEBUG )
set(drogon_BUILD_DIRS_DEBUG )
set(drogon_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(drogon_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${drogon_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${drogon_COMPILE_OPTIONS_C_DEBUG}>")
set(drogon_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${drogon_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${drogon_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${drogon_EXE_LINK_FLAGS_DEBUG}>")


set(drogon_COMPONENTS_DEBUG )