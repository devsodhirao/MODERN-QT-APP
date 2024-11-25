# Backend tests

# Unit tests
add_subdirectory(unit)

# Integration tests
add_subdirectory(integration)

# Common test utilities
add_library(test_utils STATIC
    test_utils.cpp
    test_utils.h
)

target_link_libraries(test_utils
    PRIVATE
        Qt::Core
        Qt::Test
)

target_include_directories(test_utils
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_BINARY_DIR}
)
