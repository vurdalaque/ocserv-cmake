
if (WITH_SECCOMP)

	pkg_check_modules(seccomp REQUIRED libseccomp)

	include_directories(${seccomp_INCLUDE_DIRS})
	link_directories(${seccomp_LIBRARY_DIRS})
	link_libraries(${seccomp_LINK_LIBRARIES})

	set(HAVE_LIBSECCOMP ON CACHE BOOL "")

else()
	set(HAVE_LIBSECCOMP OFF CACHE BOOL "")
endif(WITH_SECCOMP)
