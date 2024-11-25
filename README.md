# Modern Qt Demo

A modern Qt/QML application showcasing clean architecture, design patterns, and best practices for Qt 6.5 development. This project demonstrates how to build maintainable, testable Qt applications with a focus on separation of concerns and modern UI design.

## Key Design Principles

### 1. Clean Architecture
- **UI/Logic Separation**: Strict separation between UI components and business logic
- **Mock-First Design**: Backend interfaces with both production (C++) and mock (QML) implementations
- **State Management**: Centralized state handling through RootStore pattern

### 2. Modern UI Architecture
- **Design/Implementation Split**: 
  - `.ui.qml` files for pure design (Qt Design Studio compatible)
  - `.qml` files for implementation logic
- **Reusable Components**: 
  - Custom controls with consistent styling
  - Separation between visual design and behavior
- **Qt Style Integration**: Leveraging Qt Quick Controls 2 with custom styling

### 3. Authentication System
- **Role-Based Access**: 
  - User and Admin roles with distinct permissions
  - Clean separation between authentication logic and UI
- **Security Features**:
  - Account lockout protection
  - Secure credential validation
  - Mock backend for development and testing

## Project Structure

```
modern-qt-app/
├── backend/           # C++ backend implementation
│   ├── loginstore.*  # Authentication and user management
│   └── rootstore.*   # Central state management
├── backend_mock/     # QML mock implementations
│   └── Backend/      # Mock stores for development
├── content/          # UI Components
│   ├── controls/     # Reusable UI elements
│   ├── panels/      # Functional UI sections
│   └── views/       # Main application views
├── src/             # Application entry point
└── tests/           # Test suite
    ├── backend/     # C++ tests
    │   ├── unit/    # Individual component tests
    │   └── integration/ # Component interaction tests
    └── qml/         # QML and UI tests
        ├── unit/    # Component tests
        └── mock/    # Mock backend tests
```

## Development Setup

### Requirements
- Qt 6.5 or higher
- CMake 3.21.1 or higher
- C++17 compatible compiler
- Qt Test framework for testing

### Build & Run
1. Clone the repository
2. Open in Qt Creator or Qt Design Studio
3. Build and run the project

### Test Credentials
- Regular User:
  - Username: "user"
  - Password: "demo"
- Administrator:
  - Username: "admin"
  - Password: "admin"

## Building and Testing

### Building the Project

1. **Configure the build**:
```bash
# For production backend
cmake -B build -DCMAKE_BUILD_TYPE=Release

# For development with mock backend
cmake -B build -DUSE_MOCK_BACKEND=ON -DCMAKE_BUILD_TYPE=Debug
```

2. **Build the project**:
```bash
cmake --build build
```

3. **Run the application**:
```bash
./build/src/modern-qt-app
```

### Running Tests

1. **Run all tests**:
```bash
cd build && ctest --output-on-failure
```

2. **Run specific test categories**:
```bash
# Backend unit tests
./build/tests/backend/unit/tst_loginstore

# Backend integration tests
./build/tests/backend/integration/tst_rootstore_integration

# QML tests (requires X server or virtual framebuffer)
QML2_IMPORT_PATH=build/imports ./build/tests/qml/tst_demolabel
```

3. **Run tests with coverage** (requires gcov):
```bash
# Configure with coverage
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DENABLE_COVERAGE=ON

# Build and run tests
cmake --build build
cd build && ctest

# Generate coverage report
gcovr -r .. .
```

### Development Workflow

1. **Qt Creator Setup**:
   - Open `CMakeLists.txt` as project
   - Configure build kit with Qt 6.5
   - Select desired backend (mock/production)
   - Build and run

2. **Qt Design Studio**:
   - Open `.ui.qml` files for visual editing
   - Preview components with mock data
   - Export changes back to project

3. **Testing Workflow**:
   - Write tests before implementation
   - Run tests frequently during development
   - Verify both mock and production behavior

### Troubleshooting

1. **QML Import Issues**:
   - Verify `QML2_IMPORT_PATH` includes build/imports
   - Check import statements in QML files
   - Review CMake configuration

2. **Test Failures**:
   - Run failed tests with verbose output
   - Check mock vs production configuration
   - Verify Qt environment setup

3. **Build Issues**:
   - Clean build directory
   - Update Qt and CMake
   - Check compiler compatibility

## Design Patterns Used

1. **Store Pattern**
   - Centralized state management via RootStore
   - Individual stores for specific functionality (e.g., LoginStore)

2. **Mock Backend Pattern**
   - QML-based mock implementations for rapid UI development
   - C++ production backend with identical interface
   - Interface consistency verified through tests

3. **UI Component Pattern**
   - Separation of design (.ui.qml) and logic (.qml)
   - Reusable controls with consistent styling

## Testing Strategy

### 1. Unit Testing
- C++ backend tests using Qt Test framework
- Mock object testing for isolated components
- Coverage reporting for backend code

### 2. QML Testing
- QML test runner for frontend components
- Visual test cases for UI components
- Event simulation for interaction testing

### 3. Integration Testing
- Mock vs Backend behavior comparison
- Interface compliance verification
- State management validation
- Performance benchmarking

### 4. Test Automation
- Automated test suite with CTest
- Support for both mock and production backends
- Visual component testing
- Coverage reporting with gcov

## Future Enhancements

1. **Security**
   - Multi-factor authentication
   - Session management
   - Enhanced audit logging

2. **UI/UX**
   - Theme customization
   - Accessibility features
   - Animation system

3. **Developer Experience**
   - Hot reload capabilities
   - Mock data generation
   - Enhanced debugging tools

## Contributing

The project follows these guidelines:
- Clean separation of concerns
- Consistent naming conventions
- Comprehensive documentation
- Test-driven development approach

## License

[Your License Here]