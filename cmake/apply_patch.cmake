if(NOT DEFINED SOURCE_DIR OR NOT DEFINED PATCH_FILE)
	message(FATAL_ERROR "SOURCE_DIR and PATCH_FILE are required")
endif()

find_package(Git REQUIRED)

execute_process(
	COMMAND "${GIT_EXECUTABLE}" apply --check "${PATCH_FILE}"
	WORKING_DIRECTORY "${SOURCE_DIR}"
	RESULT_VARIABLE apply_check_result
	ERROR_VARIABLE apply_check_error)

if(apply_check_result EQUAL 0)
	execute_process(
		COMMAND "${GIT_EXECUTABLE}" apply "${PATCH_FILE}"
		WORKING_DIRECTORY "${SOURCE_DIR}"
		RESULT_VARIABLE apply_result
		ERROR_VARIABLE apply_error)
	if(NOT apply_result EQUAL 0)
		message(FATAL_ERROR "Failed to apply ${PATCH_FILE}: ${apply_error}")
	endif()
	return()
endif()

execute_process(
	COMMAND "${GIT_EXECUTABLE}" apply --reverse --check "${PATCH_FILE}"
	WORKING_DIRECTORY "${SOURCE_DIR}"
	RESULT_VARIABLE reverse_check_result)

if(NOT reverse_check_result EQUAL 0)
	message(FATAL_ERROR "Patch cannot be applied cleanly: ${apply_check_error}")
endif()

