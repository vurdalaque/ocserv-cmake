cmake_minimum_required(VERSION 3.20)

################################################################################
project(ocserv VERSION 1.3.0 LANGUAGES CXX C)

set(WITH_SECCOMP OFF CACHE BOOL "filtered syscalls will fail with a signal")
set(WITH_PROTOBUF OFF CACHE BOOL "use the system protobuf-c library")
set(WITH_GSSAPI OFF CACHE BOOL "enable support for GSSAPI authentication")
set(WITH_LZ4 OFF CACHE BOOL "enable support for LZ4 compression")
set(WITH_PAM OFF CACHE BOOL "include PAM support")
set(WITH_NL OFF CACHE BOOL "use the libnl library")
set(WITH_M OFF CACHE BOOL "use the libm")
set(CAPTURE_LATENCY_SUPPORT OFF CACHE BOOL "Enable capturing latency stats")
set(WITH_OATH OFF CACHE BOOL "include OTP support")
set(WITH_UTMP OFF CACHE BOOL "use libutil for utmp support")
set(WITH_SYSTEMD OFF CACHE BOOL "enable systemd support")
set(WITH_TALLOC ON CACHE BOOL "use the system talloc library")

set(ENABLE_COMPRESSION OFF CACHE BOOL "Compression support")
set(GEOIP_LIBRARY "" CACHE STRING "") # geoip|maxmindb library
set(OCCTL_PAGER "less" CACHE STRING "") # occtcl_pager

set(PACKAGE "ocserv" CACHE STRING "")
set(PACKAGE_NAME "OpenConnect VPN Server" CACHE STRING "")
set(PACKAGE_TARNAME "ocserv" CACHE STRING "")
set(PACKAGE_VERSION "${CMAKE_PROJECT_VERSION}" CACHE STRING "")
set(PACKAGE_STRING "OpenConnect VPN Server '${CMAKE_PROJECT_VERSION}'" CACHE STRING "")
set(PACKAGE_BUGREPORT "https://gitlab.com/openconnect/ocserv/-/issues" CACHE STRING "")
set(PACKAGE_URL "https://ocserv.openconnect-vpn.net/" )

set(ANYCONNECT_CLIENT_COMPAT ON CACHE BOOL "Enable Anyconnect compatibility")
set(ENABLE_ADAPTIVE_RATE_LIMIT_SUPPORT OFF CACHE BOOL "Enable adaptive rate limiting")
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

include_directories(${CMAKE_PROJECT_NAME} PRIVATE
	${CMAKE_CURRENT_BINARY_DIR}
	${Protobuf_INCLUDE_DIRS}
	${CMAKE_CURRENT_LIST_DIR}
	${SOURCE_DIR}
	${SOURCE_DIR}/common
	${SOURCE_DIR}/occtl
)

add_compile_options(-D_GNU_SOURCE=1 -Wall -Wno-strict-aliasing -Wextra
				-Wno-unused-parameter -Wno-sign-compare
				-Wno-missing-field-initializers -Wno-implicit-fallthrough
				-Wno-stringop-truncation)

add_executable("${CMAKE_PROJECT_NAME}")
add_executable("${CMAKE_PROJECT_NAME}-worker")

include(cmake/autoconf.cmake)
configure_file(config.h.in config.h @ONLY)

include(cmake/sources.cmake)
include(cmake/sources-ocserv.cmake)
include(cmake/sources-worker.cmake)
include(cmake/sources-occtl.cmake)
include(cmake/sources-ocpasswd.cmake)

target_sources(${CMAKE_PROJECT_NAME} PRIVATE ${SERVER_SOURCES})
target_sources("${CMAKE_PROJECT_NAME}-worker" PRIVATE ${WORKER_SOURCES})

################################################################################

include(cmake/conf_info.cmake)

################################################################################

install(
	TARGETS "${CMAKE_PROJECT_NAME}" "${CMAKE_PROJECT_NAME}-worker" ocpasswd
	DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
	COMPONENT binaries)

install(
	FILES ${CMAKE_BINARY_DIR}/ocserv.conf
	DESTINATION /etc/ocserv
	COMPONENT config)
