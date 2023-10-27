########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(jinja2cpp_COMPONENT_NAMES "")
list(APPEND jinja2cpp_FIND_DEPENDENCY_NAMES Boost expected-lite optional-lite RapidJSON string-view-lite variant-lite nlohmann_json fmt)
list(REMOVE_DUPLICATES jinja2cpp_FIND_DEPENDENCY_NAMES)
set(Boost_FIND_MODE "NO_MODULE")
set(expected-lite_FIND_MODE "NO_MODULE")
set(optional-lite_FIND_MODE "NO_MODULE")
set(RapidJSON_FIND_MODE "NO_MODULE")
set(string-view-lite_FIND_MODE "NO_MODULE")
set(variant-lite_FIND_MODE "NO_MODULE")
set(nlohmann_json_FIND_MODE "NO_MODULE")
set(fmt_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(jinja2cpp_PACKAGE_FOLDER_DEBUG "/home/quentin/.conan2/p/b/jinja76bedfa1c0715/p")
set(jinja2cpp_BUILD_MODULES_PATHS_DEBUG )


set(jinja2cpp_INCLUDE_DIRS_DEBUG "${jinja2cpp_PACKAGE_FOLDER_DEBUG}/include")
set(jinja2cpp_RES_DIRS_DEBUG )
set(jinja2cpp_DEFINITIONS_DEBUG )
set(jinja2cpp_SHARED_LINK_FLAGS_DEBUG )
set(jinja2cpp_EXE_LINK_FLAGS_DEBUG )
set(jinja2cpp_OBJECTS_DEBUG )
set(jinja2cpp_COMPILE_DEFINITIONS_DEBUG )
set(jinja2cpp_COMPILE_OPTIONS_C_DEBUG )
set(jinja2cpp_COMPILE_OPTIONS_CXX_DEBUG )
set(jinja2cpp_LIB_DIRS_DEBUG "${jinja2cpp_PACKAGE_FOLDER_DEBUG}/lib")
set(jinja2cpp_BIN_DIRS_DEBUG )
set(jinja2cpp_LIBRARY_TYPE_DEBUG STATIC)
set(jinja2cpp_IS_HOST_WINDOWS_DEBUG 0)
set(jinja2cpp_LIBS_DEBUG jinja2cpp)
set(jinja2cpp_SYSTEM_LIBS_DEBUG )
set(jinja2cpp_FRAMEWORK_DIRS_DEBUG )
set(jinja2cpp_FRAMEWORKS_DEBUG )
set(jinja2cpp_BUILD_DIRS_DEBUG )
set(jinja2cpp_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(jinja2cpp_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${jinja2cpp_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${jinja2cpp_COMPILE_OPTIONS_C_DEBUG}>")
set(jinja2cpp_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${jinja2cpp_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${jinja2cpp_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${jinja2cpp_EXE_LINK_FLAGS_DEBUG}>")


set(jinja2cpp_COMPONENTS_DEBUG )