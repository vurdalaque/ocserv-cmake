
if (NOT WRAP_LIBRARY)
	set(HAVE_LIBWRAP OFF CACHE BOOL "")

	find_library(LIBNL_LIBRARY NAMES libwrap)
endif()
