# Backend unit tests

# LoginStore test
add_executable(tst_loginstore
    tst_loginstore.cpp
)

target_link_libraries(tst_loginstore
    PRIVATE
        Qt::Core
        Qt::Test
        backend
        test_utils
)

add_test(NAME tst_loginstore COMMAND tst_loginstore)

# Configure test to use mock or production backend
if(USE_MOCK_BACKEND)
    target_compile_definitions(tst_loginstore PRIVATE USE_MOCK_BACKEND)
endif()
