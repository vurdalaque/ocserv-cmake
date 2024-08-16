
if (NOT LIBNL_LIBRARY)

	message(CHECK_START "Looking for libnl")

	find_library(LIBNL_LIBRARY NAMES nl-3 nl-route-3)
	find_path(LIBNL_INCLUDE_DIR netlink/netlink.h
		/usr/include
		/usr/include/libnl3
		/usr/local/include
		/usr/local/include/libnl3)

	if (LIBNL_LIBRARY)
		set(HAVE_LIBNL ON CACHE BOOL "")
		message(CHECK_PASS "found")
		target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${LIBNL_INCLUDE_DIR})
		target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE nl-3 nl-route-3)
	else()
		set(HAVE_LIBNL OFF CACHE BOOL "")
		message(CHECK_FAIL "not found")
	endif()

endif (NOT LIBNL_LIBRARY)
