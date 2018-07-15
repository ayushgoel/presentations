class: center, middle, inverse

# Clang Modules
### Ayush Goel

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

]

.footnote.red[At present, there is no C or C++ syntax for import declarations. Clang will track the modules proposal in the C++ committee.]

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
]

.right-column[
]

---

.left-column[
## Reference
]

.right-column[
* https://clang.llvm.org/docs/Modules.html
]

---

* This presentation is available at https://github.com/ayushgoel/presentations/

]

---

class: center, middle, inverse

# Thank you!

### Share your feedback
