cmake_minimum_required(VERSION 3.14...3.16)

message(STATUS "This is gitache")

project(gitache
  LANGUAGES NONE
  DESCRIPTION "The gate way to git-cache."
)

# This project uses aicxx modules.
include(cwm4/cmake/AICxxProject)
