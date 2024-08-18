
if (WITH_LZ4)

	add_library(lz4-static STATIC ${SOURCE_DIR}/lzs.c ${SOURCE_DIR}/lzs.h)

	pkg_check_modules(lz4 liblz4)

	if (lz4_FOUND)
		add_library(lz4-static STATIC ${SOURCE_DIR}/lzs.c ${SOURCE_DIR}/lzs.h)
		link_libraries(${lz4_LINK_LIBRARIES} lz4-static)
	else()
		find_library(LIBEV_LIBRARY REQUIRED NAMES lz4)
		link_libraries(${LIBEV_LIBRARY} lz4-static)
	endif()

	set(HAVE_LZ4 ON CACHE BOOL "")
else()
	unset(ENABLE_COMPRESSION CACHE)
	set(HAVE_LZ4 OFF CACHE BOOL "")
	set(ENABLE_COMPRESSION OFF CACHE BOOL "")
endif(WITH_LZ4)
