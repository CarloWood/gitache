** This is still work in progress **

# Usage

## Basic usage

Add to the `CMakeLists.txt` of the main project, after its `project()` line:

    include(FetchContent)  
    
    set(GITACHE_PACKAGES libcwd_r)  # List of requested packages (example).
    FetchContent_Declare(  
      gitache  
      GIT_REPOSITORY "https://github.com/CarloWood/gitache.git"  
      GIT_TAG        "stable"  
    )
    FetchContent_MakeAvailable(gitache)  

Where, if you're paranoid, you should replace `stable` with its
git commit sha1 (from the `stable` branch, the `master` branch might
be unstable).

`GITACHE_PACKAGES` must be set to the list of packages that need
to be downloaded, configured and compiled (if not already in the cache).

Alternatively you can add gitache as a submodule to the root
of your project and replace all of the above with,

    set(GITACHE_PACKAGES libcwd_r)  # List of requested packages (example).
    include(gitache/gateway.cmake)

That will not update gitache automatically but simply use
whatever you have checked out.

## Requirements

The minimum cmake version required is 3.14.

Furthermore, the user must have the environment variable
`GITACHE_ROOT` set to a writable directory, or gitache will do
nothing except print the message:

    -- Environment variable GITACHE_ROOT is not set: gitache disabled.   

## Gitache developers

See the README.md of https://github.com/CarloWood/gitache-core
