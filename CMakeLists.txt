cmake_minimum_required(VERSION 3.14...3.16)

message(STATUS "** Loading gitache:")

project(gitache
  LANGUAGES NONE
  DESCRIPTION "The gate way to git-cache."
)

if (DEFINED ENV{GITACHE_ROOT})
else ()
  message(STATUS "Environment variable GITACHE_ROOT is not set: gitache disabled.")
endif ()
