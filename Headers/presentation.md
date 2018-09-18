class: center, middle, inverse

# Header Files
### Ayush Goel

---

.left-column[
## Introduction
]

.right-column[
* A header file is a file containing C declarations and macro definitions
]

--
.right-column[
* You use the preprocessing directive `#include`
]

---

.left-column[
## Purpose
]

.right-column[
## 1.

> System header files

declare the interfaces to parts of the operating system.
Eg - stdio, string, stdlib etc

]

---

.left-column[
## Purpose
]

.right-column[
## 2.

> Your own header files

contain declarations for interfaces between the source files of your program.
Eg - TDTSessionManager, TDTAppDelegate etc
]

---
layout:true

.left-column[
## Syntax
]

.right-column[
### `<file.h>` vs. `"file.h"`
]

---

.right-column[
#### Angled brackets

* Used for system header files
* Searches in a standard list of system directories
]

---

.right-column[
#### Quotes
- This variant is used for header files of your own program.
- It searches:
  - first in the directory containing the current file
  - quote directories
  - same directories used for <file>
]

---
layout: false

.left-column[
## Include operation
]

.right-column[

* C preprocessor scans the file as input
* Output:

```
output already generated
output resulting from the included file
output that comes from the text after the ‘#include’ directive
```

]

---

.left-column[
## Include operation
]

.right-column[

**header.h**

```
char *test (void);
```

**program.c**

```
int x;
#include "header.h"

int main (void) {
  puts (test ());
}
```

**Generated file**

```
int x;
char *test (void);

int main (void) {
  puts (test ());
}
```

]

---

.left-column[
## Include operation
]

.right-column[

> Included files are not limited to declarations and macro definitions; those are merely the typical uses.

.

> Any fragment of a C program can be included from another file.

]

---

.left-column[
## Include operation
]

.right-column[

**header.h**

```
x;
char *test (void);
```

**program.c**

```
int
#include "header.h"

int main (void) {
  puts (test ());
}
```

**Generated file**

```
int x;
char *test (void);

int main (void) {
  puts (test ());
}
```

]

---

## Search Paths

```bash
$ cpp -v /dev/null -o /dev/null
```

```bash
Apple LLVM version 9.0.0 (clang-900.0.39.2)
Target: x86_64-apple-darwin17.6.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
 ...
clang -cc1 version 9.0.0 (clang-900.0.39.2) default target x86_64-apple-darwin17.6.0
ignoring nonexistent directory "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/local/include"
ignoring nonexistent directory "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/Library/Frameworks"



#include "..." search starts here:

#include <...> search starts here:
 /usr/local/include
 /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/9.0.0/include
 /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include
 /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include
 /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/System/Library/Frameworks (framework directory)
End of search list.

```

---

.left-column[
## Search Paths
]

.right-column[
To add additional directories use `-I` command line option.

_dir_ to be searched after the current directory (for the quote form of the directive) and ahead of the standard system directories.

Use `-iquote` and `-isystem` instead of `-I` to get separate control over the search paths.

You can also prevent the preprocessor from searching any of the default system header directories with the `-nostdinc` option.
]

---

.left-column[
## Once-Only Headers
]

.right-column[

If a header is included twice, compiler will process it's contents twice.

]

--

.right-column[

### wrapper #ifndef

```
/* File foo.  */
#ifndef FILE_FOO_SEEN
#define FILE_FOO_SEEN

the entire file

#endif /* !FILE_FOO_SEEN */
```

]

.footnote.small[The macro `FILE_FOO_SEEN` is called the .red[**controlling macro**] or .red[**guard macro**].]

---

.left-column[
## Once-Only Headers
]

.right-column[

Convention:
> In a user header file, the macro name should not begin with '\_' . In a system header file, it should begin with '\_\_' to avoid conflicts with user programs.

]

---

.left-column[
## #import
]

.right-column[
#### Alternative to Wrapper #ifndef

> ‘#import’ which includes a file, but does so at most once.

]

.footnote.small[‘#import’ is standard in Objective-C, but is .red[considered a deprecated extension in C and C++.]

It requires users of headers to know that a header can be included only once instead of the other way round.]

---

.left-column[
## Advantages
]

.right-column[
* Including a header has same effect as copy-pasting the contents on top of file that includes it.
  - If done by hand, it is error prone and laborious
* Single place to edit and fix
]

---

# Reference

.medium[

* GCC docs - https://gcc.gnu.org/onlinedocs/cpp/Header-Files.html#Header-Files
* System frameworks - /System/Library/Frameworks/

---

* This presentation is available at https://github.com/ayushgoel/presentations/
]

---

class: center, middle, inverse

# Thank you!

### Share your feedback
