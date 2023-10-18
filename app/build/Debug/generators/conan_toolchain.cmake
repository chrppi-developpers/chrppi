

# Conan automatically generated toolchain file
# DO NOT EDIT MANUALLY, it will be overwritten

# Avoid including toolchain file several times (bad if appending to variables like
#   CMAKE_CXX_FLAGS. See https://github.com/android/ndk/issues/323
include_guard()

message(STATUS "Using Conan toolchain: ${CMAKE_CURRENT_LIST_FILE}")

if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeToolchain' generator only works with CMake >= 3.15")
endif()










string(APPEND CONAN_CXX_FLAGS " -m64")
string(APPEND CONAN_C_FLAGS " -m64")
string(APPEND CONAN_SHARED_LINKER_FLAGS " -m64")
string(APPEND CONAN_EXE_LINKER_FLAGS " -m64")

add_compile_definitions(_GLIBCXX_USE_CXX11_ABI=0)


message(STATUS "Conan toolchain: C++ Standard 20 with extensions ON")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Extra c, cxx, linkflags and defines


if(DEFINED CONAN_CXX_FLAGS)
  string(APPEND CMAKE_CXX_FLAGS_INIT " ${CONAN_CXX_FLAGS}")
endif()
if(DEFINED CONAN_C_FLAGS)
  string(APPEND CMAKE_C_FLAGS_INIT " ${CONAN_C_FLAGS}")
endif()
if(DEFINED CONAN_SHARED_LINKER_FLAGS)
  string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${CONAN_SHARED_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_EXE_LINKER_FLAGS)
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${CONAN_EXE_LINKER_FLAGS}")
endif()

get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(_CMAKE_IN_TRY_COMPILE)
    message(STATUS "Running toolchain IN_TRY_COMPILE")
    return()
endif()

set(CMAKE_FIND_PACKAGE_PREFER_CONFIG ON)

# Definition of CMAKE_MODULE_PATH
list(PREPEND CMAKE_MODULE_PATH "/home/app/.conan2/p/b/opens29f67cd7a04d0/p/lib/cmake")
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The explicitly defined "builddirs" of "host" context dependencies must be in PREFIX_PATH
list(PREPEND CMAKE_PREFIX_PATH "/home/app/.conan2/p/b/opens29f67cd7a04d0/p/lib/cmake")
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_LIBRARY_PATH "/home/app/.conan2/p/b/drogo76dffe311189a/p/lib" "/home/app/.conan2/p/b/trant9dd54ecfcb264/p/lib" "/home/app/.conan2/p/b/c-are56401226f36e1/p/lib" "/home/app/.conan2/p/b/jsonc2940d1f3b081e/p/lib" "/home/app/.conan2/p/b/opens29f67cd7a04d0/p/lib" "/home/app/.conan2/p/b/util-d716a76014899/p/lib" "/home/app/.conan2/p/b/jinja4ef84b9f71c16/p/lib" "/home/app/.conan2/p/b/boost6e5a4792108c1/p/lib" "/home/app/.conan2/p/b/zlib8f2e90f7931f3/p/lib" "/home/app/.conan2/p/b/bzip247d5faf18263f/p/lib" "/home/app/.conan2/p/b/libba8ce49aef0bae6/p/lib" "/home/app/.conan2/p/rapid4cabb31a09329/p/lib" "/home/app/.conan2/p/b/fmt1e3034d960059/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/home/app/.conan2/p/b/drogo76dffe311189a/p/include" "/home/app/.conan2/p/b/trant9dd54ecfcb264/p/include" "/home/app/.conan2/p/b/c-are56401226f36e1/p/include" "/home/app/.conan2/p/b/jsonc2940d1f3b081e/p/include" "/home/app/.conan2/p/b/opens29f67cd7a04d0/p/include" "/home/app/.conan2/p/b/util-d716a76014899/p/include" "/home/app/.conan2/p/b/util-d716a76014899/p/include/uuid" "/home/app/.conan2/p/b/jinja4ef84b9f71c16/p/include" "/home/app/.conan2/p/b/boost6e5a4792108c1/p/include" "/home/app/.conan2/p/b/zlib8f2e90f7931f3/p/include" "/home/app/.conan2/p/b/bzip247d5faf18263f/p/include" "/home/app/.conan2/p/b/libba8ce49aef0bae6/p/include" "/home/app/.conan2/p/expeca6c3c5a6cc8d3/p/include" "/home/app/.conan2/p/optioe6869b41bf51b/p/include" "/home/app/.conan2/p/rapid4cabb31a09329/p/include" "/home/app/.conan2/p/strin06e2118a14c4c/p/include" "/home/app/.conan2/p/varia4f720eaf9ec7d/p/include" "/home/app/.conan2/p/nlohm552351c8663ae/p/include" "/home/app/.conan2/p/b/fmt1e3034d960059/p/include")



if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:")
endif()




# Variables
# Variables  per configuration


# Preprocessor definitions
# Preprocessor definitions per configuration
