cmake_minimum_required(VERSION 3.14...3.16)

project(gitache
  LANGUAGES NONE
  DESCRIPTION "The gate way to git-cache."
)

string(ASCII 27 _escape)
set(_red "${_escape}[31m")
set(_reset "${_escape}[m")

if (DEFINED ENV{GITACHE_ROOT})
  message(STATUS "GITACHE_ROOT = \"$ENV{GITACHE_ROOT}\"\n** Loading gitache:")
else ()
  message(STATUS "Environment variable GITACHE_ROOT is not set: ${_red}gitache disabled${_reset}.")
endif ()
