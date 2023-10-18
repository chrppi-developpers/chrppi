cmake_minimum_required(VERSION 3.22.1)

# Set project name
project(chrppi)

# Fail compilation at many warning
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror -Wfatal-errors -Wshadow")

# Setup conan
include(${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}/generators/conan_toolchain.cmake)

# Build CSP views (https://drogonframework.github.io/drogon-docs/#/ENG-06-View?id=automated-processing-of-csp-files)
FILE(GLOB SCP_LIST ${CMAKE_CURRENT_SOURCE_DIR}/source/views/*.csp)
foreach(csp_file ${SCP_LIST})
    message(STATUS "csp_file:" ${csp_file})
    EXEC_PROGRAM(basename ARGS "-s .csp ${csp_file}" OUTPUT_VARIABLE class_name)
    message(STATUS "view class_name:" ${class_name})
    add_custom_command(OUTPUT ${class_name}.h ${class_name}.cc
        COMMAND drogon_ctl
        ARGS create view ${csp_file}
        DEPENDS ${csp_file}
        VERBATIM )
   set(VIEWS_SRC ${VIEWS_SRC} ${class_name}.cc)
endforeach()

# Generate the executable
add_executable(${PROJECT_NAME} 
    source/main.cpp
    source/controllers/Index.cpp
    ${VIEWS_SRC}
)

# Link Drogon to the executable
find_package(Drogon CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Drogon::Drogon)