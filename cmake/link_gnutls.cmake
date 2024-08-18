
pkg_check_modules(tls REQUIRED gnutls>=3.3.0)

include_directories(${tls_INCLUDE_DIRS})
link_directories(${tls_LIBRARY_DIRS})
link_libraries(${tls_LINK_LIBRARIES})

