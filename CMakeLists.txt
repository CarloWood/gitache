cmake_minimum_required(VERSION 3.14...3.16)

project(gitache
  LANGUAGES NONE
  DESCRIPTION "The gate way to git-cache."
)

string(ASCII 27 _escape)
set(_red "${_escape}[31m")
set(_reset "${_escape}[m")

if (DEFINED ENV{GITACHE_ROOT})
  set(GITACHE_ROOT $ENV{GITACHE_ROOT} CACHE INTERNAL "")
  message(STATUS "GITACHE_ROOT = \"${GITACHE_ROOT}\"\n** Loading gitache:")
  if (NOT IS_ABSOLUTE ${GITACHE_ROOT})
    message(FATAL_ERROR "GITACHE_ROOT must be an absolute path.")
  endif ()
  if (NOT EXISTS ${GITACHE_ROOT})
    message(FATAL_ERROR "${GITACHE_ROOT}: no such file or directory.")
  endif ()
  if (NOT IS_DIRECTORY ${GITACHE_ROOT})
    message(FATAL_ERROR "${GITACHE_ROOT}: not a directory.")
  endif ()
  # We're not testing if the directory is writable because cmake isn't supporting that
  # (other than creating a file). We'll just proceed and error out when it isn't.
  set(GITACHE_DIR "${GITACHE_ROOT}/gitcache" CACHE INTERNAL "")
  if (NOT EXISTS ${GITACHE_DIR})
    message(STATUS "Creating \"${GITACHE_DIR}\".")
    file(MAKE_DIRECTORY ${GITACHE_DIR})
    if (NOT EXISTS ${GITACHE_DIR})
      message(FATAL_ERROR "Please make GITACHE_ROOT writable for current user.")
    endif ()
  endif ()
else ()
  message(STATUS "Environment variable GITACHE_ROOT is not set: ${_red}gitache disabled${_reset}.")
endif ()
