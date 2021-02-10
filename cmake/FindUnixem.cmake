# FindUnixem.cmake
# author lsm <lsm@skyblility.com>

set(CMAKE_FIND_DEBUG_MODE TRUE)

if (NOT UNIXEM_FOUND)
    if (NOT UNIXEM_INCLUDE_DIR)
        message(STATUS "Finding UNIXEM_INCLUDE_DIR")
        message(STATUS "CMAKE_STAGING_PREFIX = ${CMAKE_STAGING_PREFIX}")

        find_path(UNIXEM_INCLUDE_DIR
            NAMES
                unixem/unixem.h
            ONLY_CMAKE_FIND_ROOT_PATH
        )
    endif()
    
    if (NOT UNIXEM_LIBRARY)
        find_library(UNIXEM_LIBRARY
            NAMES unixem 
            ONLY_CMAKE_FIND_ROOT_PATH
        )
    endif (NOT UNIXEM_LIBRARY)
    
    message(STATUS " UNIXEM_INCLUDE_DIR = ${UNIXEM_INCLUDE_DIR}")
    message(STATUS " UNIXEM_LIBRARY = ${UNIXEM_LIBRARY}")
    
    if (UNIXEM_INCLUDE_DIR AND UNIXEM_LIBRARY)
        set(UNIXEM_FOUND TRUE)
    endif (UNIXEM_INCLUDE_DIR AND UNIXEM_LIBRARY)
endif()
    
