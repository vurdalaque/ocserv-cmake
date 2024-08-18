
SET(CORE_SOURCES
	${SOURCE_DIR}/common/hmac.c
	${SOURCE_DIR}/common/hmac.h
	${SOURCE_DIR}/common/snapshot.c
	${SOURCE_DIR}/common/snapshot.h
	${SOURCE_DIR}/common-config.h
	${SOURCE_DIR}/config.c
	${SOURCE_DIR}/config-kkdcp.c
	${SOURCE_DIR}/config-ports.c
	${SOURCE_DIR}/defs.h
	${SOURCE_DIR}/gettime.h
	${SOURCE_DIR}/inih/ini.c
	${SOURCE_DIR}/inih/ini.h
	${SOURCE_DIR}/ip-util.c
	${SOURCE_DIR}/ip-util.h
	${SOURCE_DIR}/main.h
	${SOURCE_DIR}/main-ctl.h
	${SOURCE_DIR}/script-list.h
	${SOURCE_DIR}/setproctitle.c
	${SOURCE_DIR}/setproctitle.h
	${SOURCE_DIR}/str.c
	${SOURCE_DIR}/str.h
	${SOURCE_DIR}/subconfig.c
	${SOURCE_DIR}/sup-config/file.c
	${SOURCE_DIR}/sup-config/file.h
	${SOURCE_DIR}/sup-config/radius.c
	${SOURCE_DIR}/sup-config/radius.h
	${SOURCE_DIR}/tlslib.c
	${SOURCE_DIR}/tlslib.h
	${SOURCE_DIR}/valid-hostname.c
	${SOURCE_DIR}/vasprintf.c
	${SOURCE_DIR}/vasprintf.h
	${SOURCE_DIR}/vhost.h
	${SOURCE_DIR}/vpn.h
	${SOURCE_DIR}/namespace.h
	${SOURCE_DIR}/worker-log.c)

add_library(common-static STATIC
	${SOURCE_DIR}/common/common.c
	${SOURCE_DIR}/common/common.h
	${SOURCE_DIR}/common/system.c
	${SOURCE_DIR}/common/system.h
	${SOURCE_DIR}/common/cloexec.c
	${SOURCE_DIR}/common/cloexec.h
	${SOURCE_DIR}/common/base64-helper.c
	${SOURCE_DIR}/common/base64-helper.h
	${SOURCE_DIR}/log.c
	${SOURCE_DIR}/log.h
)

add_library(auth-static STATIC
	${SOURCE_DIR}/auth/common.c
	${SOURCE_DIR}/auth/common.h
	${SOURCE_DIR}/auth/gssapi.c
	${SOURCE_DIR}/auth/gssapi.h
	${SOURCE_DIR}/auth/pam.c
	${SOURCE_DIR}/auth/pam.h
	${SOURCE_DIR}/auth/plain.c
	${SOURCE_DIR}/auth/plain.h
	${SOURCE_DIR}/auth/radius.c
	${SOURCE_DIR}/auth/radius.h
	${SOURCE_DIR}/auth-unix.c
	${SOURCE_DIR}/auth-unix.h
)

add_library(ccan-static STATIC
	${SOURCE_DIR}/ccan/build_assert/build_assert.h
	${SOURCE_DIR}/ccan/check_type/check_type.h
	${SOURCE_DIR}/ccan/container_of/container_of.h
	${SOURCE_DIR}/ccan/hash/hash.c
	${SOURCE_DIR}/ccan/hash/hash.h
	${SOURCE_DIR}/ccan/htable/htable.c
	${SOURCE_DIR}/ccan/htable/htable.h
	${SOURCE_DIR}/ccan/htable/htable_type.h
	${SOURCE_DIR}/ccan/list/list.c
	${SOURCE_DIR}/ccan/list/list.h
	${SOURCE_DIR}/ccan/str/hex/hex.c
	${SOURCE_DIR}/ccan/str/hex/hex.h
)

add_library(acc-static STATIC
	${SOURCE_DIR}/acct/radius.c
	${SOURCE_DIR}/acct/radius.h
	${SOURCE_DIR}/acct/pam.c
	${SOURCE_DIR}/acct/pam.h)


