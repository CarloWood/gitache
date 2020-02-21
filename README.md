This is still work in progress.

Usage, add to the CMakeLists.txt of the main project, after its `project` line:

    include(FetchContent)  
    
    set(GITACHE_PACKAGES libcwd_r)  
    FetchContent_Declare(  
      gitache  
      GIT_REPOSITORY "https://github.com/CarloWood/gitache.git"  
      GIT_TAG        "master"  
    )
    FetchContent_MakeAvailable(gitache)  

And if you're paranoid, replace `master` with a git commit sha1.

Note that the minimum cmake version required is 3.14.
