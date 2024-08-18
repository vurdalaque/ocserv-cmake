
if (WITH_LZ4)
	pkg_check_modules(lz4 REQUIRED liblz4)

	set(HAVE_LZ4 ON CACHE BOOL "")

	add_library(lz4-static STATIC ${SOURCE_DIR}/lzs.c ${SOURCE_DIR}/lzs.h)

	include_directories(${lz4_INCLUDE_DIRS})
	link_directories(${lz4_LIBRARY_DIRS})
	link_libraries(${lz4_LINK_LIBRARIES} lz4-static)
else()
	unset(ENABLE_COMPRESSION CACHE)
	set(HAVE_LZ4 OFF CACHE BOOL "")
	set(ENABLE_COMPRESSION OFF CACHE BOOL "")
endif(WITH_LZ4)
