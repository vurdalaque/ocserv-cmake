
pkg_check_modules(tls gnutls>=3.3.0)

if (tls_FOUND)
	include_directories(${tls_INCLUDE_DIRS})
	link_directories(${tls_LIBRARY_DIRS})
	link_libraries(${tls_LINK_LIBRARIES})
else()

	find_library(TLS_LIBRARY REQUIRED NAMES gnutls)
	find_path(TLS_INCLUDE_DIR REQUIRED NAMES gnutls.h PATHS
		/usr/include/gnutls
		/usr/local/include/gnutls)
	link_libraries(${TLS_LIBRARY})
	include_directories(${TLS_INCLUDE_DIR})

endif()

