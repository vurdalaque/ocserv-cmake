
if (WITH_TALLOC)
	pkg_check_modules(talloc talloc)

if (talloc_FOUND)
	include_directories(${talloc_INCLUDE_DIRS})
	link_directories(${talloc_LIBRARY_DIRS})
	link_libraries(${talloc_LINK_LIBRARIES})
else()

	find_library(TALLOC_LIBRARY REQUIRED NAMES talloc)
	find_path(TALLOC_INCLUDE_DIR REQUIRED NAMES talloc.h PATHS
		/usr/include/ /usr/local/include/)

	link_libraries(${TALLOC_LIBRARY})
	include_directories(${TALLOC_INCLUDE_DIR})

endif()

	set(HAVE_LIBTALLOC ON CACHE BOOL "")
	set(WITH_LOCAL_TALLOC OFF CACHE BOOL "")
else()
	# local build is broken, since ld cannot find symbols

	add_library(talloc-static STATIC
		${SOURCE_DIR}/ccan/talloc/talloc.c
		${SOURCE_DIR}/ccan/talloc/talloc.h
		${SOURCE_DIR}/ccan/compiler/compiler.h
		${SOURCE_DIR}/ccan/typesafe_cb/typesafe_cb.h)

	target_include_directories(talloc-static PRIVATE ${SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
	link_libraries(talloc-static)

	set(HAVE_LIBTALLOC ON CACHE BOOL "")
	set(WITH_LOCAL_TALLOC ON CACHE BOOL "")
endif()
