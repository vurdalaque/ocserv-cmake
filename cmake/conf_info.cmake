message(STATUS "Summary.of.build.options:")
message(STATUS "    version: ............... ${PACKAGE_VERSION}")
message(STATUS "    Host type: ............. ${HOST}")
message(STATUS "    Install prefix: ........ ${CMAKE_INSTALL_PREFIX}")
message(STATUS "    Compiler: .............. ${CMAKE_C_COMPILER}")
message(STATUS "    CFlags: ................ ${CMAKE_C_FLAGS}")
message(STATUS "    CWrap testing: ......... ${HAVE_CWRAP}")  # not implemented
message(STATUS "    CWrap PAM testing: ..... ${HAVE_CWRAP_PAM}") # not implemented
message(STATUS "    CWrap NSS testing: ..... ${HAVE_CWRAP_NSS}") # not implemented
message(STATUS "    ")
message(STATUS "    PAM auth backend: ...... ${HAVE_PAM}")
message(STATUS "    Radius auth backend: ... ${HAVE_RADIUS}")
message(STATUS "    GSSAPI auth backend: ... ${HAVE_GSSAPI}")
message(STATUS "    OIDC Auth backend: ..... ${SUPPORT_OIDC_AUTH}")
message(STATUS "    Anyconnect compat: ..... ${ANYCONNECT_CLIENT_COMPAT}")
message(STATUS "    TCP wrappers: .......... ${HAVE_LIBWRAP}")
message(STATUS "    namespaces: ............ ${LINUX_NAMESPACES}")
message(STATUS "    systemd: ............... ${HAVE_LIBSYSTEMD}")
message(STATUS "  (socket activation)")
message(STATUS "    worker isolation: ...... ${HAVE_LIBSECCOMP}")
message(STATUS "    Compression: ........... ${ENABLE_COMPRESSION}")
message(STATUS "    LZ4 compression: ....... ${HAVE_LZ4}")
message(STATUS "    readline: .............. ${HAVE_LIBREADLINE}")
message(STATUS "    libm: .................. ${HAVE_LIBM}")
message(STATUS "    libnl3: ................ ${HAVE_LIBNL}")
message(STATUS "    liboath: ............... ${HAVE_LIBOATH}")
message(STATUS "    libgeoip: .............. ${HAVE_GEOIP}")
message(STATUS "    libmaxminddb: .......... ${HAVE_MAXMIND}")
message(STATUS "    glibc (sha2crypt): ..... ${HAVE_GLIBC}")
message(STATUS "    local talloc: .......... ${WITH_LOCAL_TALLOC}")
message(STATUS "    local protobuf-c: ...... ${WITH_LOCAL_PROTOBUF_C}")
message(STATUS "    local PCL.library: ..... ${WITH_LOCAL_PCL}")
message(STATUS "    local llhttp: .......... ${WITH_LOCAL_LLHTTP}")
message(STATUS "    seccomp trap: .......... ${USE_SECCOMP_TRAP}")
message(STATUS "    capture latency stats .. ${CAPTURE_LATENCY_SUPPORT}")
