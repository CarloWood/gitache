cmake_minimum_required(VERSION 3.14...3.16)

project(gitache
  LANGUAGES NONE
  DESCRIPTION "The gate way to git-cache."
)

if (DEFINED ENV{GITACHE_ROOT})
  message(STATUS "GITACHE_ROOT = \"$ENV{GITACHE_ROOT}\"\n** Loading gitache:")
else ()
  message(STATUS "Environment variable GITACHE_ROOT is not set: gitache disabled.")
endif ()
