find_package(Qt6 REQUIRED COMPONENTS 
    Core
    Gui
    Qml
    Quick
)

qt_add_qml_module(backend
    URI Backend
    VERSION 1.0
    SOURCES
        loginstore.cpp loginstore.h
        rootstore.cpp rootstore.h
    OUTPUT_DIRECTORY
        ${CMAKE_BINARY_DIR}/qml/Backend
)

target_link_libraries(backend
    PRIVATE
        Qt::Core
        Qt::Gui
        Qt::Qml
        Qt::Quick
)

# Set C++ standard
set_target_properties(backend PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
)
