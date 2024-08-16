find_program(PROTOC protoc-c REQUIRED)
find_program(GPERF gperf REQUIRED)

################################################################################

pkg_check_modules(protobuf_c libprotobuf-c1)
if (protobuf_c_FOUND)
	target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${protobuf_c_INCLUDE_DIRS})
	target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${protobuf_c_LIBRARY_DIRS})
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${protobuf_c_LINK_LIBRARIES})
	set(HAVE_LIBPROTOBUF_C ON CACHE BOOL "")
else()
	message(STATUS "*** libprotobuf-c was not found. An included version of the library will be used.")
	add_library(protobuf-static STATIC
		${SOURCE_DIR}/protobuf/protobuf-c/protobuf-c.h
		${SOURCE_DIR}/protobuf/protobuf-c/protobuf-c.c)

	set(HAVE_LIBPROTOBUF_C ON CACHE BOOL "")
	set(WITH_LOCAL_PROTOBUF_C ON CACHE BOOL "")
	# target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE protobuf-static)
endif()

if (NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/ipc.pb-c.h)
	execute_process(COMMAND
		COMMENT "protobufing ipc.proto"
		COMMAND ${PROTOC} --c_out=. --proto_path=${SOURCE_DIR} ipc.proto
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endif()

if (NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/ctl.pb-c.h )
	execute_process(COMMAND
		COMMENT "protobufing ctl.proto"
		COMMAND ${PROTOC} --c_out=. --proto_path=${SOURCE_DIR} ctl.proto
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endif()

add_library(ipc-static STATIC
	ctl.pb-c.c ctl.pb-c.h
	ipc.pb-c.h ipc.pb-c.c)

target_link_libraries(ipc-static PRIVATE protobuf-static)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ipc-static)

################################################################################
# this is not quite correct, but will do gperf'ing
# @todo: move to proper places

if (NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/http-heads.h)
	# wsl requires /bin/sh
	execute_process(COMMAND
		COMMENT "gperfing http-heads.gperf"
		COMMAND /bin/sh -c "${GPERF} --global-table -t ${SOURCE_DIR}/http-heads.gperf > ${CMAKE_CURRENT_BINARY_DIR}/http-heads.h"
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
endif()

################################################################################
