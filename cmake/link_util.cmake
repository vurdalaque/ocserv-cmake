
if (WITH_UTMP)

	if (NOT LIBUTIL_LIBRARY)

		find_library(LIBUTIL_LIBRARY REQUIRED NAMES util)

		set(HAVE_LIBUTIL ON CACHE BOOL "")
		link_libraries(libutil.a)

	endif(NOT LIBUTIL_LIBRARY)
else()
	set(HAVE_LIBUTIL OFF CACHE BOOL "")
endif()
