

pkg_check_modules(pam pam)

if (pam_FOUND)
	find_path(LIBPAM_INCLUDE_DIR
		/usr/include
		/usr/include/security
		/usr/local/include
		/usr/local/include/security)

	target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${pam_INCLUDE_DIRS})
	target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${pam_LIBRARY_DIRS})
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${pam_LINK_LIBRARIES})
	set(HAVE_PAM ON CACHE BOOL "")
else()
	set(HAVE_PAM OFF CACHE BOOL "")
	message(CHECK_FAIL "*** libpam was not found. PAM support will be disabled. ")
endif()
