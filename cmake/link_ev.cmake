
pkg_check_modules(ev REQUIRED libev)

include_directories(${ev_INCLUDE_DIRS})
link_directories(${ev_LIBRARY_DIRS})
link_libraries(${ev_LINK_LIBRARIES})

set(HAVE_LIBEV ON CACHE BOOL "")
