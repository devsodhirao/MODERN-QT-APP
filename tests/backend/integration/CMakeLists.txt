# Backend integration tests

add_executable(tst_rootstore_integration
    tst_rootstore_integration.cpp
)

target_link_libraries(tst_rootstore_integration
    PRIVATE
        Qt::Core
        Qt::Test
        backend
        test_utils
)

add_test(NAME tst_rootstore_integration COMMAND tst_rootstore_integration)

# Configure test to use mock or production backend
if(USE_MOCK_BACKEND)
    target_compile_definitions(tst_rootstore_integration PRIVATE USE_MOCK_BACKEND)
endif()
