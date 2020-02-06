gitache_config(
  GIT_REPOSITORY
    "https://github.com/CarloWood/libcwd.git"
  GIT_TAG
    "master"
  CMAKE_ARGS
    "-DEnableLibcwdLocation:BOOL=ON -DEnableLibcwdAlloc:BOOL=OFF -DPATHS=\"/usr/bin;/home/carlo/bin\""
)
