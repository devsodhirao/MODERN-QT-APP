cmake_minimum_required(VERSION 3.21.1)

# Enable testing for the project
enable_testing()

# Find required Qt packages
find_package(Qt6 REQUIRED COMPONENTS
    Core
    Test
    Quick
    QuickTest
)

# Option to choose between mock and production backend
option(USE_MOCK_BACKEND "Use mock backend for testing" OFF)

# Backend tests (C++)
add_subdirectory(backend)

# QML tests
add_subdirectory(qml)

# Configure test environment
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/test_config.h.in
    ${CMAKE_CURRENT_BINARY_DIR}/test_config.h
)
