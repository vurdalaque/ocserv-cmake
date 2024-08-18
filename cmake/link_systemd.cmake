
if (WITH_SYSTEMD)

	pkg_check_modules(systemd systemd)
	if (systemd_FOUND)

		link_libraries(systemd)
	else()

		find_library(SYSTEMD_LIBRARY REQUIRED NAMES systemd)
		find_path(SYSTEMD_INCLUDE_DIR REQUIRED NAMES sd-daemon.h PATHS
			/usr/include/systemd
			/usr/local/include/systemd
		)
		link_libraries(systemd)

	endif()

	set(HAVE_LIBSYSTEMD ON CACHE BOOL "")

else()
	set(HAVE_LIBSYSTEMD OFF CACHE BOOL "")
endif()
