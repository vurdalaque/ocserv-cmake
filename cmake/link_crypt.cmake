
pkg_check_modules(crypt REQUIRED libcrypt)

include_directories(${crypt_INCLUDE_DIRS})
link_directories(${crypt_LIBRARY_DIRS})
link_libraries(${crypt_LINK_LIBRARIES})

set(HAVE_LIBCRYPT ON CACHE BOOL "")
