
add_library(llhttp-static STATIC
	${SOURCE_DIR}/llhttp/llhttp.c
	${SOURCE_DIR}/llhttp/llhttp.h
	${SOURCE_DIR}/llhttp/api.c
	${SOURCE_DIR}/llhttp/http.c)

link_libraries(llhttp-static)
include_directories(${SOURCE_DIR}/llhttp)

set(WITH_LOCAL_LLHTTP ON CACHE BOOL "")
