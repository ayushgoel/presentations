class: center, middle

# Unit Testing

---

class: center, middle

# What is Testing?

--

##Software testing is an investigation conducted to provide stakeholders with information about the quality of the product or service under test.
Wikipedia

---
class: center, middle

# Why Test?

---
class: center, middle

## Let's start with a story

---
class: center, middle

###1. On August 1, 2012, `Knight Capital` deployed software to a production environment which contained an obsolete function.

---
class: center, middle

###2. The technician forgot to copy the new Retail Liquidity Program (RLP) code to one of the eight SMARS computer servers.

---
class: center, middle

###3. RLP code repurposed a flag that was formerly used to activate the old function known as 'Power Peg'.

####Note: Power Peg, RLP and SMARS are irrelevant!

---
class: center, middle

###4. Orders sent with the repurposed flag to the eighth server triggered the defective Power Peg code still present on that server.

???
So the first 7 servers were sending flawed requests to the eighth server.

---
class: center, middle

###In the first 45 minutes the market was open the Power Peg code received and processed 212 parent orders. As a result SMARS sent millions of child orders into the market resulting in 4 million transactions against 154 stocks for more than 397 million shares.

##$460 million loss in 45 minutes!

---
class: center, middle

#😱

---
class: center, middle

####So Why Test?

### Because your code deals with money!

---
class: center, middle

Secondly,
#Confidence

???
* Take a student
* tell him that he has to write a func f2 based on your f1.
* How does he know, who is writing wrong code?

---
class: center, middle

# Static Testing
> "Did we build the right system?"

???
* verification and validation
* static testing is the verification part of software testing
* "Did we build the right system?"

---
class: middle

* Document reviews
* Walkthroughs
* Inspection
* Feasibility analysis or any other form of analysis to determine if the software is what it should be or not
* Code review

---
class: center, middle

# Dynamic Testing
> “Did we build the system right?”

???
* validation

---
class: middle

* Unit Testing
* Integration Testing
* System Testing

???
Unit - stack
Integration -
---
class: center, middle

#White Box Testing

###A method of testing software that tests internal structures or workings of an application, as opposed to its functionality.

---
class: center, middle

#Black Box Testing

###Examine the functionality of an application without peering into its internal structures or workings.

---
class: center, middle

#Dependency management

---
class: center, middle

##1. Dummy 
##4. Fake 
##2. Stub 
##3. Mock 
##5. Spy

---
class: center, middle

##1. Dummy 

???
a placeholder required to pass the unit test.
no calls on dummy

---
class: center, middle

##2. Fake 

???
used to simplify a dependency so that unit test can pass easily.
implementations should not be called
can be empty implementations

---
class: center, middle

##3. Stub 

???
used to provide indirect inputs
implementations return required objects
think dice with definite result

---
class: center, middle

##4. Mock 

???
Indirect Outputs
don’t return to system
are encapsulated by collaborator
example of this is logging

---
class: center, middle

##5. Spy

???
Instead of setting up behavior expectations, Spy records calls made to the collaborator.
doesn’t care about the inputs passed to Log
, it just records the Log calls and asserts them

---
class: center, middle

#Test early.
#Test often.
#Test automatically.
