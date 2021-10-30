# ``swift_event``

Classes to ease observer pattern implementation in Swift inspired by C# build-in `event`

## Overview

This package is built arround the following principes :

1. **Genericity** : every classes supports generic

2. **Simplicity** : inspired by C# event `swift-event` supports subscribe (via `+=` and `subscribe()`), unsubcribe (via `-=` and `unsubscribe()`) and notify via `invoke`.

3. **Encapsulation** : `invoke` is not accessible outside of declaration scope, preventing other classes from breaking internal logic.

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:Installation>
- <doc:Tutorials>
