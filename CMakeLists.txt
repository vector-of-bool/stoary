cmake_minimum_required(VERSION 3.6)
project(Stoary VERSION 0.0.1)

include(GetDLLs.cmake)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")

file(GLOB qt_dirs "C:/Qt*/5.*/*/")
message(STATUS "Qt directories: ${qt_dirs}")
list(APPEND CMAKE_PREFIX_PATH ${qt_dirs})
find_package(Qt5 REQUIRED Widgets Quick QuickControls2)

add_subdirectory(source)
