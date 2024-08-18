include(TestBigEndian)
include(GNUInstallDirs)
include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckFunctionExists)
include(FindPkgConfig)
include(CheckStructHasMember)
include(CheckTypeSize)

################################################################################

set(HOST ${CMAKE_SYSTEM} CACHE STRING "")

################################################################################

include(cmake/link_c.cmake)
include(cmake/link_ev.cmake)
include(cmake/link_gnutls.cmake)
include(cmake/link_nettle.cmake)
include(cmake/link_geoip.cmake)
include(cmake/link_gssapi.cmake)
include(cmake/link_oauth.cmake)
include(cmake/link_protobuf_c.cmake)
include(cmake/link_seccomp.cmake)
include(cmake/link_crypt.cmake)
include(cmake/link_wrap.cmake)
include(cmake/link_systemd.cmake)
include(cmake/link_lz4.cmake)
include(cmake/link_pam.cmake)
include(cmake/link_llhttp.cmake)
include(cmake/link_pcl.cmake)
include(cmake/link_m.cmake)
include(cmake/link_nl.cmake)
include(cmake/link_util.cmake)
include(cmake/link_readline.cmake)
include(cmake/link_talloc.cmake)

################################################################################

TEST_BIG_ENDIAN(IS_BIG_ENDIAN)
if(IS_BIG_ENDIAN)
	OPTION(WORDS_BIGENDIAN ON "" CACHE STRING)
	message(STATUS "AC_APPLE_UNIVERSAL_BUILD is set")
endif(IS_BIG_ENDIAN)

################################################################################

check_include_file(crypt.h HAVE_CRYPT_H)
check_include_file(stdio.h HAVE_STDIO_H)
check_include_file(inttypes.h HAVE_INTTYPES_H)
check_include_file(linux/if_tun.h HAVE_LINUX_IF_TUN_H)
check_include_file(linux/netlink.h HAVE_LINUX_NETLINK_H)
check_include_file(linux/net_tstamp.h HAVE_LINUX_NET_TSTAMP_H)
check_include_file(linux/rtnetlink.h HAVE_LINUX_RTNETLINK_H)
check_include_file(linux/sock_diag.h HAVE_LINUX_SOCK_DIAG_H)
check_include_file(linux/unix_diag.h HAVE_LINUX_UNIX_DIAG_H)
check_include_file(minix/config.h HAVE_MINIX_CONFIG_H)
check_include_file(netinet/in_systm.h HAVE_NETINET_IN_SYSTM_H)
check_include_file(net/if_tun.h HAVE_NET_IF_TUN_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(stdlib.h HAVE_STDLIB_H)
check_include_file(string.h HAVE_STRING_H)
check_include_file(strings.h HAVE_STRINGS_H)
check_include_file(sys/stat.h HAVE_SYS_STAT_H)
check_include_file(sys/types.h HAVE_SYS_TYPES_H)
check_include_file(unistd.h HAVE_UNISTD_H)
check_include_file(wchar.h HAVE_WCHAR_H)

################################################################################

set(CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE=1)

check_symbol_exists(clock_gettime time.h HAVE_CLOCK_GETTIME)
check_symbol_exists(getcontext ucontext.h HAVE_GETCONTEXT)
check_symbol_exists(makecontext ucontext.h HAVE_MAKECONTEXT)
check_symbol_exists(swapcontext ucontext.h HAVE_SWAPCONTEXT)
check_symbol_exists(getpeereid sys/types.h HAVE_GETPEEREID)
check_symbol_exists(isatty unistd.h HAVE_ISATTY)
if (NOT HAVE_GETPEEREID)
	unset(HAVE_GETPEEREID CACHE)
	check_symbol_exists(getpeereid sys/socket.h HAVE_GETPEEREID)
endif(NOT HAVE_GETPEEREID)
check_symbol_exists(free stdlib.h HAVE_FREE)
check_symbol_exists(malloc stdlib.h HAVE_MALLOC)
check_symbol_exists(malloc_trim malloc.h HAVE_MALLOC_TRIM)
check_symbol_exists(memset string.h HAVE_MEMSET)
check_symbol_exists(posix_memalign stdlib.h HAVE_POSIX_MEMALIGN)
check_symbol_exists(ppoll poll.h HAVE_PPOLL LANGUAGE CXX)
check_symbol_exists(pselect sys/select.h HAVE_PSELECT)
check_symbol_exists(setproctitle unistd.h HAVE_SETPROCTITLE)
check_symbol_exists(sigaction signal.h HAVE_SIGACTION)
check_symbol_exists(sigaltstack signal.h HAVE_SIGALTSTACK)
check_symbol_exists(vasprintf stdio.h HAVE_VASPRINTF)

set(CMAKE_EXTRA_INCLUDE_FILES sys/types.h sys/socket.h signal.h time.h linux/errqueue.h)
check_type_size(sighandler_t HAVE_SIGHANDLER_T LANGUAGE CXX) # only cxx finds
check_type_size(sig_t HAVE_SIG_T LANGUAGE CXX)
check_type_size(__sighandler_t HAVE___SIGHANDLER_T LANGUAGE CXX)
check_type_size(scm_timestamping HAVE_STRUCT_SCM_TIMESTAMPING LANGUAGE CXX)
check_type_size(ucred HAVE_STRUCT_UCRED LANGUAGE CXX)

################################################################################

set(CMAKE_REQUIRED_INCLUDES sys/types.h sys/socket.h signal.h time.h linux/errqueue.h netinet/ip.h)
check_struct_has_member("sockaddr" sa_len sys/socket.h HAVE_SOCKADDR_SA_LEN LANGUAGE CXX)
# check_struct_has_member generates (void)sizeof(((struct iphdr *)0)->ihl): sizeof applied to a bit-field
set(HAVE_STRUCT_IPHDR_IHL_SOURCE "#include <netinet/ip.h>\n int main() { ((struct iphdr*)0)->ihl = 0; }")
try_compile(HAVE_STRUCT_IPHDR_IHL SOURCE_FROM_VAR iphdr_ihl.c HAVE_STRUCT_IPHDR_IHL_SOURCE)

################################################################################

check_function_exists(longjmp HAVE_LONGJMP)
check_function_exists(setjmp HAVE_SETJMP)
check_function_exists(strlcpy HAVE_STRLCPY)
check_function_exists(strsep HAVE_STRSEP)

################################################################################

check_type_size("unsigned long" SIZEOF_ULONG)

################################################################################

if (EXISTS "/proc/self/exe")
	set(PROC_FS_SUPPORTED "" ON)
endif()

################################################################################

if (CMAKE_BUILD_TYPE EQUAL "DEBUG")
	# We want to detect failed syscalls when testing, but not necessarily when
	# running in production. This option is provided to enable during CI.
	OPTION(USE_SECCOMP_TRAP "" ON) # hope I understand dev note correctly
else()
	OPTION(USE_SECCOMP_TRAP "" OFF)
endif (CMAKE_BUILD_TYPE EQUAL "DEBUG")

OPTION(HAVE_LIBC "" ON) # defaulting

################################################################################

# find_program(HAVE_IPCALC ipcalc)
# if (NOT HAVE_IPCALC)
# 	message(STATUS "ipcalc not found")
# 	SET(TESTS_ENABLED OFF)
# endif (NOT HAVE_IPCALC)

################################################################################
