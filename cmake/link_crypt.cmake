
pkg_check_modules(crypt libcrypt)
if (crypt_FOUND)

	include_directories(${crypt_INCLUDE_DIRS})
	link_directories(${crypt_LIBRARY_DIRS})
	link_libraries(${crypt_LINK_LIBRARIES})
	set(HAVE_LIBCRYPT ON CACHE BOOL "")

else()

	find_library(CRYPT_LIBRARY REQUIRED NAMES crypt)
	find_path(CRYPT_INCLUDE_DIR REQUIRED NAMES crypt.h
		/usr/include
		/usr/local/include)

	include_directories(${LIBEV_INCLUDE_DIR})
	link_libraries(${CRYPT_LIBRARY})

	set(HAVE_LIBCRYPT ON CACHE BOOL "")

endif (crypt_FOUND)
