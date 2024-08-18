
if (WITH_OATH)
	pkg_check_modules(oath REQUIRED liboath)

	include_directories(${oath_INCLUDE_DIRS})
	link_directories(${oath_LIBRARY_DIRS})
	link_libraries(${oath_LINK_LIBRARIES})
	set(HAVE_LIBOATH ON CACHE BOOL "")
else()
	set(HAVE_LIBOATH OFF CACHE BOOL "")
endif(WITH_OATH)
