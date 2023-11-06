

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
list(PREPEND CMAKE_MODULE_PATH "/media/user/app/conan/home/p/b/opens95eaca4074f5b/p/lib/cmake")
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The explicitly defined "builddirs" of "host" context dependencies must be in PREFIX_PATH
list(PREPEND CMAKE_PREFIX_PATH "/media/user/app/conan/home/p/b/opens95eaca4074f5b/p/lib/cmake")
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_LIBRARY_PATH "/media/user/app/conan/home/p/b/drogo63a824968e9ad/p/lib" "/media/user/app/conan/home/p/b/trant16ec32940e59f/p/lib" "/media/user/app/conan/home/p/b/c-are5e81e060d846a/p/lib" "/media/user/app/conan/home/p/b/jsonc7ac960042638a/p/lib" "/media/user/app/conan/home/p/b/opens95eaca4074f5b/p/lib" "/media/user/app/conan/home/p/b/util-a9faba4d137c1/p/lib" "/media/user/app/conan/home/p/b/boost71475e3a5c5fa/p/lib" "/media/user/app/conan/home/p/b/zlib743a269a2aaea/p/lib" "/media/user/app/conan/home/p/b/bzip24f9067186e418/p/lib" "/media/user/app/conan/home/p/b/libbaa3de9d37d9d69/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/media/user/app/conan/home/p/b/drogo63a824968e9ad/p/include" "/media/user/app/conan/home/p/b/trant16ec32940e59f/p/include" "/media/user/app/conan/home/p/b/c-are5e81e060d846a/p/include" "/media/user/app/conan/home/p/b/jsonc7ac960042638a/p/include" "/media/user/app/conan/home/p/b/opens95eaca4074f5b/p/include" "/media/user/app/conan/home/p/b/util-a9faba4d137c1/p/include" "/media/user/app/conan/home/p/b/util-a9faba4d137c1/p/include/uuid" "/media/user/app/conan/home/p/b/boost71475e3a5c5fa/p/include" "/media/user/app/conan/home/p/b/zlib743a269a2aaea/p/include" "/media/user/app/conan/home/p/b/bzip24f9067186e418/p/include" "/media/user/app/conan/home/p/b/libbaa3de9d37d9d69/p/include")



if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:")
endif()




# Variables
# Variables  per configuration


# Preprocessor definitions
# Preprocessor definitions per configuration
