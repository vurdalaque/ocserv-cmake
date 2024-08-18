
find_library(NETTLE_LIBRARY REQUIRED NAMES nettle)
find_path(NETTLE_INCLUDE_DIR REQUIRED NAMES nettle-types.h PATHS
	/usr/include/nettle
	/usr/local/include/nettle)

include_directories(${NETTLE_INCLUDE_DIR})
link_libraries(${NETTLE_LIBRARY})

# pkg_check_modules(nettle nettle>=3.0)
#
# if (NOT nettle_FOUND)
# 	unset(nettle CACHE)
# 	pkg_check_modules(nettle REQUIRED nettle>=2.7)
#
# 	set(NETTLE_OLD_BASE64_API ON CACHE BOOL "")
# endif()
#
# include_directories(${nettle_INCLUDE_DIRS})
# link_directories(${nettle_LIBRARY_DIRS})
# link_libraries(${nettle_LINK_LIBRARIES})

