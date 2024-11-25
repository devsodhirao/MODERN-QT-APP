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

# Copy QML test files to build directory
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/unit
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/mock
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
