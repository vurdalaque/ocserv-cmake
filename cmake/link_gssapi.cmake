
if (WITH_GSSAPI)
	pkg_check_modules(libkrb REQUIRED krb5-gssapi)
	pkg_check_modules(tasn REQUIRED libtasn1)

	include_directories(${libkrb_INCLUDE_DIRS} ${tasn_INCLUDE_DIRS})
	link_directories(${libkrb_LIBRARY_DIRS} ${tasn_LIBRARY_DIRS})
	link_libraries(${libkrb_LINK_LIBRARIES} ${tasn_LINK_LIBRARIES})

	set(HAVE_GSSAPI ON CACHE BOOL "")
	list(APPEND SOURCES ${SOURCE_DIR}/kkdcp_asn1_tab.c)

	find_program(ASNPARSER asn1Parser REQUIRED)

	# libtasn1 tools
	if (NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/kkdcp_asn1_tab.c)
		execute_process(COMMAND
			COMMENT "parsing $(srcdir)/kkdcp.asn"
			COMMAND ${ASNPARSER} ${SOURCE_DIR}/kkdcp.asn -o ${CMAKE_CURRENT_BINARY_DIR}/kkdcp_asn1_tab.c
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			OUTPUT_QUIET ERROR_QUIET)
	endif()
else()
	set(HAVE_GSSAPI OFF CACHE BOOL "")
endif(WITH_GSSAPI)
