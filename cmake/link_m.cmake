
if (WITH_M)

	find_library (LIBM_LIBRARY REQUIRED NAMES m)
	set(HAVE_LIBM ON CACHE BOOL "")
	link_libraries(m)

else()
	set(HAVE_LIBM OFF CACHE BOOL "")
	if (CAPTURE_LATENCY_SUPPORT)
		message(FATAL_ERROR "*** no libm found - capture latency stats must be disabled")
	endif(CAPTURE_LATENCY_SUPPORT)
endif(WITH_M)

