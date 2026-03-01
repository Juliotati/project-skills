# High-Quality Widget Patterns

### Why Concrete Widgets?
Concrete widgets (classes) are superior to helper functions because:
1. They have their own lifecycle.
2. They support `const` constructors, which reduces rebuild overhead.
3. They provide a cleaner stack trace during debugging.

### Refactoring Guidelines
- **Parameter Grouping:**
    - Instead of: `MyWidget(name, age, height, weight, hairColor, eyeColor, address)`
    - Use: `MyWidget(user: userInstance)` where `userInstance` contains those properties.
- **Tree Depth:**
    - If your `build` method has more than 5 levels of indentation, it is time to extract a sub-widget.
