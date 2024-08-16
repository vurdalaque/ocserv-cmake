
pkg_check_modules(tls REQUIRED gnutls>=3.3.0)

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${tls_INCLUDE_DIRS})
target_link_directories(${CMAKE_PROJECT_NAME} PRIVATE ${tls_LIBRARY_DIRS})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ${tls_LINK_LIBRARIES})
