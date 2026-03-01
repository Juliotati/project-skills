# Refactoring Example: Functions vs. Classes

## ❌ BAD (Helper Functions)
- Harder to optimize with `const`.
- Creates a single massive build method.
- Rebuilds everything in the function even if only one part changed.

```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      _header(),
      _body(),
    ],
  );
}
```

## ✅ GOOD (Concrete Widgets)
- Supports const for performance.
- Separates logic per component.
- Easier to test and reuse.

```dart
Widget build(BuildContext context) {
  return const Column(
    children: [
      HeaderWidget(),
      BodyWidget(),
    ],
  );
}
```
