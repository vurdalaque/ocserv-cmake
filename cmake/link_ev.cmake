
pkg_check_modules(ev REQUIRED libev)

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${ev_INCLUDE_DIRS})
target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${ev_LIBRARY_DIRS})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${ev_LINK_LIBRARIES})

set(HAVE_LIBEV ON CACHE BOOL "")
