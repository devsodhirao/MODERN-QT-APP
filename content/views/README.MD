# Modern Qt App Views

## Overview
This directory contains the view components for our modern Qt application. The architecture follows strict separation of concerns and modern Qt best practices.

## File Structure
* `*.ui.qml` - Pure UI components for Qt Design Studio
* `*Imp.qml` - Implementation files containing business logic
* `*GUI.qml` - Base GUI components (if not using Design Studio)

## Architectural Principles

### 1. Separation of Concerns
* UI files (.ui.qml) contain only visual elements and styling
* Implementation files (Imp.qml) handle:
  - Business logic
  - State management
  - Error handling
  - Event handling

### 2. Naming Conventions
* Component IDs use camelCase with "Id" suffix (e.g., rootId, errorDialogId)
* UI files end with .ui.qml
* Implementation files end with Imp.qml
* Properties and functions use camelCase

### 3. Error Handling
* Global error boundary in App.qml
* Component-level error dialogs
* Consistent error message formatting
* Proper user feedback

### 4. State Management
* RootStore for centralized state
* Clean property bindings
* Proper signal/slot connections

### 5. Responsive Design
* Dynamic scaling based on window size
* Flexible layouts
* Proper anchoring

## Qt Design Studio Integration
* UI files are designed to be edited in Qt Design Studio
* Clean separation allows designers to modify UI without affecting logic
* Supports both Qt Creator and Design Studio workflows

## Best Practices
1. Always use property aliases for exposing UI elements
2. Keep UI files purely declarative
3. Handle all logic in implementation files
4. Use consistent error handling patterns
5. Follow the established naming conventions
6. Implement responsive layouts

## Testing
* UI components can be tested independently
* Logic can be unit tested separately
* Support for GUI mockups and simulation