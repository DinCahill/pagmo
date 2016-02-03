# Setting compiler secific flags
INCLUDE(CheckCXXCompilerFlag)
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")

	CHECK_CXX_COMPILER_FLAG(-ftemplate-depth=256 CLANG_TEMPLATE_DEPTH)
	IF(CLANG_TEMPLATE_DEPTH)
		MESSAGE(STATUS "Enabling '-ftemplate-depth=256' compiler flag required since boost 1.54.")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ftemplate-depth=256 -Wno-deprecated-declarations")
	ENDIF(CLANG_TEMPLATE_DEPTH)

ELSEIF ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")

	CHECK_CXX_COMPILER_FLAG(fno-strict-aliasing GNUCXX_NO_STRICT_ALIASING)
	IF(GNUCXX_NO_STRICT_ALIASING)
		MESSAGE(STATUS "Enabling '-fno-strict-aliasing' compiler flag.")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-strict-aliasing")
	ENDIF(GNUCXX_NO_STRICT_ALIASING)

	CHECK_CXX_COMPILER_FLAG(-Wall GNUCXX_W_ALL)
	IF(GNUCXX_W_ALL)
		MESSAGE(STATUS "Enabling '-Wall' compiler flag.")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
	ENDIF(GNUCXX_W_ALL)

	CHECK_CXX_COMPILER_FLAG(-Wno-deprecated GNUCXX_W_NODEPRECATED)
	IF(GNUCXX_W_NODEPRECATED)
		MESSAGE(STATUS "Enabling '-Wno-deprecated' compiler flag.")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated")
	ENDIF(GNUCXX_W_NODEPRECATED)
	
	CHECK_CXX_COMPILER_FLAG(-Wextra GNUCXX_W_EXTRA)
	IF(GNUCXX_W_EXTRA)
		MESSAGE(STATUS "Enabling '-Wextra' compiler flag.")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wextra")
	ENDIF(GNUCXX_W_EXTRA)

	CHECK_CXX_COMPILER_FLAG(-Wnoexcept GNUCXX_W_NOEXCEPT)
	IF(GNUCXX_W_NOEXCEPT)
		MESSAGE(STATUS "Enabling '-Wnoexcept' compiler flag.")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wnoexcept")
	ENDIF(GNUCXX_W_NOEXCEPT)

	CHECK_CXX_COMPILER_FLAG(-Wdisabled-optimization GNUCXX_W_DISOPT)
	IF(GNUCXX_W_DISOPT)
		MESSAGE(STATUS "Enabling '-Wdisabled-optimization' compiler flag.")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wdisabled-optimization")
	ENDIF(GNUCXX_W_DISOPT)

	CHECK_CXX_COMPILER_FLAG(-ffast-math GNUCXX_FASTMATH)
	IF(GNUCXX_FASTMATH)
		MESSAGE(STATUS "Enabling '-ffast-math' compiler flag.")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffast-math")
	ENDIF(GNUCXX_FASTMATH)

ELSEIF ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
  # using Intel C++
	CHECK_CXX_COMPILER_FLAG(-mieee-fp INTEL_IEEE_COMPLIANT)
	IF(INTEL_IEEE_COMPLIANT)
			MESSAGE(STATUS "Enabling '-mieee-fp' compiler flag to get IEEE compliant code")
			SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mieee-fp")
	ENDIF(INTEL_IEEE_COMPLIANT)
ELSEIF ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
  # using Visual Studio C++
ENDIF()

# The following flags will be tried on all compilers
# If a C++11 able compiler is detected, then the flag is added
# otherwise an error is thrown
CHECK_CXX_COMPILER_FLAG(-std=c++11 ALL_C11)
IF(ALL_C11)
	MESSAGE(STATUS "Enabling '-std=c++11' compiler flag")
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
ENDIF(ALL_C11)

IF("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
	IF(MSVC_VERSION STREQUAL "1900")
		MESSAGE(STATUS "Using MSVC 2015. Supports C++11.")
		SET(ALL_C11 ON)
	ENDIF(MSVC_VERSION STREQUAL "1900")
ENDIF("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")

IF(NOT ALL_C11)
	CHECK_CXX_COMPILER_FLAG(-std=c++0x ALL_C0X)
	IF(ALL_C0X)
		MESSAGE(STATUS "Enabling '-std=c++0x' compiler flag")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
	ELSE(ALL_C0X)
	    MESSAGE(FATAL_ERROR "Unable to locate a c++11 compatible compiler")
	ENDIF(ALL_C0X)
ENDIF(NOT ALL_C11)

# We finally set and log the compiler flags
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
MESSAGE(STATUS "CXX compilation flags: ${CMAKE_CXX_FLAGS}")
