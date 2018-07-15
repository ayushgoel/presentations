class: center, middle, inverse

# Frameworks & Libraries
### Ayush Goel

---

.left-column[
## Making a product
]

.right-column[
## a.c
Preprocess - Removal of Comments
Expansion of Macros
Expansion of the included files.
## a.i
Compile - Generate intermediate output
## a.s
Assembly - Convert to machine code
## a.o
Link - combine multiple object files into one
## a.exe

-> Execute

Load
Execute

]

---

.left-column[
## Library
]

.right-column[
* Library is a packaged collection of object files that program can link against.
* "a library". It is a collection of objects/functions/methods (depending on your language) and your application "links" against it and thus can use the objects/functions/methods. It is basically a file containing re-usable code that can usually be shared among multiple applications (you don't have to write the same code over and over again).
* Can be:
  - Static
  - Shared
]

---

.left-column[
## Static Library
]

.right-column[
* Objects that live in a static library is physically copied into the final executable.
* The problem with static library is if the same static library is being used by multiple programs, the static library will get copied.
]

.footnote[Till iOS 8 this was the only option]

---

.left-column[
## Shared Library
]

.right-column[
* Instead of just copying the code into a program, just the reference is included.
* `LD_LIBRARY_PATH`
* Program is executed -> Loader Finds the shared Library -> Loads the Shared Library unto memory – > Resolves the symbols or fixes the reference
* Shared Library on a Mac OSX will have an extension of .dylib (dynamic library)

```
$ nm -mg /Applications/Flock.app/Contents/MacOS/Flock
                 (undefined) external _AtomInitializeICUandStartNode (from Electron Framework)
                 (undefined) external _AtomMain (from Electron Framework)
0000000100000000 (__TEXT,__text) [referenced dynamically] external __mh_execute_header
                 (undefined) external _getenv (from libSystem)
0000000100000f00 (__TEXT,__text) external _main
                 (undefined) external dyld_stub_binder (from libSystem)
```

]

---

.left-column[
## Frameworks
]

.right-column[
* **Actually these terms can mean a lot of different things depending the context they are used.**
  - Mac OS X frameworks are just libraries, packed into a bundle.
* you have everything within a single package you need to use the library in your application (a C/C++/Objective-C library without .h files is pretty useless, unless you write them yourself according to some library documentation), instead of a bunch of files to move around (a Mac bundle is just a directory on the Unix level, but the UI treats it like a single file, pretty much like you have JAR files in Java and when you click it, you usually don't see what's inside, unless you explicitly select to show the content).
* Libraries only has executable code. A framework is a bundle (Directory structure) that contains shared libraries as well as sub directories of headers and other resources
* Can include:
  - Shared Library
  - Header Files describing the API
  - Documentation
  - Additional Resources
    - Views
    - Controls
    - Custom Appearance/ UI
    - Assets
    - Configuration files
* Can have multiple versions available for executable

MyCustomFramework.framework structure

* Sub Framework 1
* Sub Framework 2
* Version 1.0
  - Library
  - Header
  - Resources
* Version 1.1 (Current Version – Symbolic Link)
  - Library
  - Header
  - Resources
]

---

.left-column[
## Advantages of Frameworks
]

.right-column[
* Including frameworks in the applications bundle works great but if the plan is to put the framework in the /Library/Frameworks/ folder then that would require admin access and might lead to versioning issues.
* Resource Types – We cannot carry assets along with a static library. The .a is separate from the headers and thus the headers also needs to be included. With Frameworks we can package absolutely anything into one single unit
* Live Views – If we have custom views included in a framework & the framework is included in a project, All those custom views gets available in the interface builder
* In case of reuse between an application and an extension, rather than putting the code in the target for both, the code should be put in a framework and the framework would be linked from both the app and the extension.
  - Lesser app size
  - Memory Footprint – System loads the framework onto memory as needed & Shares one copy of the resources amongst all applications.
* Backward Compatibility – Multiple versions of the framework can be included in the same bundle ensuring backward compatibility.
* Similar to Dynamic Library – The executable code in a framework bundle is a dynamically linked shared library or simply a dynamic shared library.
]

---

.left-column[
# Interesting
]

.right-column[
* Private vs Public – Frameworks can be private (to be used by our own apps only) or public (to be used by other developers).  Private frameworks (In the App Bundle – Using a copy file build phase where the resource type is Frameworks, this accounts to increase in the app bundle size similar to the inclusion of Static Libraries)
]

---

.left-column[
## Location / Deployment of Frameworks
]

.right-column[
/Library/Frameworks (for all users)
~/Library/Frameworks (for one users)
/Network/Library/Framework (slowest – performance penalties)
/System/Library/Frameworks (Reserved for Apple provided frameworks only)
In the App Bundle – Private frameworks (Using a copy file build phase where the resource type is Frameworks)
**iOS**
]

---

---

.left-column[
## Modular framework
]

.right-column[
* A modular framework is a framework that contains a module map.
* for Xcode to generate the module map file, a framework has to have an umbrella header with the same name of the framework and to have the Define Module (DEFINES_MODULE) build settings set to yes.

```
framework module AFramework {
  umbrella header "AFramework.h"

  export *
  module * { export * }
}
```
]

---

.left-column[
]

.right-column[
]

---

.left-column[
]

.right-column[
]

---

.left-column[
]

.right-column[
]

---

.left-column[
]

.right-column[
]

---

.left-column[
]

.right-column[
]

---

.left-column[
## Reference
]

.right-column[
* System frameworks - /System/Library/Frameworks/
* http://www.tenouk.com/ModuleW.html
* http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html
]

---

* This presentation is available at https://github.com/ayushgoel/presentations/

]

---

class: center, middle, inverse

# Thank you!

### Share your feedback
