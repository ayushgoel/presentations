class: center, middle, inverse

# Functional Programming
### Ayush Goel

---

.left-column[
 ### Prerequisite
]
.right-column[
  * mit-scheme installed?
]
--

.right-column[
  * Some topics would require hands-on exercises.

     We will be doing a [roulette spin](http://wheeldecide.com/index.php?c1=Ayush&time=5) to decide who is going to do it on projector.
]

---

.left-column[
### Disclaimer
]
.right-column[
* I am not a functional programmer in "authentic" terms. Most of my knowledge comes from doing exercises of SICP and discussing them with people here.
* Scheme is not my everyday choice of languages, thus, stack overflow might help you debug better than me.
]

---
class: center, middle, inverse

# Day 1

---

.left-column[
### What?
]

--

.right-column[
* Wiki - Functional programming is a programming paradigm — a style of building the structure and elements of computer programs — that treats computation as the evaluation of mathematical functions and avoids changing-state and mutable data.
]

--

.right-column-continued[
* Keywords:
  - paradigm, just like imperative is
  - computation as mathematical functions
  - avoid mutable data
]

---

.left-column[
### What makes it possible?
]

--

.right-column[
1. ### Immutable data
]

--

.right-column-continued[
* An immutable piece of data is one that cannot be changed. Duh!
]

---

```
class Vehicle:
  def __init__(self):
    self.petrol = 2

  def description(self):
      desc_str = "I have {0} liters of petrol".format(self.petrol)
      return desc_str
```

--

* `petrol` is immutable right now and can as well be a constant.
* But this isn't how we code (or use a vehicle), right?

---

```
class Vehicle:
  def __init__(self):
    self.petrol = 2

  def addPetrol(self, p):
    self.petrol += p

  def usePetrol(self, p):
    self.petrol -= p

  def description(self):
      desc_str = "I have {0} liters of petrol".format(self.petrol)
      return desc_str
```

--

* Yes, this looks more like a vehicle.

* `petrol` can change at any time
  * anyone can change it

* And now we have mutable state in our Vehicle!

---
class: center, middle, inverse

# 😡
## Mutability

---

.left-column[
### Why 😡 Mutability?
]

--

.right-column[
* There are only two hard things in Computer Science: cache invalidation and naming things. -- Phil Karlton
* In our example of Vehicle, The petrol tank has a sensor of the actual amount of petrol in the vehicle. That is the true value of petrol.
* To map the real world in our objects, we have cached the value of petrol (For easier and faster access) in our class object.
]

--

.right-column-continued[
* Concurrency is much easier with immutable data since no locking is required
]

--

.right-column-continued[
* Code is easier to understand since two code flows using same data would act independently
]

---

.left-column[
### Why 😡 Mutability?
]

.right-column[
Some languages, like .red[Clojure], make all values immutable by default.

Any “mutating” operations copy the value, change it and pass back the changed copy.
]

---

.left-column[
### What makes it possible?
]

--

.right-column[
1. ### Immutable data
2. ### Functions as first class citizens
]

--

.right-column-continued[
* Allow functions to be treated like any other value
  - Created
  - Passed to functions
  - Returned from functions and
  - Stored inside data structures
]

--

.right-column-continued[
* Let's introduce lambdas
]

---

.left-column[
### Lambdas
]

--

.right-column[
* Also known as anonymous function, function literal, lambda abstraction, or lambda expression
* It is a function definition that is not bound to an identifier.
* Usually used as return values from functions.
]

---

.left-column[
### Pure functions
]

--

.right-column[
* Functions that don't change output based on environment.
  * You can also think of them as functions with no side effects. A function has some side effect if it modifies state outside its scope or has observable interaction with outside world.
* Eg:
  - ```
      (define (mult2 x) (* 2 x))
    ```
* Think of them as mathematical functions instead of computational.
]

---

.left-column[
### Higher order functions
]

--

.right-column[
* Functions that either take a function as parameter or return a function as a parameter
* Eg:
   ```
    (define (map f arr)
      (if (null? arr)
        '()
        (cons (f (car arr))
              (map f (cdr arr)))
      ))
    ```

    ```
    > (map mult2 (cons 2 (cons 4 '()))) ; [4 8]
    ```

]

---

.left-column[
### Advantages of Functional Programming
]

--

.right-column[
1. **Concurrent execution** - since pure functions have no side effects, they can run in parallel without synchronization. These concurrent processes are often run on multiple processors.

2. **Determinism** - A process is deterministic if repetitions yield the same result every time.
  1. And thus, **testability** is super easy - Remember how each test requires an environment setup for running with mocks stubs doubles etc etc. That is not required with pure functions since functions depend only on parameters passed to them (instead of probing the environment they are in)

]

---

class: center

#### Functional code is characterised by one thing:
# the absence of side effects

--

It doesn’t rely on data outside the current function,

--

and it doesn’t change data that exists outside the current function.

--

Every other “functional” thing can be derived from this property.

---
class: center, middle, inverse

# Day 2

---
