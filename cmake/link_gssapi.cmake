
pkg_check_modules(libkrb krb5-gssapi)
if (libkrb_FOUND)
	pkg_check_modules(tasn REQUIRED libtasn1)

	target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${libkrb_INCLUDE_DIRS} ${tasn_INCLUDE_DIRS})
	target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${libkrb_LIBRARY_DIRS} ${tasn_LIBRARY_DIRS})
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${libkrb_LINK_LIBRARIES} ${tasn_LINK_LIBRARIES})

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
	message(STATUS "*** gssapi not found. Will disable gssapi (and Kerberos) support.")
endif()
