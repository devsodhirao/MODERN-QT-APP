# 🚀 Modern Qt Demo

> A simple example of building clean, modern Qt applications with Design Studio and Qt Creator hand in hand. Based on my own work as well as input from one of the authors for Qt CoreUI, Bram Santoso. 
> I am also developing an AI agent that will drastically speed up this type of structured design, CI/CD with potentailly even squish testing, making the turnaround on prototypes and production code, significantly faster.


## 🏆 Key Wins

- **Designer-Developer Harmony**
  - Designers work freely in Qt Design Studio with `.ui.qml` files
  - Developers implement logic in parallel with `.qml` files
  - No stepping on each other's toes

- **Rapid Prototyping**
  - Mock backend lets you build UI without waiting for backend
  - Instant feedback during development
  - Quick iterations with stakeholders

- **Clean Architecture**
  - Perfect separation between UI and logic
  - Easy to modify one without breaking the other
  - Clear boundaries make maintenance a breeze

- **Production Ready**
  - Seamless switch from mock to real backend
  - Same interface, different implementation
  - No UI changes needed when going live

- **Testing Paradise**
  - UI can be tested independently
  - Backend can be tested separately
  - Easy to verify both implementations match

## 🎯 Core Concept

We believe in a clean, iterative approach to Qt development:

1. 🎨 **Start with the UI** (.ui.qml)
   ```qml
   // Pure design, no logic
   Rectangle {
       TextField { placeholderText: "Username" }
       Button { text: "Login" }
   }
   ```

2. 🔄 **Add the Logic** (.qml)
   ```qml
   // Clean implementation
   LoginPanelGUI {
       onLoginClicked: {
           rootStore.loginStore.login(username, password)
       }
   }
   ```

3. ⚡ **Mock First Development**
   ```qml
   // Quick iteration with mock backend
   QtObject {
       function login(username, password) {
           // Instant feedback during development
           return username === "user" || username === "admin"
       }
   }
   ```

## 📦 Project Structure

Our clean architecture is reflected in the directory structure:

```
modern-qt-app/
│
├── 📱 UI Layer
│   ├── content/
│   │   ├── controls/   # Reusable UI components
│   │   ├── panels/     # Feature-specific views
│   │   └── views/      # Main application views
│   ├── imports/        # QML imports and modules
│   └── asset_imports/  # Design assets and resources
│
├── 🔧 Backend Layer
│   ├── backend/        # C++ production code
│   └── backend_mock/   # QML rapid development
│
└── 🧪 Tests (WIP)
    ├── backend/        # C++ unit tests
    └── qml/            # QML & integration tests
```

## ⚡ Development Flow

1. **Mock Backend** → Start here for rapid development
   - Quick iteration
   - Instant feedback
   - No backend dependencies

2. **UI Development** → Build against mock
   - Pure design in .ui.qml
   - Clean logic in .qml
   - Clear separation

3. **Production Ready** → Real backend
   - C++ implementation
   - Drop-in replacement
   - No UI changes needed

## 🎨 Design Principles

### Clean Separation

| Layer | File | Purpose |
|-------|------|---------|
| UI | `.ui.qml` | Pure design, layouts, styling |
| Logic | `.qml` | Business logic, user interaction |
| Backend | `C++/QML` | Core functionality, data management |

### State Management

```
RootStore
└── LoginStore      # Authentication state
```

## 🛠️ Tech Stack

- **Qt 6.2**
  - QML for modern UI
  - C++ for backend
  - Qt Quick Controls 2

- **Build System**
  - CMake configuration
  - Clean dependency management
  - Mock/production switching

## 🚀 Getting Started

### Prerequisites
- Qt 6.2 or higher
- Qt Creator or Qt Design Studio
- CMake 3.21.1 or higher

### Building the Project
1. Clone the repository
2. Open the project in Qt Creator
3. Configure the project with your Qt kit
4. Build and run

### Mock Backend Credentials
For testing with the mock backend, use these credentials:

| Role | Username | Password |
|------|----------|----------|
| User | `user` | `user` |
| Admin | `admin` | `admin` |

The mock backend provides:
- Console logging with "[Mock]" prefix
- System messages for login/logout events
- Different access levels (User/Admin)
- Instant feedback without backend setup

### Development Tips
- Use the mock backend for rapid UI development
- Check console logs for "[Mock]" messages to track state
- System messages provide user-friendly status updates
- Switch between mock and real backend without UI changes
