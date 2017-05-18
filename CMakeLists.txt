cmake_minimum_required(VERSION 3.6)
project(Stoary VERSION 0.0.1)

file(GLOB qt_dirs "C:/Qt*/5.*/*/")
message(STATUS "Qt directories: ${qt_dirs}")
list(APPEND CMAKE_PREFIX_PATH ${qt_dirs})
find_package(Qt5 REQUIRED Quick QuickControls2)

