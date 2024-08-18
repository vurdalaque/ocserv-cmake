
if (NOT LIBREADLINE_LIBRARY)
	message(CHECK_START "Looking for libreadline")

	find_path(LIBNL_INCLUDE_DIR netlink/netlink.h
		/usr/include
		/usr/include/readline
		/usr/local/include
		/usr/local/include/readline)

	find_library(LIBREADLINE_LIBRARY NAMES readline)
	if (LIBREADLINE_LIBRARY)
		set(HAVE_LIBREADLINE ON CACHE BOOL "")
		message(CHECK_PASS "found")

		link_libraries(readline)

		list(APPEND CMAKE_REQUIRED_LIBRARIES readline)
		check_symbol_exists(rl_replace_line readline/readline.h HAVE_ORIG_READLINE_MID)
		if (HAVE_ORIG_READLINE_MID)
			# cmake 3.30.0 puts // comment on line, even when
			# check_symbol_exists success
			set(HAVE_ORIG_READLINE ON CACHE BOOL "")
		else()
			set(HAVE_ORIG_READLINE OFF CACHE BOOL "")

		endif(HAVE_ORIG_READLINE_MID)
	else()
		set(HAVE_LIBREADLINE OFF CACHE BOOL "")
		set(HAVE_ORIG_READLINE OFF CACHE BOOL "")
		message(CHECK_FAIL "*** libreadline or editline was not found. occtl will not be built.")
	endif()

endif(NOT LIBREADLINE_LIBRARY)
