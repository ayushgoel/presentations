class: center, middle, inverse

# Clang Modules
### Ayush Goel

---

.left-column[
## Clang modules
]

.right-column[
* C - include header and link library like `-lLibrary`.
]

--

.right-column[
* **Modules provide alternative**
]

---

.left-column[
## Aim
]

.right-column[
# 1.

## Simple

We will get to this 🚶‍♂️
]

---

.left-column[
## Aim
]

.right-column[
# 2.

## Better compile time scalability
]

???
* Every time a header is included, it's contents are preprocessed and parsed, **transitively**.
* This has to be repeated for every translation unit in your project.

--
.right-column[
* M translation units including N headers require MxN work.
]
--
.right-column[
* C++ is particularly bad because the compilation model forces much code in headers. (**Wat?**)
]

---

.left-column[
## Aim
]

.right-column[
# 3.

## Fragility

* Macro definitions
]

???

- textual inclusion - preprocessor - active macro definitions impact includes
  - include directives are treated as textual inclusion by the preprocessor, and are therefore subject to any active macro definitions at the time of inclusion.
- can break library API - compilation failure
  - If any of the active macro definitions happens to collide with a name in the library, it can break the library API or cause compilation failures in the library header itself.

--

.right-column[
* For an extreme example, #define std "The C++ Standard" and then include a standard library header.
]

???

* macro collision
  * When the headers for two different libraries interact due to macro collisions

--

.right-column[
* Users solve this via:
  * reorder #include directives
  * introduce #undef directives
]

---
name: aim-convention

.left-column[
## Aim
]

.right-column[
# 4.

## Get rid of workarounds becoming conventions!

]

???
* fragility - birth to undesired conventions - raising bar to do development
  * C programmers have adopted a number of conventions to work around the fragility of the C preprocessor model.

---
template: aim-convention

.right-column[
* Include guards
  ```
  #ifndef _AFNETWORKING_
  #define _AFNETWORKING_
    // do stuff
  #endif
  ```
]

???
* Multiple inclusion
* LONG_PREFIXED_UPPERCASE_IDENTIFIERS avoid collision
  * for example, guards are required for the vast majority of headers to ensure that multiple inclusion doesn’t break the compile. Macro names are written with LONG_PREFIXED_UPPERCASE_IDENTIFIERS to avoid collisions,
* __UNDERSCORED too to avoid with normal

---
template: aim-convention

.right-column[
### Effects

* Superfluous code
* Entry barrier
* Ugly code
]

???
* macro that shouldn't even be macro
  * Some library/framework developers even use __underscored names in headers to avoid collisions with “normal” names that (by convention) shouldn’t even be macros.
* Entry barrier
* Ugly code
  * These conventions are a barrier to entry for developers coming from non-C languages, are boilerplate for more experienced developers, and make our headers far uglier than they should be.

---

.left-column[
## Aim
]

.right-column[
# 5.

## Tool Confusion

* boundaries of libraries are not clear
]

???
* which headers are for consumption
* order of include
* C, C++, Objective-C++ ?
* What declarations only because they need to be there
  - Example enums

 --
  - In a C-based language, it is hard to build tools that work well with software libraries, because the boundaries of the libraries are not clear.
  - Which headers belong to a particular library, and in what order should those headers be included to guarantee that they compile correctly?
  - Are the headers C, C++, Objective-C++, or one of the variants of these languages?
  - What declarations in those headers are actually meant to be part of the API, and what declarations are present only because they had to be written as part of the header file?
    - Enums for example can not be extern

---

.left-column[
## Semantic support
]

.right-column[
> import std.io;
]

--

.right-column[
* Load a binary representation of the std.io module
* Make its API available to the application directly
]

---
layout: true

.left-column[
## Semantic support
### Problems addressed
]

---

.right-column[
# 1.

## Compile-time scalability:

> import std.io;

]

???

* compiled only once
* import O(1)
* MxN becomes M+N
  - The std.io module is only compiled once, and importing the module into a translation unit is a constant-time operation (independent of module system).
  - Thus, the API of each software library is only parsed once, reducing the M x N compilation problem to an M + N problem.

---

.right-column[
# 2.
## Fragility

* Macro definitions
* Guard blocks and defense tricks
]

???

* macro defined beforehand no impact
* library impact another NO
* Eliminate __UNDERSCORED macros
* No defense tricks
  - Each module is parsed as a standalone entity, so it has a consistent preprocessor environment.
  - Preprocessor definitions that precede the import declaration have no impact on the API provided by std.io because the module was compiled as a separate, standalone module.
  - This completely eliminates the need for __underscored names and similarly defensive tricks.
  - Moreover, the current preprocessor definitions when an import declaration is encountered are ignored, so one software library can not affect how another software library is compiled, eliminating include-order dependencies.

---

.right-column[
# 3.
## Tool confusion

* Better API to reason
* Describe language - C, C++ etc (no accidents)

]

