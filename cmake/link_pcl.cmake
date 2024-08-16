
add_library(pcl-static STATIC
	${SOURCE_DIR}/pcl/pcl.c
	${SOURCE_DIR}/pcl/pcl_version.c
	${SOURCE_DIR}/pcl/pcl_private.c
	${SOURCE_DIR}/pcl/pcl_config.h
	${SOURCE_DIR}/pcl/pcl.h
	${SOURCE_DIR}/pcl/pcl_private.h)

target_compile_definitions(pcl-static PRIVATE HAVE_CONFIG_H VERSION="builtin")
target_include_directories(pcl-static PRIVATE
	${SOURCE_DIR}/pcl/
	${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE pcl-static)
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${SOURCE_DIR}/pcl)

set(WITH_LOCAL_PCL ON CACHE BOOL "")
