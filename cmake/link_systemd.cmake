
if (WITH_SYSTEMD)

	pkg_check_modules(systemd REQUIRED systemd)

	link_libraries(systemd)

	set(HAVE_LIBSYSTEMD ON CACHE BOOL "")

else()
	set(HAVE_LIBSYSTEMD OFF CACHE BOOL "")
endif()
