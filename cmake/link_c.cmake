
if (NOT LIBC_LIBRARY)

	find_library(LIBC_LIBRARY REQUIRED NAMES c)
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE c)

	set(HAVE_LIBC ON CACHE BOOL "")
	check_symbol_exists(gnu_get_libc_version gnu/libc-version.h TRY_SHA2_CRYPT)
	if (TRY_SHA2_CRYPT)
		set(HAVE_GLIBC ON CACHE BOOL "")
	else()
		set(HAVE_GLIBC OFF CACHE BOOL "")
	endif()

endif()
