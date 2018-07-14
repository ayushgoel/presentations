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

.left-column[
## Clang modules
]

.right-column[
* C - include header and link library like `-lLibrary`.
* Modules provide alternative, aim being
  - Simple
  - better compile time scalability
    - Every time a header is included, it's contents are preprocessed and parsed, **transitively**.
    - This has to be repeated for every translation unit in your project.
    - M translation units including N headers require MxN work.
    - C++ is particularly bad because the compilation model forces much code in headers.
  - Fragility
    - #include directives are treated as textual inclusion by the preprocessor, and are therefore subject to any active macro definitions at the time of inclusion.
    - If any of the active macro definitions happens to collide with a name in the library, it can break the library API or cause compilation failures in the library header itself.
    - For an extreme example, #define std "The C++ Standard" and then include a standard library header: the result is a horrific cascade of failures in the C++ Standard Library’s implementation.
    - More subtle real-world problems occur when the headers for two different libraries interact due to macro collisions, and users are forced to reorder #include directives or introduce #undef directives to break the (unintended) dependency.
  - Conventional workarounds:
    - C programmers have adopted a number of conventions to work around the fragility of the C preprocessor model.
    - Include guards, for example, are required for the vast majority of headers to ensure that multiple inclusion doesn’t break the compile. Macro names are written with LONG_PREFIXED_UPPERCASE_IDENTIFIERS to avoid collisions,
    - and some library/framework developers even use __underscored names in headers to avoid collisions with “normal” names that (by convention) shouldn’t even be macros.
    - These conventions are a barrier to entry for developers coming from non-C languages, are boilerplate for more experienced developers, and make our headers far uglier than they should be.
  - Tool Confusion
    - In a C-based language, it is hard to build tools that work well with software libraries, because the boundaries of the libraries are not clear.
    - Which headers belong to a particular library, and in what order should those headers be included to guarantee that they compile correctly?
    - Are the headers C, C++, Objective-C++, or one of the variants of these languages?
    - What declarations in those headers are actually meant to be part of the API, and what declarations are present only because they had to be written as part of the header file?
      - Enums for example can not be extern
* Semantic support
  - import std.io;
  - loads a binary representation of the std.io module
  - and makes its API available to the application directly
  - Preprocessor definitions that precede the import declaration have no impact on the API provided by std.io,
  - because the module itself was compiled as a separate, standalone module.

  - This semantic import model addresses many of the problems of the preprocessor inclusion model:
    - Compile-time scalability:
      - The std.io module is only compiled once, and importing the module into a translation unit is a constant-time operation (independent of module system).
      - Thus, the API of each software library is only parsed once, reducing the M x N compilation problem to an M + N problem.
    - Fragility:
      - Each module is parsed as a standalone entity, so it has a consistent preprocessor environment.
      - This completely eliminates the need for __underscored names and similarly defensive tricks.
      - Moreover, the current preprocessor definitions when an import declaration is encountered are ignored, so one software library can not affect how another software library is compiled, eliminating include-order dependencies.
    - Tool confusion:
      - Modules describe the API of software libraries, and tools can reason about and present a module as a representation of that API. Because modules can only be built standalone, tools can rely on the module definition to ensure that they get the complete API for the library. Moreover, modules can specify which languages they work with, so, e.g., one can not accidentally attempt to load a C++ module into a C program.
* Objective-C
  - `@import std;`
    - The @import declaration above imports the entire contents of the std module (which would contain, e.g., the entire C or C++ standard library)
    - and make its API available within the current translation unit.
  - To import only part of a module, one may use dot syntax to specific a particular submodule, e.g.,
    `@import std.io;`
  - Redundant import declarations are ignored, and one is free to import modules at any point within the translation unit,
    - so long as the import declaration is at global scope.

* Includes as imports
  - The primary user-level feature of modules is the import operation, which provides access to the API of software libraries.
  - However, today’s programs make extensive use of #include, and it is unrealistic to assume that all of this code will change overnight.
  - modules automatically translate #include directives into the corresponding module import.
    - For example, the include directive
    `#include <stdio.h>`
    will be automatically mapped to an import of the module std.io.
    - Even with specific import syntax in the language, this particular feature is important for both adoption and backward compatibility:
    - automatic translation of #include to import allows an application to get the benefits of modules
    - (for all modules-enabled libraries) without any changes to the application itself.
    - Thus, users can easily use modules with one compiler while falling back to the preprocessor-inclusion mechanism with other compilers.

> Note
> The automatic mapping of #include to import also solves an implementation problem: importing a module with a definition of some entity (say, a struct Point) and then parsing a header containing another definition of struct Point would cause a redefinition error, even if it is the same struct Point. By mapping #include to import, the compiler can guarantee that it always sees just the already-parsed definition from the module.

While building a module, #include_next is also supported, with one caveat. The usual behavior of #include_next is to search for the specified filename in the list of include paths, starting from the path after the one in which the current file was found. Because files listed in module maps are not found through include paths, a different strategy is used for #include_next directives in such files: the list of include paths is searched for the specified header name, to find the first include path that would refer to the current file. #include_next is interpreted as if the current file had been found in that path. If this search finds a file named by a module map, the #include_next directive is translated into an import, just like for a #include directive.“

]

.footnote.red[At present, there is no C or C++ syntax for import declarations. Clang will track the modules proposal in the C++ committee.]

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
