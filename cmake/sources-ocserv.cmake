
if (NOT EXISTS ${CMAKE_BINARY_DIR}/ocserv.conf)
	message(STATUS "copyiong configuration file")
	execute_process(
		COMMAND ${CMAKE_COMMAND} -E copy "${SOURCE_DIR}/../doc/sample.config" ${CMAKE_BINARY_DIR}/ocserv.conf)
endif()

set(SERVER_SOURCES
	${CORE_SOURCES}

# Sources
	${SOURCE_DIR}/main.c
	${SOURCE_DIR}/main-auth.c
	${SOURCE_DIR}/main-ban.c
	${SOURCE_DIR}/main-ban.h
	${SOURCE_DIR}/main-ctl-unix.c
	${SOURCE_DIR}/main-proc.c
	${SOURCE_DIR}/main-sec-mod-cmd.c
	${SOURCE_DIR}/main-user.c
	${SOURCE_DIR}/main-worker-cmd.c
	${SOURCE_DIR}/proc-search.c
	${SOURCE_DIR}/proc-search.h
	${SOURCE_DIR}/route-add.c
	${SOURCE_DIR}/route-add.h
	${SOURCE_DIR}/sec-mod.c
	${SOURCE_DIR}/sec-mod.h
	${SOURCE_DIR}/sec-mod-acct.h
	${SOURCE_DIR}/sec-mod-auth.c
	${SOURCE_DIR}/sec-mod-auth.h
	${SOURCE_DIR}/sec-mod-cookies.c
	${SOURCE_DIR}/sec-mod-db.c
	${SOURCE_DIR}/sec-mod-resume.c
	${SOURCE_DIR}/sec-mod-resume.h
	${SOURCE_DIR}/sec-mod-sup-config.c
	${SOURCE_DIR}/sec-mod-sup-config.h
	${SOURCE_DIR}/common/sockdiag.h
	${SOURCE_DIR}/common/sockdiag.c
	${SOURCE_DIR}/namespace.c
	${SOURCE_DIR}/main-log.c
	${SOURCE_DIR}/icmp-ping.c
	${SOURCE_DIR}/icmp-ping.h
	${SOURCE_DIR}/ip-lease.c
	${SOURCE_DIR}/ip-lease.h
	${SOURCE_DIR}/tun.c
	${SOURCE_DIR}/tun.h
	${SOURCE_DIR}/main-limits.c
	${SOURCE_DIR}/main-limits.h


	${CMAKE_BINARY_DIR}/ocserv.conf
)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
	common-static
	auth-static
	ccan-static
	acc-static
)

