
pkg_check_modules(crypt libcrypt)

if (crypt_FOUND)
	target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${crypt_INCLUDE_DIRS})
	target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${crypt_LIBRARY_DIRS})
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${crypt_LINK_LIBRARIES})
	set(HAVE_LIBCRYPT ON CACHE BOOL "")
else()
	set(HAVE_LIBCRYPT OFF CACHE BOOL "")
endif()
