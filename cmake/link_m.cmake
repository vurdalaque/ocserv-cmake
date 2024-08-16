
if (NOT LIBM_LIBRARY)
	message(CHECK_START "Looking for libm")

	find_library (LIBM_LIBRARY NAMES m)
	if (LIBM_LIBRARY)
		set(HAVE_LIBM ON CACHE BOOL "")
		message(CHECK_PASS "found")
		target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE m)
	else()
		set(HAVE_LIBM OFF CACHE BOOL "")
		message(CHECK_FAIL "not found")
	endif()

endif(NOT LIBM_LIBRARY)

