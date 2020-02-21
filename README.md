** This is still work in progress **

* Usage *

Add to the CMakeLists.txt of the main project, after its `project` line:

    include(FetchContent)  
    
    set(GITACHE_PACKAGES libcwd_r)  
    FetchContent_Declare(  
      gitache  
      GIT_REPOSITORY "https://github.com/CarloWood/gitache.git"  
      GIT_TAG        "stable"  
    )
    FetchContent_MakeAvailable(gitache)  

And if you're paranoid, replace `stable` with a git commit sha1
from the `stable` branch. The `master` branch might be unstable.

Note that the minimum cmake version required is 3.14.

Alternatively you can add gitache as a submodule to the root
of your project and replace the above with a simple:

    include(${CMAKE_CURRENT_LIST_DIR}/gitache/gateway.cmake)

That will not update gitache automatically but simply use
whatever you have checked out.

Last, if you want to experiment with making changes to gitache itself,
and want to support both (a gitache submodule being present, or not) you
can use the first version but add immediately after the `include(FetchContent)`
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
