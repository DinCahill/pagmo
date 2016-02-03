# Din
if(CMAKE_SIZEOF_VOID_P EQUAL 8) # x64
	IF(USE_PYTHON_VERSION STREQUAL "2.7")
		SET(PYDIR "C:/Anaconda2" CACHE PATH a)
		SET(PYTHON_LIBRARY "${PYDIR}/libs/python27.lib" CACHE PATH a)
	ELSEIF(USE_PYTHON_VERSION STREQUAL "3.5")
		SET(PYDIR "C:/Users/Donal/Anaconda3" CACHE PATH a)
		SET(PYTHON_LIBRARY "${PYDIR}/libs/python35.lib" CACHE PATH a)
	ENDIF(USE_PYTHON_VERSION STREQUAL "2.7")
else(CMAKE_SIZEOF_VOID_P EQUAL 8)
	IF(USE_PYTHON_VERSION STREQUAL "2.7")
		SET(PYDIR "C:/Users/Donal/Anaconda2-32" CACHE PATH a)
		SET(PYTHON_LIBRARY "${PYDIR}/libs/python27.lib" CACHE PATH a)
	ELSEIF(USE_PYTHON_VERSION STREQUAL "3.5")
		SET(PYDIR "C:/Users/Donal/Anaconda3-32" CACHE PATH a)
		SET(PYTHON_LIBRARY "${PYDIR}/libs/python35.lib" CACHE PATH a)
	ENDIF(USE_PYTHON_VERSION STREQUAL "2.7")
endif(CMAKE_SIZEOF_VOID_P EQUAL 8)
SET(PYTHON_EXECUTABLE "${PYDIR}/python.exe" CACHE PATH a)
MESSAGE(STATUS "PYTHON_EXECUTABLE: ${PYTHON_EXECUTABLE}")
SET(PYKEP_PYTHON_FLAG "${PYDIR}/python.exe" CACHE PATH a)
SET(PYTHON_INCLUDE_DIR "${PYDIR}/include" CACHE path a)
SET(PYTHON_MODULES_DIR "${PYDIR}/Lib/site-packages" CACHE PATH a)


INCLUDE_DIRECTORIES(${PYTHON_INCLUDE_DIR})

# These flags are used to signal the need to override the default extension of the Python modules
# depending on the architecture. Under Windows, for instance, CMake produces shared objects as
# .dll files, but Python from 2.5 onwards requires .pyd files (hence the need to override).
# A similar thing happens in SuckOSX.
SET(PYDEXTENSION FALSE)
SET(SOEXTENSION FALSE)

IF(UNIX)
	# SuckOSX suckages.
	IF(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
		SET(SOEXTENSION TRUE)
	ENDIF(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
	ELSE(UNIX)
	# Win32 suckages.
	SET(PYDEXTENSION TRUE)
ENDIF(UNIX)

if (DEFINED USE_PYTHON_VERSION)
# We make the variables cached so that we can change them in GUIs editors like ccmake 
MARK_AS_ADVANCED(CLEAR PYTHON_EXECUTABLE)
EXECUTE_PROCESS ( COMMAND ${PYTHON_EXECUTABLE} -c "from distutils.sysconfig import get_python_version; print(get_python_version()[0])" OUTPUT_VARIABLE PYTHON_VERSION_MAJOR OUTPUT_STRIP_TRAILING_WHITESPACE)
EXECUTE_PROCESS ( COMMAND ${PYTHON_EXECUTABLE} -c "from distutils.sysconfig import get_python_version; print(get_python_version())" OUTPUT_VARIABLE PYTHON_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)
SET(PYTHON_EXECUTABLE ${PYTHON_EXECUTABLE} CACHE PATH "The Python executable")
SET(PYTHON_VERSION ${PYTHON_VERSION} CACHE PATH "The Python executable Version")
SET(PYTHON_VERSION_MAJOR ${PYTHON_VERSION_MAJOR} CACHE PATH "The Python executable major Version")
SET(PYTHON_INCLUDE_DIR ${PYTHON_INCLUDE_DIR} CACHE PATH "Path to the python include files, where pyconfig.h can be found")
SET(PYTHON_MODULES_DIR ${PYTHON_MODULES_DIR} CACHE PATH "Path of site-packages, PyKEP will be installed in .../PyKEP")
SET(PYTHON_LIBRARIES ${PYTHON_LIBRARIES} CACHE PATH "Name of the python library")

MESSAGE(STATUS "Python interpreter: ${PYTHON_EXECUTABLE}")
MESSAGE(STATUS "Python interpreter verison: ${PYTHON_VERSION}")
MESSAGE(STATUS "Python includes path: "        "${PYTHON_INCLUDE_DIR}")
MESSAGE(STATUS "Python modules install path: " "${PYTHON_MODULES_DIR}")
MESSAGE(STATUS "Python library name: "         "${PYTHON_LIBRARIES}")
endif (DEFINED USE_PYTHON_VERSION)
