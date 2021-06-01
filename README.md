# Combine Framework
A `declarative` Swift API for processing values over time. 

**Build Blocks of Combine**
1. `Publishers` (Emits data)
  - Defines how values and errors are produced 
  - Value Type
  - Allows registeration of a Subscriber

2. `Subscribers` (Receives data)
- Receive values and completion
- Reference Type


4. `Operators` (Act on data received from upstream publishers that fits your need)
- Adopts Publisher
- Describe a behaviour for changing values
- Subscribes to a Publisher ("upstream")
- Send results to a Subscribe ("downstream")
- Value Type

## Swift: Combine Basics & Intro

In this example we will learn about the basics of the Apple Combine framework with swift and iOS. Combine is Apple's own reactive data framework similar to RxSwift and Redux. Its useful and especially interesting to integrate with SwiftUI.

- **Future** (A publisher that eventually produces a single value and then finishes or fails)
- **PassthroughSubject** A subject that broadcasts elements to downstream subscribers. As a concrete implementation of `Subject`, the `PassthroughSubject` provides a convenient way to adapt existing imperative code to the Combine model. Unlike `CurrentValueSubject`, a `PassthroughSubject` doesn’t have an initial value or a buffer of the most recently-published element. A `PassthroughSubject` drops values if there are no subscribers, or its current demand is zero.
