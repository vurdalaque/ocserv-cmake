
add_library(llhttp-static STATIC
	${SOURCE_DIR}/llhttp/llhttp.c
	${SOURCE_DIR}/llhttp/llhttp.h
	${SOURCE_DIR}/llhttp/api.c
	${SOURCE_DIR}/llhttp/http.c)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE llhttp-static)
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${SOURCE_DIR}/llhttp)

set(WITH_LOCAL_LLHTTP ON CACHE BOOL "")
