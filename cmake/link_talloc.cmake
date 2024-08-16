
pkg_check_modules(talloc talloc)
if (talloc_FOUND)
	target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${talloc_INCLUDE_DIRS})
	target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${talloc_LIBRARY_DIRS})
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${talloc_LINK_LIBRARIES})
	set(HAVE_LIBTALLOC ON CACHE BOOL "")
	set(WITH_LOCAL_TALLOC OFF CACHE BOOL "")
else()
	message(STATUS "*** libtalloc was not found. An included version of talloc will be used.")

	add_library(talloc-static STATIC
		${SOURCE_DIR}/ccan/talloc/talloc.c
		${SOURCE_DIR}/ccan/talloc/talloc.h
		${SOURCE_DIR}/ccan/compiler/compiler.h
		${SOURCE_DIR}/ccan/typesafe_cb/typesafe_cb.h)

	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE talloc-static)
	set(HAVE_LIBTALLOC ON CACHE BOOL "")
	set(WITH_LOCAL_TALLOC ON CACHE BOOL "")
endif()