???
- Modules describe the API of software libraries, and tools can reason about and present a module as a representation of that API. Because modules can only be built standalone, tools can rely on the module definition to ensure that they get the complete API for the library. Moreover, modules can specify which languages they work with, so, e.g., one can not accidentally attempt to load a C++ module into a C program.

---

layout: true

.left-column[
## Objective-C support
]

---

.right-column[
> `@import std;`

* Imports the entire std module
  * (which would contain, e.g., the entire C or C++ standard library)
* Makes API available within the current translation unit.


* Use dot syntax to use particular submodule, e.g.,

> `@import std.io;`
]

---

.right-column[
Notes:
* Redundant import declarations are ignored.
* Import anytime at global scope
]

.footnote.red.small[At present, there is no C or C++ syntax for import declarations. Clang will track the modules proposal in the C++ committee.]

---
layout: false

.left-column[
## Includes as imports
]

.right-column[
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
]

---

.left-column[
## Includes as imports
### Note
]

.right-column[
> The automatic mapping of #include to import also solves an implementation problem: **Redefinition**.

Importing a module with a definition of some entity (say, a struct Point) and then parsing a header containing another definition of struct Point would cause a redefinition error, even if it is the same struct Point. By mapping #include to import, the compiler can guarantee that it always sees just the already-parsed definition from the module.
]

---

.left-column[
## Module Maps
]

.right-column[
The crucial link between modules and headers is described by a module map, which describes how a collection of existing headers maps on to the (logical) structure of a module.
]

---

.left-column[
## Module Maps
]

.right-column[
For example, one could imagine a module std covering the C standard library. Each of the C standard library headers (`<stdio.h>`, `<stdlib.h>`, `<math.h>`, etc.) would contribute to the std module, by placing their respective APIs into the corresponding submodule (std.io, std.lib, std.math, etc.).
Having a list of the headers that are part of the std module allows the compiler to build the std module as a standalone entity, and having the mapping from header names to (sub)modules allows the automatic translation of #include directives to module imports.

]

---

.left-column[
## Module Maps
]

.right-column[

Module maps are specified as separate files (each named module.modulemap) alongside the headers they describe, which allows them to be added to existing software libraries without having to change the library headers themselves.

Note

To actually see any benefits from modules, one first has to introduce module maps for the underlying C standard library and the libraries and headers on which it depends.

]

---

.left-column[
## Compilation model
]

.right-column[
The binary representation of modules is automatically generated by the compiler on an as-needed basis. When a module is imported (e.g., by an #include of one of the module’s headers), the compiler will spawn a second instance of itself [in a thread], to parse just the headers in that module. The resulting Abstract Syntax Tree (AST) is then persisted into the binary representation of the module that is then loaded into translation unit where the module import was encountered.

The binary representation of modules is persisted in the module cache. Imports of a module will first query the module cache and, if a binary representation of the required module is already available, will load that representation directly.

Thus, **a module’s headers will only be parsed once per language configuration, rather than once per translation unit that uses the module.**

Modules maintain references to each of the headers that were part of the module build. If any of those headers changes, or if any of the modules on which a module depends change, then the module will be (automatically) recompiled. The process should never require any user intervention.
]

---

.left-column[
## Note
]

.right-column[
If any submodule of a module is imported into any part of a program, the entire top-level module is considered to be part of the program. As a consequence of this, Clang may diagnose conflicts between an entity declared in an unimported submodule and an entity declared in the current translation unit, and Clang may inline or devirtualize based on knowledge from unimported submodules.

import std.io
and your translation unit defines in abs(int) // defined in stdlib.h
will create conflict
]

---

.left-column[
## Example
]

.right-column[
```
module std [system] [extern_c] {
  module assert {
    textual header "assert.h"
    header "bits/assert-decls.h"
    export *
  }

  module complex {
    header "complex.h"
    export *
  }

  module ctype {
    header "ctype.h"
    export *
  }

  module errno {
    header "errno.h"
    header "sys/errno.h"
    export *
  }

  // ...more headers follow...
}
```
]

---

.left-column[
### `export *`
]

.right-column[
The wildcard export syntax export * re-exports all of the modules that were imported in the actual header file. Because #include directives are automatically mapped to module imports, export * provides the same transitive-inclusion behavior provided by the C preprocessor, e.g., importing a given module implicitly imports all of the modules on which it depends. Therefore, liberal use of export * provides excellent backward compatibility for programs that rely on transitive inclusion (i.e., all of them).

the `export *` command specifies that anything included by that submodule will be automatically re-exported.

]

---

.left-column[
## Reference
]

.right-column[
* https://clang.llvm.org/docs/Modules.html
* This presentation is available at https://github.com/ayushgoel/presentations/
]

---

class: center, middle, inverse

# Thank you!

### Share your feedback
#### or open a PR...
