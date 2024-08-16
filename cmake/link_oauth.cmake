
pkg_check_modules(oath liboath)

if (oath_FOUND)
	target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${oath_INCLUDE_DIRS})
	target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${oath_LIBRARY_DIRS})
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${oath_LINK_LIBRARIES})
	set(HAVE_LIBOATH ON CACHE BOOL "")
else()
	set(HAVE_LIBOATH OFF CACHE BOOL "")
endif()
