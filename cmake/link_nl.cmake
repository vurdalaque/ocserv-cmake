
if (WITH_NL)

	find_library(LIBNL_LIBRARY REQUIRED NAMES nl-3 nl-route-3)
	find_path(LIBNL_INCLUDE_DIR netlink/netlink.h
		/usr/include
		/usr/include/libnl3
		/usr/local/include
		/usr/local/include/libnl3)

	set(HAVE_LIBNL ON CACHE BOOL "")
	include_directories(${LIBNL_INCLUDE_DIR})
	link_libraries(nl-3 nl-route-3)

else()
	set(HAVE_LIBNL OFF CACHE BOOL "")
endif(WITH_NL)
