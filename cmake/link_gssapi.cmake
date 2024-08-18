
if (WITH_GSSAPI)
	pkg_check_modules(libkrb krb5-gssapi)

	if (libkrb_FOUND)

		pkg_check_modules(tasn REQUIRED libtasn1)

		include_directories(${libkrb_INCLUDE_DIRS} ${tasn_INCLUDE_DIRS})
		link_directories(${libkrb_LIBRARY_DIRS} ${tasn_LIBRARY_DIRS})
		link_libraries(${libkrb_LINK_LIBRARIES} ${tasn_LINK_LIBRARIES})

	else()

		find_library(KRB_LIBRARY REQUIRED NAMES krb5-gssapi)
		find_library(TASN_LIBRARY REQUIRED NAMES libtasn1)

		link_libraries(${KRB_LIBRARY} ${TASN_LIBRARY})

	endif()

	set(HAVE_GSSAPI ON CACHE BOOL "")
else()
	set(HAVE_GSSAPI OFF CACHE BOOL "")
endif(WITH_GSSAPI)
