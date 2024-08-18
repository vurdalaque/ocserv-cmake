
set(WORKER_SOURCES PRIVATE
	${CORE_SOURCES}

	http-heads.h

	${SOURCE_DIR}/html.c
	${SOURCE_DIR}/html.h
	${SOURCE_DIR}/worker.c
	${SOURCE_DIR}/worker.h
	${SOURCE_DIR}/worker-auth.c
	${SOURCE_DIR}/worker-bandwidth.c
	${SOURCE_DIR}/worker-bandwidth.h
	${SOURCE_DIR}/worker-http.c
	${SOURCE_DIR}/worker-http-handlers.c
	${SOURCE_DIR}/worker-kkdcp.c
	${SOURCE_DIR}/worker-misc.c
	${SOURCE_DIR}/worker-privs.c
	${SOURCE_DIR}/worker-proxyproto.c
	${SOURCE_DIR}/worker-resume.c
	${SOURCE_DIR}/worker-vpn.c
	${SOURCE_DIR}/worker-svc.c
	${SOURCE_DIR}/worker-tun.c
	${SOURCE_DIR}/isolate.c
	${SOURCE_DIR}/isolate.h
)

if (CAPTURE_LATENCY_SUPPORT)

	list(APPEND WORKER_SOURCES
		${SOURCE_DIR}/worker-latency.c
		${SOURCE_DIR}/worker-latency.h)

endif(CAPTURE_LATENCY_SUPPORT)

target_compile_definitions("${CMAKE_PROJECT_NAME}-worker" PRIVATE
    OCSERV_WORKER_PROCESS)

target_link_libraries("${CMAKE_PROJECT_NAME}-worker" PRIVATE
	common-static
	auth-static
	ccan-static)



















