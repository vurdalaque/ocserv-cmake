find_program(PROTOC protoc-c REQUIRED)
find_program(GPERF gperf REQUIRED)
find_program(ASNPARSER asn1Parser REQUIRED)

if (WITH_PROTOBUF)
	pkg_check_modules(protobuf_c REQUIRED libprotobuf-c)
	set(HAVE_LIBPROTOBUF_C ON CACHE BOOL "")
	set(WITH_LOCAL_PROTOBUF_C OFF CACHE BOOL "")
else()
	add_library(protobuf-static STATIC
		${SOURCE_DIR}/protobuf/protobuf-c/protobuf-c.h
		${SOURCE_DIR}/protobuf/protobuf-c/protobuf-c.c)
	target_include_directories(protobuf-static PUBLIC ${SOURCE_DIR}/protobuf)
	include_directories(${SOURCE_DIR}/protobuf)
	set(HAVE_LIBPROTOBUF_C ON CACHE BOOL "")
	set(WITH_LOCAL_PROTOBUF_C ON CACHE BOOL "")
endif()

add_custom_command(
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/kkdcp_asn1_tab.c
	COMMAND ${ASNPARSER} ${SOURCE_DIR}/kkdcp.asn -o ${CMAKE_CURRENT_BINARY_DIR}/kkdcp_asn1_tab.c
	DEPENDS ${SOURCE_DIR}/kkdcp.asn
	VERBATIM)

set(PROTOBUF_OUTPUTS)
foreach (proto ipc ctl cfg)
	list(APPEND PROTOBUF_OUTPUTS
		${CMAKE_CURRENT_BINARY_DIR}/${proto}.pb-c.c
		${CMAKE_CURRENT_BINARY_DIR}/${proto}.pb-c.h)
	add_custom_command(
		OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${proto}.pb-c.c ${CMAKE_CURRENT_BINARY_DIR}/${proto}.pb-c.h
		COMMAND ${PROTOC} --c_out=${CMAKE_CURRENT_BINARY_DIR} --proto_path=${SOURCE_DIR} ${SOURCE_DIR}/${proto}.proto
		DEPENDS ${SOURCE_DIR}/${proto}.proto
		VERBATIM)
endforeach()

add_custom_target(ipc-generated
	DEPENDS ${PROTOBUF_OUTPUTS} ${CMAKE_CURRENT_BINARY_DIR}/kkdcp_asn1_tab.c)


add_library(ipc-static STATIC
	${PROTOBUF_OUTPUTS}


	${CMAKE_CURRENT_BINARY_DIR}/kkdcp_asn1_tab.c)
add_dependencies(ipc-static ipc-generated)

target_include_directories(ipc-static PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
if (WITH_PROTOBUF)
	target_include_directories(ipc-static PRIVATE ${protobuf_c_INCLUDE_DIRS})
	target_link_directories(ipc-static PRIVATE ${protobuf_c_LIBRARY_DIRS})
	target_link_libraries(ipc-static PRIVATE ${protobuf_c_LINK_LIBRARIES})
else()
	target_link_libraries(ipc-static PRIVATE protobuf-static)
endif()
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ipc-static)
target_link_libraries(${CMAKE_PROJECT_NAME}-worker PRIVATE ipc-static)
add_dependencies(${CMAKE_PROJECT_NAME} ipc-generated)
add_dependencies(${CMAKE_PROJECT_NAME}-worker ipc-generated)


add_custom_command(
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/http-heads.c
	COMMAND ${GPERF} --global-table -t --output-file=${CMAKE_CURRENT_BINARY_DIR}/http-heads.c ${SOURCE_DIR}/http-heads.gperf
	DEPENDS ${SOURCE_DIR}/http-heads.gperf
	VERBATIM)
