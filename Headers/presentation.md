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
* You use the preprocessing directive `#include` to use
]

--
.right-column[
]

---

.left-column[
## Purpose
]

.right-column[
## 1.

System header files declare the interfaces to parts of the operating system.
Eg - stdio, string, stdlib etc

Check

```
/Applications/Xcode.app/Contents/Developer/Platforms/
MacOSX.platform/Developer/SDKs/
MacOSX10.13.sdk/usr/include/
```
]

---

.left-column[
## Purpose
]

.right-column[
## 2.

Your own header files contain declarations for interfaces between the source files of your program.
Eg - TDTSessionManager, TDTAppDelegate etc

Check

```
Where ever you have put your Flock project
```
]

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

.left-column[
## Syntax
]

.right-column[
### `<file.h>` vs. `"file.h"`
]
--

.right-column[
* `#include <file.h>`
  - This variant is used for system header files
  - It searches for a file named file in a standard list of system directories
* `#include "file.h"`
  - This variant is used for header files of your own program.
  - It searches for a file named file first in the directory containing the current file, then in the quote directories and then the same directories used for <file>
]

---

.left-column[
## Include operation
]

.right-column[

> Works by directing the C preprocessor to
> * scan the specified file as input
> * before continuing with the rest of the current file.
>
> The output from the preprocessor contains
> * the output already generated, followed by
> * the output resulting from the included file, followed by
> * the output that comes from the text after the ‘#include’ directive.

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

.left-column[
## Reference
]

.right-column[
* GCC docs - https://gcc.gnu.org/onlinedocs/cpp/Header-Files.html#Header-Files
* System frameworks - /System/Library/Frameworks/
]
