find_program(PROTOC protoc-c REQUIRED)
find_program(GPERF gperf REQUIRED)

################################################################################

if (WITH_PROTOBUF)
	pkg_check_modules(protobuf_c REQUIRED libprotobuf-c)
	include_directories(${protobuf_c_INCLUDE_DIRS})
	link_directories(${protobuf_c_LIBRARY_DIRS})
	link_libraries(${protobuf_c_LINK_LIBRARIES})


	set(HAVE_LIBPROTOBUF_C ON CACHE BOOL "")
	set(WITH_LOCAL_PROTOBUF_C OFF CACHE BOOL "")
else()

	add_library(protobuf-static STATIC
		${SOURCE_DIR}/protobuf/protobuf-c/protobuf-c.h
		${SOURCE_DIR}/protobuf/protobuf-c/protobuf-c.c)

	include_directories(${SOURCE_DIR}/protobuf)
	set(HAVE_LIBPROTOBUF_C ON CACHE BOOL "")
	set(WITH_LOCAL_PROTOBUF_C ON CACHE BOOL "")
endif(WITH_PROTOBUF)

################################################################################

find_program(ASNPARSER asn1Parser REQUIRED)

# libtasn1 tools
if (NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/kkdcp_asn1_tab.c)
	message(STATUS "parsing $(srcdir)/kkdcp.asn")
	execute_process(
		COMMAND ${ASNPARSER} ${SOURCE_DIR}/kkdcp.asn -o ${CMAKE_CURRENT_BINARY_DIR}/kkdcp_asn1_tab.c
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		OUTPUT_QUIET ERROR_QUIET)
endif()

################################################################################

if (NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/ipc.pb-c.h)
	message(STATUS "protobufing ipc.proto")
	execute_process(
		COMMAND ${PROTOC} --c_out=. --proto_path=${SOURCE_DIR} ipc.proto
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endif()

if (NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/ctl.pb-c.h )
	message(STATUS "protobufing ctl.proto")
	execute_process(
		COMMAND ${PROTOC} --c_out=. --proto_path=${SOURCE_DIR} ctl.proto
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endif()

add_library(ipc-static STATIC
	ctl.pb-c.c ctl.pb-c.h
	ipc.pb-c.h ipc.pb-c.c
	${SOURCE_DIR}/kkdcp_asn1_tab.c)

target_link_libraries(ipc-static PRIVATE protobuf-static)
link_libraries(ipc-static)

################################################################################
# this is not quite correct, but will do gperf'ing
# @todo: move to proper places

if (NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/http-heads.h)
	# wsl requires /bin/sh
	message(STATUS "gperfing http-heads.gperf")
	execute_process(
		COMMAND /bin/sh -c "${GPERF} --global-table -t ${SOURCE_DIR}/http-heads.gperf > ${CMAKE_CURRENT_BINARY_DIR}/http-heads.h"
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endif()

################################################################################
