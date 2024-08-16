
# @todo: for libgeoip link_libraries is unspecified

if ("${GEOIP_LIBRARY}" STREQUAL "geoip")
	pkg_check_modules(geoip REQUIRED libgeoip >= 1.6.0)
	set(HAVE_GEOIP ON CACHE BOOL "")
	set(HAVE_MAXMIND OFF CACHE BOOL "")

	target_sources(${CMAKE_PROJECT_NAME} PRIVATE ${SOURCE_DIR}/occtl/geoip.c)

elseif ("${GEOIP_LIBRARY}" STREQUAL "maxmind")
	pkg_check_modules(maxmindb REQUIRED libmaxminddb>=1.0.0)
	set(HAVE_GEOIP OFF CACHE BOOL "")
	set(HAVE_MAXMIND ON CACHE BOOL "")

	target_sources(${CMAKE_PROJECT_NAME} PRIVATE ${SOURCE_DIR}/occtl/maxmind.c)

	target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${maxmindb_INCLUDE_DIRS})
	target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${maxmindb_LIBRARY_DIRS})
	target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${maxmindb_LINK_LIBRARIES})
else()
	set(HAVE_GEOIP OFF CACHE BOOL "")
	set(HAVE_MAXMIND OFF CACHE BOOL "")
endif()

