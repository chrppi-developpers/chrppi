

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
list(PREPEND CMAKE_MODULE_PATH "/home/quentin/.conan2/p/b/opens723fc04b35bf9/p/lib/cmake")
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The explicitly defined "builddirs" of "host" context dependencies must be in PREFIX_PATH
list(PREPEND CMAKE_PREFIX_PATH "/home/quentin/.conan2/p/b/opens723fc04b35bf9/p/lib/cmake")
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_LIBRARY_PATH "/home/quentin/.conan2/p/b/drogoe13c2ac524dca/p/lib" "/home/quentin/.conan2/p/b/trantc2947e1ce2550/p/lib" "/home/quentin/.conan2/p/b/c-are30ddf1d94dd73/p/lib" "/home/quentin/.conan2/p/b/jsonc741a45059b091/p/lib" "/home/quentin/.conan2/p/b/opens723fc04b35bf9/p/lib" "/home/quentin/.conan2/p/b/util-c596788a55757/p/lib" "/home/quentin/.conan2/p/b/jinja76bedfa1c0715/p/lib" "/home/quentin/.conan2/p/b/booste901c31ce3cff/p/lib" "/home/quentin/.conan2/p/b/zlib6d77f67804b47/p/lib" "/home/quentin/.conan2/p/b/bzip2884132f6b933e/p/lib" "/home/quentin/.conan2/p/b/libba35b5886b669f5/p/lib" "/home/quentin/.conan2/p/rapid4cabb31a09329/p/lib" "/home/quentin/.conan2/p/b/fmtd06fbe0be681c/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/home/quentin/.conan2/p/b/drogoe13c2ac524dca/p/include" "/home/quentin/.conan2/p/b/trantc2947e1ce2550/p/include" "/home/quentin/.conan2/p/b/c-are30ddf1d94dd73/p/include" "/home/quentin/.conan2/p/b/jsonc741a45059b091/p/include" "/home/quentin/.conan2/p/b/opens723fc04b35bf9/p/include" "/home/quentin/.conan2/p/b/util-c596788a55757/p/include" "/home/quentin/.conan2/p/b/util-c596788a55757/p/include/uuid" "/home/quentin/.conan2/p/b/jinja76bedfa1c0715/p/include" "/home/quentin/.conan2/p/b/booste901c31ce3cff/p/include" "/home/quentin/.conan2/p/b/zlib6d77f67804b47/p/include" "/home/quentin/.conan2/p/b/bzip2884132f6b933e/p/include" "/home/quentin/.conan2/p/b/libba35b5886b669f5/p/include" "/home/quentin/.conan2/p/expeca6c3c5a6cc8d3/p/include" "/home/quentin/.conan2/p/optioe6869b41bf51b/p/include" "/home/quentin/.conan2/p/rapid4cabb31a09329/p/include" "/home/quentin/.conan2/p/strin06e2118a14c4c/p/include" "/home/quentin/.conan2/p/varia4f720eaf9ec7d/p/include" "/home/quentin/.conan2/p/nlohm552351c8663ae/p/include" "/home/quentin/.conan2/p/b/fmtd06fbe0be681c/p/include")



if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:")
endif()




# Variables
# Variables  per configuration


# Preprocessor definitions
# Preprocessor definitions per configuration
