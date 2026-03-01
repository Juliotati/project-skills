# Refactoring Example: Widget Functions vs. Concrete Widgets

The following comparison demonstrates the "Divide and Conquer" principle. By extracting logic into concrete widgets, we improve readability, maintainability, and allow Flutter to optimize the build tree via `const` constructors.

## ❌ BAD: Widget Functions
- Prevents `const` optimizations across the tree.
- Creates a massive, unreadable `build` method in a single class.
- Rebuilds every function within the class whenever any state change occurs.

```dart
class A extends StatelessWidget {
  const A({required this.post, super.key});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(context),
        _buildContent(context),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
   // {...}
  }

  Widget _buildContent(BuildContext context) {
   // {...}
  }
  Widget _buildFooter(BuildContext context) {
   // {...}
  }
}
```

## ✅ GOOD: Concrete Widgets
- Supports const constructors for high-performance builds.
- Each widget is self-contained and easier to unit test.
- Reduces the total line count of the parent widget below the 200-line threshold.

```dart
class B extends StatelessWidget {
  const B({required this.post, super.key});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BTitle(),
        const BContent(),
        const BFooter(),
      ],
    );
  }
}

class BTitle extends StatelessWidget {
  const BTitle ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class BContent extends StatelessWidget {
  const BContent ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class BFooter extends StatelessWidget {
  const BFooter ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

---

### Final Quality Checklist for this Skill:
* **Backbone:** Adheres strictly to your `analysis_options.yaml`.
* **Limits:** Enforces max 5 parameters for functions and max 7 for widgets.
* **Structure:** Mandatory named parameters for multi-parameter signatures.
* **Cleanliness:** Refactors any widget exceeding 200 lines.
