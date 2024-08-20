
add_executable(ocpasswd
   ${SOURCE_DIR}/ocpasswd/ocpasswd.c)

target_compile_definitions(ocpasswd PRIVATE
	VERSION="${CMAKE_PROJECT_VERSION}")

