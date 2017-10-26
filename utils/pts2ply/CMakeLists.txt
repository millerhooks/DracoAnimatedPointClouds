cmake_minimum_required(VERSION 3.8)
project(pts2ply)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES main.cpp)
add_executable(pts2ply ${SOURCE_FILES})