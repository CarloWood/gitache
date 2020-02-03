cmake_minimum_required(VERSION 3.14...3.16)

string(ASCII 27 _escape)
set(_red "${_escape}[31m")
set(_reset "${_escape}[m")

# If the environment variable GITACHE_ROOT is not set then gitache is disabled.
if (NOT DEFINED ENV{GITACHE_ROOT})
  message(STATUS "Environment variable GITACHE_ROOT is not set: ${_red}gitache disabled${_reset}.")
  return()
endif ()
set(GITACHE_ROOT $ENV{GITACHE_ROOT} CACHE INTERNAL "")

project(gitache
  LANGUAGES NONE
  DESCRIPTION "The gateway to gitache-core."
)

# Each gitache sha1 (commit) is directly linked to a certain gitache-core commit, so that if you do not
# change gitache version (sha1) you also won't get a different gitache-core.
set(GITACHE_CORE_SHA1 "$ENV{GITACHE_CORE_SHA1}") # FIXME: this should be a fixed SHA1.
set(GITACHE_CORE_GIT_REPOSITORY "file:///home/carlo/projects/aicxx/ai-statefultask-testsuite/gitache-core")
set(GITACHE_CORE_DIR "${GITACHE_ROOT}/gitache-core" CACHE INTERNAL "")

function(fetch_gitache_core)
  # The following lock is obtained while cloning and/or updating the gitache-core repository.
  message(STATUS "Locking \"${GITACHE_CORE_DIR}\"...")
  file(LOCK ${GITACHE_CORE_DIR} DIRECTORY
     GUARD FILE
     RESULT_VARIABLE _error_result
     TIMEOUT 10
  )
  if (_error_result)
    message(FATAL_ERROR "  ${_error_result}.")
  endif ()
  message(STATUS "  success.\n** Populating \"${GITACHE_CORE_DIR}\" with ${GITACHE_CORE_SHA1}.")
  FetchContent_Populate(gitache-core
    QUIET
    GIT_REPOSITORY "${GITACHE_CORE_GIT_REPOSITORY}"
    GIT_TAG        "${GITACHE_CORE_SHA1}"
    SUBBUILD_DIR   "${GITACHE_CORE_DIR}/subbuild"
    SOURCE_DIR     "${GITACHE_CORE_DIR}/source"
  )
  message(STATUS "Unlocking \"${GITACHE_CORE_DIR}\".")
endfunction()

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
if (NOT EXISTS ${GITACHE_CORE_DIR})
  message(STATUS "Creating \"${GITACHE_CORE_DIR}\".")
  file(MAKE_DIRECTORY ${GITACHE_CORE_DIR})
  if (NOT EXISTS ${GITACHE_CORE_DIR})
    message(FATAL_ERROR "Please make GITACHE_ROOT writable for current user.")
  endif ()
  # Fetch gitache-core for the first time.
  fetch_gitache_core()
endif ()

# Pass control to gitache-core. If "main.cmake" is reloaded we do the include twice.
set(GITACHE_NEED_INCLUDE TRUE CACHE INTERNAL "")
while (GITACHE_NEED_INCLUDE)
  set(GITACHE_NEED_INCLUDE FALSE CACHE INTERNAL "")
  include("${GITACHE_CORE_DIR}/source/main.cmake")
return()
  if (GITACHE_NEED_INCLUDE)
    message(DEBUG "Gitache-core was updated: reloading \"${GITACHE_CORE_DIR}/source/main.cmake\"!")
  endif ()
endwhile ()
