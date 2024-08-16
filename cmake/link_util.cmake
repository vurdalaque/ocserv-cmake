if (NOT LIBUTIL_LIBRARY)

	message(CHECK_START "Looking for libutil")

	find_library(LIBUTIL_LIBRARY NAMES util)
	if (LIBM_LIBRARY)
		set(HAVE_LIBUTIL ON CACHE BOOL "")
		message(CHECK_PASS "found")
		target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE libutil.a)
	else()
		set(HAVE_LIBUTIL OFF CACHE BOOL "")
		message(CHECK_FAILED "not found")
	endif()

endif(NOT LIBUTIL_LIBRARY)
