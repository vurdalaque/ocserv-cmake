
pkg_check_modules(lz4 liblz4)
if (lz4_FOUND)
	target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${lz4_INCLUDE_DIRS})
	target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${lz4_LIBRARY_DIRS})
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${lz4_LINK_LIBRARIES})
	set(HAVE_LZ4 ON CACHE BOOL "")

	list(APPEND SOURCES ${SOURCE_DIR}/lzs.c ${SOURCE_DIR}/lzs.h)
else()
	message(STATUS "*** lz4 not found. Will disable compression support.")
	set(HAVE_LZ4 OFF CACHE BOOL "")
endif()
