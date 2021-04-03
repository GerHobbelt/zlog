
#================================================================
# generate zlog lib
#================================================================
aux_source_directory(. SRCS)
if (NOT WIN32)
    list(REMOVE_ITEM SRCS ./zlog_win.c)
endif()

list(REMOVE_ITEM SRCS ./zlog-chk-conf.c)

add_library(zlog
    SHARED
    ${SRCS}
    )
target_link_libraries(zlog
    ${CMAKE_THREAD_PREFER_PTHREAD}
    )

if (WIN32)
    target_link_libraries(zlog
        ${UNIXEM_LIBRARY}
        # Ws2_32
        )
endif()

set_target_properties(zlog PROPERTIES VERSION ${zlog_ver} SOVERSION ${zlog_so_ver})

message(STATUS "Linking ${UNIXEM_LIBRARY} ... ")
add_library(zlog_o
    OBJECT
    ${SRCS}
    )

add_library(zlog_s STATIC $<TARGET_OBJECTS:zlog_o>)

target_link_libraries(zlog_s
    ${CMAKE_THREAD_PREFER_PTHREAD}
    )

if (WIN32)
    target_link_libraries(zlog_s
        PUBLIC
        ${UNIXEM_LIBRARY}
        # Ws2_32
        )
endif()

set_target_properties(zlog_s PROPERTIES OUTPUT_NAME zlog)

#================================================================
# generate zlog-chk-conf
#================================================================
if (NOT WIN32)
    add_executable(zlog-chk-conf zlog-chk-conf.c)
    target_link_libraries(zlog-chk-conf zlog)
endif()

#================================================================
# install
#================================================================
list(APPEND zlog_targets zlog zlog_s)
if (NOT WIN32)
    list(APPEND zlog_targets zlog-chk-conf)
endif()

install(TARGETS
    ${zlog_targets}
    COMPONENT zlog
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
    )

install(FILES
    zlog.h
    COMPONENT zlog
    DESTINATION include
    )
