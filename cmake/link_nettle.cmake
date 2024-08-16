

pkg_check_modules(nettle nettle>=3.0)

if (NOT nettle_FOUND)
	unset(nettle CACHE)
	pkg_check_modules(nettle REQUIRED nettle>=2.7)

	set(NETTLE_OLD_BASE64_API ON CACHE BOOL "")
endif()

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${nettle_INCLUDE_DIRS})
target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${nettle_LIBRARY_DIRS})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${nettle_LINK_LIBRARIES})
