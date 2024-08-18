
if (WITH_PAM)

	pkg_check_modules(pam REQUIRED pam)

	find_path(LIBPAM_INCLUDE_DIR
		/usr/include
		/usr/include/security
		/usr/local/include
		/usr/local/include/security)

	include_directories(${pam_INCLUDE_DIRS})
	link_directories(${pam_LIBRARY_DIRS})
	link_libraries(${pam_LINK_LIBRARIES})

	set(HAVE_PAM ON CACHE BOOL "")

else()
	set(HAVE_PAM OFF CACHE BOOL "")
endif(WITH_PAM)
