cmake_minimum_required(VERSION 3.14)

if (NOT DEFINED GITACHE_PACKAGES)
  message(FATAL_ERROR "GITACHE_PACKAGES must be set to a list of packages before including gitache/gateway.cmake.")
endif ()

include(FetchContent)  

set(FETCHCONTENT_SOURCE_DIR_GITACHE "gitache" CACHE INTERNAL "" FORCE)  
FetchContent_Declare(gitache)
FetchContent_MakeAvailable(gitache)  
