class: center, middle, inverse

# Functional Programming
### Ayush Goel

---

.left-column[
 ### Prerequisite
]
.right-column[
  1. Clisp installed?
]
---

.left-column[
 ### Rule:
]

.right-column[
Some topics would require hands-on exercises.

We will be doing a [roulette spin](http://wheeldecide.com/index.php?c1=Ayush&time=5) to decide who is going to do it on projector.
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
  - paradigm
  - computation as mathematical functions
  - avoid mutable data
]

---

.left-column[
### What makes it possible?
]

--

.right-column[
* Immutable data
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

* `petrol` can change at any time by anyone.
* Yes, this looks more like a vehicle.
* And now we have mutable state in our Vehicle!

---
class: center, middle, inverse

# 😡
## Mutability
