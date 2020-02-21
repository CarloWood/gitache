** This is still work in progress **

# Usage

## Basic usage

Add to the `CMakeLists.txt` of the main project, after its `project()` line:

    include(FetchContent)  
    
    set(GITACHE_PACKAGES libcwd_r)  
    FetchContent_Declare(  
      gitache  
      GIT_REPOSITORY "https://github.com/CarloWood/gitache.git"  
      GIT_TAG        "stable"  
    )
    FetchContent_MakeAvailable(gitache)  

Where, if you're paranoid, you should replace `stable` with its
git commit sha1 (from the `stable` branch, the `master` branch might
be unstable).

Alternatively you can add gitache as a submodule to the root
of your project and replace all of the above with,

    include(${CMAKE_CURRENT_LIST_DIR}/gitache/gateway.cmake)

That will not update gitache automatically but simply use
whatever you have checked out.

## Requirements

The minimum cmake version required is 3.14.

Furthermore, the user must have the environment variable
`GITACHE_ROOT` set to a writable directory, or gitache will do
nothing except print the message:

    -- Environment variable GITACHE_ROOT is not set: gitache disabled.   

## Gitache developers

If you want to experiment with making changes to gitache itself,
and want to support both (a gitache submodule being present, or not) you
can use the first version above but add immediately after the `include(FetchContent)`
the following lines:

    # If a local gitache submodule is present then use that rather than downloading one.  
    if (EXISTS ${CMAKE_CURRENT_LIST_DIR}/gitache/.git)  
      # This will disable the use of the GIT_REPOSITORY/GIT_TAG below, and disable the  
      # FetchContent- download and update step. Instead, use the gitache submodule as-is.  
      set(FETCHCONTENT_SOURCE_DIR_GITACHE "gitache" CACHE INTERNAL "" FORCE)  
    endif ()

This more verbose version allows you to clone gitache in the root
of your project, without adding it to the project as a submodule, and
make changes to it as you see fit, to experiment, while users of the
project don't need a local gitache directory.
