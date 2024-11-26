# QML Tests

# Function to add QML test
function(add_qml_test TEST_NAME TEST_FILE)
    add_test(NAME ${TEST_NAME}
        COMMAND ${CMAKE_COMMAND} -E env 
            QML2_IMPORT_PATH=${CMAKE_BINARY_DIR}/imports
            QT_QPA_PLATFORM=offscreen
            ${Qt6_DIR}/../../bin/qmltestrunner 
            -input ${TEST_FILE}
    )
endfunction()

# Add QML tests
add_qml_test(tst_demolabel unit/tst_demolabel.qml)
add_qml_test(tst_loginstore_mock mock/tst_loginstore.qml)
add_qml_test(tst_login_comparison comparison/tst_login_comparison.qml)

# Copy QML test files to build directory
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/unit
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/mock
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/comparison
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

set(qml_test_files
    unit/tst_demolabel.qml
    unit/tst_demobutton.qml
    unit/tst_loginpanel.qml
    unit/tst_homeview.qml
)

add_custom_target(qml_tests ALL
    SOURCES ${qml_test_files}
)

# Copy test files to build directory
foreach(test_file ${qml_test_files})
    get_filename_component(test_name ${test_file} NAME)
    configure_file(${test_file} ${CMAKE_CURRENT_BINARY_DIR}/${test_name} COPYONLY)
endforeach()

# Add test runner
add_test(NAME QmlTests
    COMMAND qmltestrunner
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
