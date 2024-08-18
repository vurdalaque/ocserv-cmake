
if (HAVE_LIBREADLINE AND HAVE_LIBNL)

	add_executable(occtl
		${SOURCE_DIR}/occtl/occtl.c
		${SOURCE_DIR}/occtl/pager.c
		${SOURCE_DIR}/occtl/occtl.h
		${SOURCE_DIR}/occtl/time.c
		${SOURCE_DIR}/occtl/cache.c
		${SOURCE_DIR}/occtl/ip-cache.c
		${SOURCE_DIR}/occtl/nl.c
		${SOURCE_DIR}/occtl/ctl.h
		${SOURCE_DIR}/occtl/print.c
		${SOURCE_DIR}/occtl/json.c
		${SOURCE_DIR}/occtl/json.h
		${SOURCE_DIR}/occtl/unix.c
		${SOURCE_DIR}/occtl/geoip.h
		${SOURCE_DIR}/occtl/session-cache.c
	)

	if ("${GEOIP_LIBRARY}" STREQUAL "maxmind")
		target_sources(occtl PRIVATE "${SOURCE_DIR}/occtl/maxmind.c")
	else()
		target_sources(occtl PRIVATE "${SOURCE_DIR}/occtl/geoip.c")
	endif()

	target_compile_definitions(occtl PRIVATE
		VERSION="${CMAKE_PROJECT_VERSION}")

	target_link_libraries(occtl PRIVATE
		readline
		common-static
		ccan-static)

	install(TARGETS occtl
		DESTINATION ${CMAKE_INSTALL_PREFIX}
		COMPONENT binaries)

else()
	message(STATUS "*** occtl build skipped")
endif()
