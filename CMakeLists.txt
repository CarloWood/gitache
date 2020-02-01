cmake_minimum_required(VERSION 3.14...3.16)

project(gitache
  LANGUAGES NONE
  DESCRIPTION "The gateway to gitache-core."
)

# Each gitache commit is directly linked to a certain gitache-core commit,
# so that if you do not change gitache version (sha1) you also won't get
# a different gitache-core.
set(GITACHE_CORE_SHA1 "master")

string(ASCII 27 _escape)
set(_red "${_escape}[31m")
set(_reset "${_escape}[m")

if (DEFINED ENV{GITACHE_ROOT})
  set(GITACHE_ROOT $ENV{GITACHE_ROOT} CACHE INTERNAL "")
  message(STATUS "GITACHE_ROOT = \"${GITACHE_ROOT}\"\n** Populating gitache:")
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
  # The following lock is obtain while cloning and/or updating the gitache-clone repository.
  file(LOCK ${GITACHE_DIR} DIRECTORY
     RESULT_VARIABLE _result
     TIMEOUT 60)
  message(STATUS "result = ${_result}")
  ctest_sleep(10)
else ()
  message(STATUS "Environment variable GITACHE_ROOT is not set: ${_red}gitache disabled${_reset}.")
endif ()
