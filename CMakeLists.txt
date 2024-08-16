cmake_minimum_required(VERSION 3.20)

################################################################################
project(ocserv VERSION 1.3.0 LANGUAGES CXX C)


set(PACKAGE "ocserv" CACHE STRING "")
set(PACKAGE_NAME "OpenConnect VPN Server" CACHE STRING "")
set(PACKAGE_TARNAME "ocserv" CACHE STRING "")
set(PACKAGE_VERSION "${CMAKE_PROJECT_VERSION}" CACHE STRING "")
set(PACKAGE_STRING "OpenConnect VPN Server '${CMAKE_PROJECT_VERSION}'" CACHE STRING "")
set(PACKAGE_BUGREPORT "https://gitlab.com/openconnect/ocserv/-/issues" CACHE STRING "")
set(PACKAGE_URL "https://ocserv.openconnect-vpn.net/" )

set(GEOIP_LIBRARY "maxmind" CACHE STRING "") # geoip|maxmindb library
set(OCCTL_PAGER "less" CACHE STRING "") # occtcl_pager

set(ANYCONNECT_CLIENT_COMPAT ON CACHE BOOL "Enable Anyconnect compatibility")
set(CAPTURE_LATENCY_SUPPORT ON CACHE BOOL "Enable capturing latency stats")
set(ENABLE_ADAPTIVE_RATE_LIMIT_SUPPORT OFF CACHE BOOL "Enable adaptive rate limiting")
set(ENABLE_COMPRESSION ON CACHE BOOL "Compression support")
set(LINUX_NAMESPACES ON CACHE BOOL "Enable Linux namespaces")

set(TESTS_ENABLED OFF CACHE BOOL "Test enabled by default")

################################################################################

if (NOT PACKAGE_DOWNLOADED)
	include(FetchContent)
	FetchContent_Declare(
		${CMAKE_PROJECT_NAME}_src
		GIT_REPOSITORY https://gitlab.com/openconnect/ocserv.git
		GIT_TAG ${CMAKE_PROJECT_VERSION})

	FetchContent_MakeAvailable(${CMAKE_PROJECT_NAME}_src)

	set(PACKAGE_DOWNLOADED 1 CACHE BOOL INTERNAL FORCE)

	set(SOURCE_DIR ${${CMAKE_PROJECT_NAME}_src_SOURCE_DIR}/src CACHE STRING INTERNAL)

endif()

################################################################################

add_compile_options(-D_GNU_SOURCE=1 -Wall -Wno-strict-aliasing -Wextra
				-Wno-unused-parameter -Wno-sign-compare
				-Wno-missing-field-initializers -Wno-implicit-fallthrough
				-Wno-stringop-truncation)

add_executable(${CMAKE_PROJECT_NAME} WIN32)

# target_include_directories(${CMAKE_PROJECT_NAME} SYSTEM PRIVATE "${CMAKE_CURRENT_BINARY_DIR}")
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
	${CMAKE_CURRENT_BINARY_DIR}
	${Protobuf_INCLUDE_DIRS}
	${CMAKE_CURRENT_LIST_DIR}
	${SOURCE_DIR}
	${SOURCE_DIR}/common
)

set(SOURCES
# core sources
	${SOURCE_DIR}/common/hmac.c
	${SOURCE_DIR}/common/hmac.h
	${SOURCE_DIR}/common/snapshot.c
	${SOURCE_DIR}/common/snapshot.h
	${SOURCE_DIR}/common-config.h
	${SOURCE_DIR}/config.c
	${SOURCE_DIR}/config-kkdcp.c
	${SOURCE_DIR}/config-ports.c
	${SOURCE_DIR}/defs.h
	${SOURCE_DIR}/gettime.h
	${SOURCE_DIR}/inih/ini.c
	${SOURCE_DIR}/inih/ini.h
	${SOURCE_DIR}/ip-util.c
	${SOURCE_DIR}/ip-util.h
	${SOURCE_DIR}/main.h
	${SOURCE_DIR}/main-ctl.h
	${SOURCE_DIR}/script-list.h
	${SOURCE_DIR}/setproctitle.c
	${SOURCE_DIR}/setproctitle.h
	${SOURCE_DIR}/str.c
	${SOURCE_DIR}/str.h
	${SOURCE_DIR}/subconfig.c
	${SOURCE_DIR}/sup-config/file.c
	${SOURCE_DIR}/sup-config/file.h
	${SOURCE_DIR}/sup-config/radius.c
	${SOURCE_DIR}/sup-config/radius.h
	${SOURCE_DIR}/tlslib.c
	${SOURCE_DIR}/tlslib.h
	${SOURCE_DIR}/valid-hostname.c
	${SOURCE_DIR}/vasprintf.c
	${SOURCE_DIR}/vasprintf.h
	${SOURCE_DIR}/vhost.h
	${SOURCE_DIR}/vpn.h
	${SOURCE_DIR}/namespace.h
	${SOURCE_DIR}/worker-log.c

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

# libcommon.a
	${SOURCE_DIR}/common/common.c
	${SOURCE_DIR}/common/common.h
	${SOURCE_DIR}/common/system.c
	${SOURCE_DIR}/common/system.h
	${SOURCE_DIR}/common/cloexec.c
	${SOURCE_DIR}/common/cloexec.h
	${SOURCE_DIR}/common/base64-helper.c
	${SOURCE_DIR}/common/base64-helper.h
	${SOURCE_DIR}/log.c
	${SOURCE_DIR}/log.h

# libccan_a
	${SOURCE_DIR}/ccan/build_assert/build_assert.h
	${SOURCE_DIR}/ccan/check_type/check_type.h
	${SOURCE_DIR}/ccan/container_of/container_of.h
	${SOURCE_DIR}/ccan/hash/hash.c
	${SOURCE_DIR}/ccan/hash/hash.h
	${SOURCE_DIR}/ccan/htable/htable.c
	${SOURCE_DIR}/ccan/htable/htable.h
	${SOURCE_DIR}/ccan/htable/htable_type.h
	${SOURCE_DIR}/ccan/list/list.c
	${SOURCE_DIR}/ccan/list/list.h
	${SOURCE_DIR}/ccan/str/hex/hex.c
	${SOURCE_DIR}/ccan/str/hex/hex.h

# Authentication module sources
	${SOURCE_DIR}/auth/common.c
	${SOURCE_DIR}/auth/common.h
	${SOURCE_DIR}/auth/gssapi.c
	${SOURCE_DIR}/auth/gssapi.h
	${SOURCE_DIR}/auth/pam.c
	${SOURCE_DIR}/auth/pam.h
	${SOURCE_DIR}/auth/plain.c
	${SOURCE_DIR}/auth/plain.h
	${SOURCE_DIR}/auth/radius.c
	${SOURCE_DIR}/auth/radius.h
	${SOURCE_DIR}/auth-unix.c
	${SOURCE_DIR}/auth-unix.h

# ACCT_SOURCES
	${SOURCE_DIR}/acct/radius.c
	${SOURCE_DIR}/acct/radius.h
	${SOURCE_DIR}/acct/pam.c
	${SOURCE_DIR}/acct/pam.h
)

include(cmake/autoconf.cmake)
configure_file(config.h.in config.h @ONLY)

target_sources(${CMAKE_PROJECT_NAME} PRIVATE ${SOURCES})
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
	${Protobuf_INCLUDE_DIRS})

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
	${Protobuf_LIBRARIES})

################################################################################
include(cmake/conf_info.cmake)
