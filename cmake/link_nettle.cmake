

pkg_check_modules(nettle nettle>=3.0)

if (NOT nettle_FOUND)
	unset(nettle CACHE)
	pkg_check_modules(nettle REQUIRED nettle>=2.7)

	set(NETTLE_OLD_BASE64_API ON CACHE BOOL "")
endif()

include_directories(${nettle_INCLUDE_DIRS})
link_directories(${nettle_LIBRARY_DIRS})
link_libraries(${nettle_LINK_LIBRARIES})

