This is a simple package which helps you debug while writing tests. It pinpoints what is wrong with your data when comparing Equatable objects

## Getting started

Add the [equatable](https://pub.dev/packages/equatable) package.

## Usage

```dart
const TwiceNestedEquatable tTwiceNestedEquatable = TwiceNestedEquatable(
    'id', tFlatEquatable, OnceNestedEquatable('id', FlatEquatable('id', 'title')));

const TwiceNestedEquatable tTwiceNestedEquatableWrong = TwiceNestedEquatable(
    'id', tFlatEquatable, OnceNestedEquatable('id', FlatEquatable('id', 'titleWrong')));

test(description, () {
  // assert
  equatableExpect(
            tTwiceNestedEquatableWrong, tTwiceNestedEquatable);
});
```

Which outputs:

```
Expected: 'title'
  Actual: 'titleWrong'
   Which: is different. Both strings start the same, but the actual value also has the following trailing characters: Wrong

Path: TwiceNestedEquatable -> OnceNestedEquatable -> FlatEquatable -> String (Actual) / String (Matcher)
```
