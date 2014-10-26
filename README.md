R7RS SRFI implementations
=========================

<http://srfi.schemers.org/>

Overview
--------

Our intention is to bridge gaps between credible Scheme platforms, as
well as explore what is possible to implement *sanely* in R7RS.
Unlike a lot of legacy "portable" Scheme code, this is not a freak
show.  Therefore:

- Feel free to assume sane platform properties like a full numeric
  tower (excluding exact complex numbers), Unicode, etc. and keep
  `cond-expand` usage to a minimum.  (Moving to an R7RS-large base
  will make this point moot.)

- Feel free to use other SRFIs in your SRFI implementation, even if
  they're not in this repository, if the alternative is using horrid
  hacks.

- Write test suites in SRFI-64: <http://srfi.schemers.org/srfi-64/>

- For those SRFIs which cannot be implemented in pure R7RS, it's fine
  to write libraries that just wrap features of specific platforms via
  `cond-expand` and thus at least work across several platforms even
  if not all R7RS implementations.  However, don't try to implement
  functionality via library code when it's clearly intended to be
  implemented at the platform level.

- The preferred license is the LGPL version 3.  Refrain from GPL and
  the like; we'd like it if Scheme platforms shipped straight with
  these implementations or platform-tuned versions of them, and
  forcing whole Scheme programs to be GPL'ed just for using these SRFI
  implementations would also be overboard.

Concrete conventions
--------------------

- No withdrawn SRFIs.

- All implementations should be valid R7RS-small libraries for now.
  We will move to an R7RS-large core/base when possible.

- Libraries go into a file named `n.scm` where `n` is the SRFI number.
  The library is correspondingly named `(srfi n)`.

- The order of things in a library declaration is:

  - exports
  - imports
  - optional auxiliary code in a `begin`
  - the main body as an `include` or `begin`

- If an export or import list doesn't fit in one line, then put a
  newline directly after the `export` or `import` keyword, i.e., don't
  put any export or import specs on the same line as the keyword.

- Unless there is only a very small amount of code, split the main
  body of the library into a file named `n.body.scm` and include that
  from `n.scm`.

- When using a reference implementation, put the original source code
  in a file `n.upstream.scm`, and copy it to `n.body.scm` if you will
  make modifications.  This is because some reference implementations
  change ad-hoc without version control; we want to know what version
  we forked.

Using reference implementations
-------------------------------

- You can probably often just wrap a reference implementation in an
  R7RS library, but do modify them to make good use of R7RS features,
  to avoid dirty hacky things like redefining type predicates (it's
  mostly illegal anyway now), liberal use of global variables (use
  parameters instead), etc.

- Be careful about the copyright and licensing.  When putting source
  code in an `n.upstream.scm` file, add suitable legal boilerplate
  even if the original code didn't have any (usually the SRFI HTML
  page will have a copyright).  The same boilerplate goes into
  `n.body.scm` of course.

SRFI-specific notes
===================

SRFI-64
-------

- `test-read-eval-string`: This now takes an optional `env` argument
  to specify in what environment to evaluate.  Passing `#f` will
  explicitly attempt to call `eval` with a single argument, which is
  an error in R7RS.  Leaving the argument out will try to use a sane
  platform-specific default but falls back to `#f`.

Progress
========

All SRFI are listed here, and marked with one of: nothing, meaning it
has yet to be looked into; "withdrawn," meaning it's a withdrawn SRFI;
"platform," meaning it must or ought to be implemented at the platform
level; "UNTESTED," meaning it lacks a test-suite; "DRAFT," meaning
it's still in draft status; and "check," meaning it's implemented and
passes its test-suite.

(UNTESTED and DRAFT are capitalized to emphasize that we're not done
with them yet.)

- SRFI-0: platform
- SRFI-1: UNTESTED
- SRFI-2:
- SRFI-3: withdrawn
- SRFI-4: platform
- SRFI-5:
- SRFI-6:
- SRFI-7:
- SRFI-8: UNTESTED
- SRFI-9:
- SRFI-10:
- SRFI-11:
- SRFI-12: withdrawn
- SRFI-13:
- SRFI-14:
- SRFI-15: withdrawn
- SRFI-16:
- SRFI-17:
- SRFI-18:
- SRFI-19:
- SRFI-20: withdrawn
- SRFI-21:
- SRFI-22:
- SRFI-23:
- SRFI-24: withdrawn
- SRFI-25:
- SRFI-26:
- SRFI-27:
- SRFI-28:
- SRFI-29:
- SRFI-30:
- SRFI-31:
- SRFI-32: withdrawn
- SRFI-33: withdrawn
- SRFI-34:
- SRFI-35: UNTESTED
- SRFI-36:
- SRFI-37:
- SRFI-38:
- SRFI-39:
- SRFI-40:
- SRFI-41:
- SRFI-42:
- SRFI-43:
- SRFI-44:
- SRFI-45:
- SRFI-46:
- SRFI-47:
- SRFI-48:
- SRFI-49:
- SRFI-50: withdrawn
- SRFI-51:
- SRFI-52: withdrawn
- SRFI-53: withdrawn
- SRFI-54:
- SRFI-55:
- SRFI-56: withdrawn
- SRFI-57:
- SRFI-58:
- SRFI-59:
- SRFI-60:
- SRFI-61:
- SRFI-62:
- SRFI-63:
- SRFI-64: UNTESTED
- SRFI-65: withdrawn
- SRFI-66:
- SRFI-67:
- SRFI-68: withdrawn
- SRFI-69:
- SRFI-70:
- SRFI-71:
- SRFI-72:
- SRFI-73: withdrawn
- SRFI-74:
- SRFI-75: withdrawn
- SRFI-76: withdrawn
- SRFI-77: withdrawn
- SRFI-78:
- SRFI-79: withdrawn
- SRFI-80: withdrawn
- SRFI-81: withdrawn
- SRFI-82: withdrawn
- SRFI-83: withdrawn
- SRFI-84: withdrawn
- SRFI-85: withdrawn
- SRFI-86:
- SRFI-87:
- SRFI-88:
- SRFI-89:
- SRFI-90:
- SRFI-91: withdrawn
- SRFI-92: withdrawn
- SRFI-93: withdrawn
- SRFI-94:
- SRFI-95:
- SRFI-96:
- SRFI-97:
- SRFI-98:
- SRFI-99:
- SRFI-100:
- SRFI-101:
- SRFI-102: withdrawn
- SRFI-103: withdrawn
- SRFI-104: withdrawn
- SRFI-105:
- SRFI-106:
- SRFI-107:
- SRFI-108:
- SRFI-109:
- SRFI-110:
- SRFI-111:
- SRFI-112: DRAFT
- SRFI-113: DRAFT
- SRFI-114:
- SRFI-115:
