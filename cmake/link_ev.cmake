
pkg_check_modules(ev libev)
if (ev_FOUND)

	include_directories(${ev_INCLUDE_DIRS})
	link_directories(${ev_LIBRARY_DIRS})
	link_libraries(${ev_LINK_LIBRARIES})

	set(HAVE_LIBEV ON CACHE BOOL "")

else()

	find_library(LIBEV_LIBRARY REQUIRED NAMES ev)
	find_path(LIBEV_INCLUDE_DIR REQUIRED NAMES ev.h)

	include_directories(${LIBEV_INCLUDE_DIR})
	link_libraries(${LIBEV_LIBRARY})

	set(HAVE_LIBEV ON CACHE BOOL "")

endif(ev_FOUND)
