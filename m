Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D138C79FA1
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 15:47:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38398.1788796018262134850
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 08:46:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=AtXkj+4D;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16DB41477
	for <bitbake-devel@lists.openembedded.org>; Mon,  7 Sep 2026 08:46:54 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52ED63F86C
	for <bitbake-devel@lists.openembedded.org>; Mon,  7 Sep 2026 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788796017; bh=SKsUR4+ERnwChRDvvwcOrKyKXLuSzxaslprnaWDqnjA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AtXkj+4DjtBV7/5+U0ZycF1LtVzxOlDBKxMUngAPH+2+KEXrk7sfqjvqgBHwh7VgJ
	 R6bogcXw7lbY8eQf9M3hykszRWqpZtX15Jpi9fQ6TgppO6bRUQh8QvJIPzYzVc9rop
	 n3dh3bBckaypjSqQ35+maOyZOnQav4tyx3kHV68A=
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] lib/bb/_vendor: resync to add tomli
Date: Mon,  7 Sep 2026 16:46:54 +0100
Message-ID: <20260907154654.32166-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907154654.32166-1-ross.burton@arm.com>
References: <20260907154654.32166-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 15:47:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20167

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 lib/bb/_vendor/tomli/LICENSE     |  21 +
 lib/bb/_vendor/tomli/__init__.py |   8 +
 lib/bb/_vendor/tomli/_parser.py  | 793 +++++++++++++++++++++++++++++++
 lib/bb/_vendor/tomli/_re.py      | 119 +++++
 lib/bb/_vendor/tomli/_types.py   |  10 +
 lib/bb/_vendor/tomli/py.typed    |   1 +
 6 files changed, 952 insertions(+)
 create mode 100644 lib/bb/_vendor/tomli/LICENSE
 create mode 100644 lib/bb/_vendor/tomli/__init__.py
 create mode 100644 lib/bb/_vendor/tomli/_parser.py
 create mode 100644 lib/bb/_vendor/tomli/_re.py
 create mode 100644 lib/bb/_vendor/tomli/_types.py
 create mode 100644 lib/bb/_vendor/tomli/py.typed

diff --git a/lib/bb/_vendor/tomli/LICENSE b/lib/bb/_vendor/tomli/LICENSE
new file mode 100644
index 0000000000..e859590f88
--- /dev/null
+++ b/lib/bb/_vendor/tomli/LICENSE
@@ -0,0 +1,21 @@
+MIT License
+
+Copyright (c) 2021 Taneli Hukkinen
+
+Permission is hereby granted, free of charge, to any person obtaining a =
copy
+of this software and associated documentation files (the "Software"), to=
 deal
+in the Software without restriction, including without limitation the ri=
ghts
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sel=
l
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included =
in all
+copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL =
THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING =
FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS I=
N THE
+SOFTWARE.
diff --git a/lib/bb/_vendor/tomli/__init__.py b/lib/bb/_vendor/tomli/__in=
it__.py
new file mode 100644
index 0000000000..ebe9001309
--- /dev/null
+++ b/lib/bb/_vendor/tomli/__init__.py
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: MIT
+# SPDX-FileCopyrightText: 2021 Taneli Hukkinen
+# Licensed to PSF under a Contributor Agreement.
+
+__all__ =3D ("loads", "load", "TOMLDecodeError")
+__version__ =3D "2.4.1"  # DO NOT EDIT THIS LINE MANUALLY. LET bump2vers=
ion UTILITY DO IT
+
+from ._parser import TOMLDecodeError, load, loads
diff --git a/lib/bb/_vendor/tomli/_parser.py b/lib/bb/_vendor/tomli/_pars=
er.py
new file mode 100644
index 0000000000..41b0641880
--- /dev/null
+++ b/lib/bb/_vendor/tomli/_parser.py
@@ -0,0 +1,793 @@
+# SPDX-License-Identifier: MIT
+# SPDX-FileCopyrightText: 2021 Taneli Hukkinen
+# Licensed to PSF under a Contributor Agreement.
+
+from __future__ import annotations
+
+import sys
+from types import MappingProxyType
+
+from ._re import (
+    RE_DATETIME,
+    RE_LOCALTIME,
+    RE_NUMBER,
+    match_to_datetime,
+    match_to_localtime,
+    match_to_number,
+)
+
+TYPE_CHECKING =3D False
+if TYPE_CHECKING:
+    from collections.abc import Iterable
+    from typing import IO, Any, Final
+
+    from ._types import Key, ParseFloat, Pos
+
+# Inline tables/arrays are implemented using recursion. Pathologically
+# nested documents cause pure Python to raise RecursionError (which is O=
K),
+# but mypyc binary wheels will crash unrecoverably (not OK). According t=
o
+# mypyc docs this will be fixed in the future:
+# https://mypyc.readthedocs.io/en/latest/differences_from_python.html#st=
ack-overflows
+# Before mypyc's fix is in, recursion needs to be limited by this librar=
y.
+# Choosing `sys.getrecursionlimit()` as maximum inline table/array nesti=
ng
+# level, as it allows more nesting than pure Python, but still seems a f=
ar
+# lower number than where mypyc binaries crash.
+MAX_INLINE_NESTING: Final =3D sys.getrecursionlimit()
+
+# Pathologically excessive number of parts in a key runs into quadratic
+# behavior (e.g. in Flags.is_).
+# Even if keys aren't currently parsed using recursion, they name a
+# recursive structure, so it makes sense to limit it using getrecursionl=
imit()
+# and RecursionError.
+MAX_KEY_PARTS: Final =3D sys.getrecursionlimit()
+
+ASCII_CTRL: Final =3D frozenset(chr(i) for i in range(32)) | frozenset(c=
hr(127))
+
+# Neither of these sets include quotation mark or backslash. They are
+# currently handled as separate cases in the parser functions.
+ILLEGAL_BASIC_STR_CHARS: Final =3D ASCII_CTRL - frozenset("\t")
+ILLEGAL_MULTILINE_BASIC_STR_CHARS: Final =3D ASCII_CTRL - frozenset("\t\=
n")
+
+ILLEGAL_LITERAL_STR_CHARS: Final =3D ILLEGAL_BASIC_STR_CHARS
+ILLEGAL_MULTILINE_LITERAL_STR_CHARS: Final =3D ILLEGAL_MULTILINE_BASIC_S=
TR_CHARS
+
+ILLEGAL_COMMENT_CHARS: Final =3D ILLEGAL_BASIC_STR_CHARS
+
+TOML_WS: Final =3D frozenset(" \t")
+TOML_WS_AND_NEWLINE: Final =3D TOML_WS | frozenset("\n")
+BARE_KEY_CHARS: Final =3D frozenset(
+    "abcdefghijklmnopqrstuvwxyz" "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "012345678=
9" "-_"
+)
+KEY_INITIAL_CHARS: Final =3D BARE_KEY_CHARS | frozenset("\"'")
+HEXDIGIT_CHARS: Final =3D frozenset("abcdef" "ABCDEF" "0123456789")
+
+BASIC_STR_ESCAPE_REPLACEMENTS: Final =3D MappingProxyType(
+    {
+        "\\b": "\u0008",  # backspace
+        "\\t": "\u0009",  # tab
+        "\\n": "\u000a",  # linefeed
+        "\\f": "\u000c",  # form feed
+        "\\r": "\u000d",  # carriage return
+        "\\e": "\u001b",  # escape
+        '\\"': "\u0022",  # quote
+        "\\\\": "\u005c",  # backslash
+    }
+)
+
+
+class DEPRECATED_DEFAULT:
+    """Sentinel to be used as default arg during deprecation
+    period of TOMLDecodeError's free-form arguments."""
+
+
+class TOMLDecodeError(ValueError):
+    """An error raised if a document is not valid TOML.
+
+    Adds the following attributes to ValueError:
+    msg: The unformatted error message
+    doc: The TOML document being parsed
+    pos: The index of doc where parsing failed
+    lineno: The line corresponding to pos
+    colno: The column corresponding to pos
+    """
+
+    def __init__(
+        self,
+        msg: str | type[DEPRECATED_DEFAULT] =3D DEPRECATED_DEFAULT,
+        doc: str | type[DEPRECATED_DEFAULT] =3D DEPRECATED_DEFAULT,
+        pos: Pos | type[DEPRECATED_DEFAULT] =3D DEPRECATED_DEFAULT,
+        *args: Any,
+    ):
+        if (
+            args
+            or not isinstance(msg, str)
+            or not isinstance(doc, str)
+            or not isinstance(pos, int)
+        ):
+            import warnings
+
+            warnings.warn(
+                "Free-form arguments for TOMLDecodeError are deprecated.=
 "
+                "Please set 'msg' (str), 'doc' (str) and 'pos' (int) arg=
uments only.",
+                DeprecationWarning,
+                stacklevel=3D2,
+            )
+            if pos is not DEPRECATED_DEFAULT:
+                args =3D pos, *args
+            if doc is not DEPRECATED_DEFAULT:
+                args =3D doc, *args
+            if msg is not DEPRECATED_DEFAULT:
+                args =3D msg, *args
+            ValueError.__init__(self, *args)
+            return
+
+        lineno =3D doc.count("\n", 0, pos) + 1
+        if lineno =3D=3D 1:
+            colno =3D pos + 1
+        else:
+            colno =3D pos - doc.rindex("\n", 0, pos)
+
+        if pos >=3D len(doc):
+            coord_repr =3D "end of document"
+        else:
+            coord_repr =3D f"line {lineno}, column {colno}"
+        errmsg =3D f"{msg} (at {coord_repr})"
+        ValueError.__init__(self, errmsg)
+
+        self.msg =3D msg
+        self.doc =3D doc
+        self.pos =3D pos
+        self.lineno =3D lineno
+        self.colno =3D colno
+
+
+def load(__fp: IO[bytes], *, parse_float: ParseFloat =3D float) -> dict[=
str, Any]:
+    """Parse TOML from a binary file object."""
+    b =3D __fp.read()
+    try:
+        s =3D b.decode()
+    except AttributeError:
+        raise TypeError(
+            "File must be opened in binary mode, e.g. use `open('foo.tom=
l', 'rb')`"
+        ) from None
+    return loads(s, parse_float=3Dparse_float)
+
+
+def loads(__s: str, *, parse_float: ParseFloat =3D float) -> dict[str, A=
ny]:
+    """Parse TOML from a string."""
+
+    # The spec allows converting "\r\n" to "\n", even in string
+    # literals. Let's do so to simplify parsing.
+    try:
+        src =3D __s.replace("\r\n", "\n")
+    except (AttributeError, TypeError):
+        raise TypeError(
+            f"Expected str object, not '{type(__s).__qualname__}'"
+        ) from None
+    pos =3D 0
+    out =3D Output()
+    header: Key =3D ()
+    parse_float =3D make_safe_parse_float(parse_float)
+
+    # Parse one statement at a time
+    # (typically means one line in TOML source)
+    while True:
+        # 1. Skip line leading whitespace
+        pos =3D skip_chars(src, pos, TOML_WS)
+
+        # 2. Parse rules. Expect one of the following:
+        #    - end of file
+        #    - end of line
+        #    - comment
+        #    - key/value pair
+        #    - append dict to list (and move to its namespace)
+        #    - create dict (and move to its namespace)
+        # Skip trailing whitespace when applicable.
+        try:
+            char =3D src[pos]
+        except IndexError:
+            break
+        if char =3D=3D "\n":
+            pos +=3D 1
+            continue
+        if char in KEY_INITIAL_CHARS:
+            pos =3D key_value_rule(src, pos, out, header, parse_float)
+            pos =3D skip_chars(src, pos, TOML_WS)
+        elif char =3D=3D "[":
+            try:
+                second_char: str | None =3D src[pos + 1]
+            except IndexError:
+                second_char =3D None
+            out.flags.finalize_pending()
+            if second_char =3D=3D "[":
+                pos, header =3D create_list_rule(src, pos, out)
+            else:
+                pos, header =3D create_dict_rule(src, pos, out)
+            pos =3D skip_chars(src, pos, TOML_WS)
+        elif char !=3D "#":
+            raise TOMLDecodeError("Invalid statement", src, pos)
+
+        # 3. Skip comment
+        pos =3D skip_comment(src, pos)
+
+        # 4. Expect end of line or end of file
+        try:
+            char =3D src[pos]
+        except IndexError:
+            break
+        if char !=3D "\n":
+            raise TOMLDecodeError(
+                "Expected newline or end of document after a statement",=
 src, pos
+            )
+        pos +=3D 1
+
+    return out.data.dict
+
+
+class Flags:
+    """Flags that map to parsed keys/namespaces."""
+
+    # Marks an immutable namespace (inline array or inline table).
+    FROZEN: Final =3D 0
+    # Marks a nest that has been explicitly created and can no longer
+    # be opened using the "[table]" syntax.
+    EXPLICIT_NEST: Final =3D 1
+
+    def __init__(self) -> None:
+        self._flags: dict[str, dict[Any, Any]] =3D {}
+        self._pending_flags: set[tuple[Key, int]] =3D set()
+
+    def add_pending(self, key: Key, flag: int) -> None:
+        self._pending_flags.add((key, flag))
+
+    def finalize_pending(self) -> None:
+        for key, flag in self._pending_flags:
+            self.set(key, flag, recursive=3DFalse)
+        self._pending_flags.clear()
+
+    def unset_all(self, key: Key) -> None:
+        cont =3D self._flags
+        for k in key[:-1]:
+            if k not in cont:
+                return
+            cont =3D cont[k]["nested"]
+        cont.pop(key[-1], None)
+
+    def set(self, key: Key, flag: int, *, recursive: bool) -> None:  # n=
oqa: A003
+        cont =3D self._flags
+        key_parent, key_stem =3D key[:-1], key[-1]
+        for k in key_parent:
+            if k not in cont:
+                cont[k] =3D {"flags": set(), "recursive_flags": set(), "=
nested": {}}
+            cont =3D cont[k]["nested"]
+        if key_stem not in cont:
+            cont[key_stem] =3D {"flags": set(), "recursive_flags": set()=
, "nested": {}}
+        cont[key_stem]["recursive_flags" if recursive else "flags"].add(=
flag)
+
+    def is_(self, key: Key, flag: int) -> bool:
+        if not key:
+            return False  # document root has no flags
+        cont =3D self._flags
+        for k in key[:-1]:
+            if k not in cont:
+                return False
+            inner_cont =3D cont[k]
+            if flag in inner_cont["recursive_flags"]:
+                return True
+            cont =3D inner_cont["nested"]
+        key_stem =3D key[-1]
+        if key_stem in cont:
+            inner_cont =3D cont[key_stem]
+            return flag in inner_cont["flags"] or flag in inner_cont["re=
cursive_flags"]
+        return False
+
+
+class NestedDict:
+    def __init__(self) -> None:
+        # The parsed content of the TOML document
+        self.dict: dict[str, Any] =3D {}
+
+    def get_or_create_nest(
+        self,
+        key: Key,
+        *,
+        access_lists: bool =3D True,
+    ) -> dict[str, Any]:
+        cont: Any =3D self.dict
+        for k in key:
+            if k not in cont:
+                cont[k] =3D {}
+            cont =3D cont[k]
+            if access_lists and isinstance(cont, list):
+                cont =3D cont[-1]
+            if not isinstance(cont, dict):
+                raise KeyError("There is no nest behind this key")
+        return cont  # type: ignore[no-any-return]
+
+    def append_nest_to_list(self, key: Key) -> None:
+        cont =3D self.get_or_create_nest(key[:-1])
+        last_key =3D key[-1]
+        if last_key in cont:
+            list_ =3D cont[last_key]
+            if not isinstance(list_, list):
+                raise KeyError("An object other than list found behind t=
his key")
+            list_.append({})
+        else:
+            cont[last_key] =3D [{}]
+
+
+class Output:
+    def __init__(self) -> None:
+        self.data =3D NestedDict()
+        self.flags =3D Flags()
+
+
+def skip_chars(src: str, pos: Pos, chars: Iterable[str]) -> Pos:
+    try:
+        while src[pos] in chars:
+            pos +=3D 1
+    except IndexError:
+        pass
+    return pos
+
+
+def skip_until(
+    src: str,
+    pos: Pos,
+    expect: str,
+    *,
+    error_on: frozenset[str],
+    error_on_eof: bool,
+) -> Pos:
+    try:
+        new_pos =3D src.index(expect, pos)
+    except ValueError:
+        new_pos =3D len(src)
+        if error_on_eof:
+            raise TOMLDecodeError(f"Expected {expect!r}", src, new_pos) =
from None
+
+    if not error_on.isdisjoint(src[pos:new_pos]):
+        while src[pos] not in error_on:
+            pos +=3D 1
+        raise TOMLDecodeError(f"Found invalid character {src[pos]!r}", s=
rc, pos)
+    return new_pos
+
+
+def skip_comment(src: str, pos: Pos) -> Pos:
+    try:
+        char: str | None =3D src[pos]
+    except IndexError:
+        char =3D None
+    if char =3D=3D "#":
+        return skip_until(
+            src, pos + 1, "\n", error_on=3DILLEGAL_COMMENT_CHARS, error_=
on_eof=3DFalse
+        )
+    return pos
+
+
+def skip_comments_and_array_ws(src: str, pos: Pos) -> Pos:
+    while True:
+        pos_before_skip =3D pos
+        pos =3D skip_chars(src, pos, TOML_WS_AND_NEWLINE)
+        pos =3D skip_comment(src, pos)
+        if pos =3D=3D pos_before_skip:
+            return pos
+
+
+def create_dict_rule(src: str, pos: Pos, out: Output) -> tuple[Pos, Key]=
:
+    pos +=3D 1  # Skip "["
+    pos =3D skip_chars(src, pos, TOML_WS)
+    pos, key =3D parse_key(src, pos)
+
+    if out.flags.is_(key, Flags.EXPLICIT_NEST) or out.flags.is_(key, Fla=
gs.FROZEN):
+        raise TOMLDecodeError(f"Cannot declare {key} twice", src, pos)
+    out.flags.set(key, Flags.EXPLICIT_NEST, recursive=3DFalse)
+    try:
+        out.data.get_or_create_nest(key)
+    except KeyError:
+        raise TOMLDecodeError("Cannot overwrite a value", src, pos) from=
 None
+
+    if not src.startswith("]", pos):
+        raise TOMLDecodeError(
+            "Expected ']' at the end of a table declaration", src, pos
+        )
+    return pos + 1, key
+
+
+def create_list_rule(src: str, pos: Pos, out: Output) -> tuple[Pos, Key]=
:
+    pos +=3D 2  # Skip "[["
+    pos =3D skip_chars(src, pos, TOML_WS)
+    pos, key =3D parse_key(src, pos)
+
+    if out.flags.is_(key, Flags.FROZEN):
+        raise TOMLDecodeError(f"Cannot mutate immutable namespace {key}"=
, src, pos)
+    # Free the namespace now that it points to another empty list item..=
.
+    out.flags.unset_all(key)
+    # ...but this key precisely is still prohibited from table declarati=
on
+    out.flags.set(key, Flags.EXPLICIT_NEST, recursive=3DFalse)
+    try:
+        out.data.append_nest_to_list(key)
+    except KeyError:
+        raise TOMLDecodeError("Cannot overwrite a value", src, pos) from=
 None
+
+    if not src.startswith("]]", pos):
+        raise TOMLDecodeError(
+            "Expected ']]' at the end of an array declaration", src, pos
+        )
+    return pos + 2, key
+
+
+def key_value_rule(
+    src: str, pos: Pos, out: Output, header: Key, parse_float: ParseFloa=
t
+) -> Pos:
+    pos, key, value =3D parse_key_value_pair(src, pos, parse_float, nest=
_lvl=3D0)
+    key_parent, key_stem =3D key[:-1], key[-1]
+    abs_key_parent =3D header + key_parent
+
+    relative_path_cont_keys =3D (header + key[:i] for i in range(1, len(=
key)))
+    for cont_key in relative_path_cont_keys:
+        # Check that dotted key syntax does not redefine an existing tab=
le
+        if out.flags.is_(cont_key, Flags.EXPLICIT_NEST):
+            raise TOMLDecodeError(f"Cannot redefine namespace {cont_key}=
", src, pos)
+        # Containers in the relative path can't be opened with the table=
 syntax or
+        # dotted key/value syntax in following table sections.
+        out.flags.add_pending(cont_key, Flags.EXPLICIT_NEST)
+
+    if out.flags.is_(abs_key_parent, Flags.FROZEN):
+        raise TOMLDecodeError(
+            f"Cannot mutate immutable namespace {abs_key_parent}", src, =
pos
+        )
+
+    try:
+        nest =3D out.data.get_or_create_nest(abs_key_parent)
+    except KeyError:
+        raise TOMLDecodeError("Cannot overwrite a value", src, pos) from=
 None
+    if key_stem in nest:
+        raise TOMLDecodeError("Cannot overwrite a value", src, pos)
+    # Mark inline table and array namespaces recursively immutable
+    if isinstance(value, (dict, list)):
+        out.flags.set(header + key, Flags.FROZEN, recursive=3DTrue)
+    nest[key_stem] =3D value
+    return pos
+
+
+def parse_key_value_pair(
+    src: str, pos: Pos, parse_float: ParseFloat, nest_lvl: int
+) -> tuple[Pos, Key, Any]:
+    pos, key =3D parse_key(src, pos)
+    try:
+        char: str | None =3D src[pos]
+    except IndexError:
+        char =3D None
+    if char !=3D "=3D":
+        raise TOMLDecodeError("Expected '=3D' after a key in a key/value=
 pair", src, pos)
+    pos +=3D 1
+    pos =3D skip_chars(src, pos, TOML_WS)
+    pos, value =3D parse_value(src, pos, parse_float, nest_lvl)
+    return pos, key, value
+
+
+def parse_key(src: str, pos: Pos) -> tuple[Pos, Key]:
+    pos, key_part =3D parse_key_part(src, pos)
+    key: Key =3D (key_part,)
+    pos =3D skip_chars(src, pos, TOML_WS)
+    while True:
+        try:
+            char: str | None =3D src[pos]
+        except IndexError:
+            char =3D None
+        if char !=3D ".":
+            return pos, key
+        pos +=3D 1
+        pos =3D skip_chars(src, pos, TOML_WS)
+        pos, key_part =3D parse_key_part(src, pos)
+        key +=3D (key_part,)
+        if len(key) > MAX_KEY_PARTS:
+            raise RecursionError(
+                f"TOML key has more than the allowed {MAX_KEY_PARTS} par=
ts"
+            )
+        pos =3D skip_chars(src, pos, TOML_WS)
+
+
+def parse_key_part(src: str, pos: Pos) -> tuple[Pos, str]:
+    try:
+        char: str | None =3D src[pos]
+    except IndexError:
+        char =3D None
+    if char in BARE_KEY_CHARS:
+        start_pos =3D pos
+        pos =3D skip_chars(src, pos, BARE_KEY_CHARS)
+        return pos, src[start_pos:pos]
+    if char =3D=3D "'":
+        return parse_literal_str(src, pos)
+    if char =3D=3D '"':
+        return parse_one_line_basic_str(src, pos)
+    raise TOMLDecodeError("Invalid initial character for a key part", sr=
c, pos)
+
+
+def parse_one_line_basic_str(src: str, pos: Pos) -> tuple[Pos, str]:
+    pos +=3D 1
+    return parse_basic_str(src, pos, multiline=3DFalse)
+
+
+def parse_array(
+    src: str, pos: Pos, parse_float: ParseFloat, nest_lvl: int
+) -> tuple[Pos, list[Any]]:
+    pos +=3D 1
+    array: list[Any] =3D []
+
+    pos =3D skip_comments_and_array_ws(src, pos)
+    if src.startswith("]", pos):
+        return pos + 1, array
+    while True:
+        pos, val =3D parse_value(src, pos, parse_float, nest_lvl)
+        array.append(val)
+        pos =3D skip_comments_and_array_ws(src, pos)
+
+        c =3D src[pos : pos + 1]
+        if c =3D=3D "]":
+            return pos + 1, array
+        if c !=3D ",":
+            raise TOMLDecodeError("Unclosed array", src, pos)
+        pos +=3D 1
+
+        pos =3D skip_comments_and_array_ws(src, pos)
+        if src.startswith("]", pos):
+            return pos + 1, array
+
+
+def parse_inline_table(
+    src: str, pos: Pos, parse_float: ParseFloat, nest_lvl: int
+) -> tuple[Pos, dict[str, Any]]:
+    pos +=3D 1
+    nested_dict =3D NestedDict()
+    flags =3D Flags()
+
+    pos =3D skip_comments_and_array_ws(src, pos)
+    if src.startswith("}", pos):
+        return pos + 1, nested_dict.dict
+    while True:
+        pos, key, value =3D parse_key_value_pair(src, pos, parse_float, =
nest_lvl)
+        key_parent, key_stem =3D key[:-1], key[-1]
+        if flags.is_(key, Flags.FROZEN):
+            raise TOMLDecodeError(f"Cannot mutate immutable namespace {k=
ey}", src, pos)
+        try:
+            nest =3D nested_dict.get_or_create_nest(key_parent, access_l=
ists=3DFalse)
+        except KeyError:
+            raise TOMLDecodeError("Cannot overwrite a value", src, pos) =
from None
+        if key_stem in nest:
+            raise TOMLDecodeError(f"Duplicate inline table key {key_stem=
!r}", src, pos)
+        nest[key_stem] =3D value
+        pos =3D skip_comments_and_array_ws(src, pos)
+        c =3D src[pos : pos + 1]
+        if c =3D=3D "}":
+            return pos + 1, nested_dict.dict
+        if c !=3D ",":
+            raise TOMLDecodeError("Unclosed inline table", src, pos)
+        pos +=3D 1
+        pos =3D skip_comments_and_array_ws(src, pos)
+        if src.startswith("}", pos):
+            return pos + 1, nested_dict.dict
+        if isinstance(value, (dict, list)):
+            flags.set(key, Flags.FROZEN, recursive=3DTrue)
+
+
+def parse_basic_str_escape(
+    src: str, pos: Pos, *, multiline: bool =3D False
+) -> tuple[Pos, str]:
+    escape_id =3D src[pos : pos + 2]
+    pos +=3D 2
+    if multiline and escape_id in {"\\ ", "\\\t", "\\\n"}:
+        # Skip whitespace until next non-whitespace character or end of
+        # the doc. Error if non-whitespace is found before newline.
+        if escape_id !=3D "\\\n":
+            pos =3D skip_chars(src, pos, TOML_WS)
+            try:
+                char =3D src[pos]
+            except IndexError:
+                return pos, ""
+            if char !=3D "\n":
+                raise TOMLDecodeError("Unescaped '\\' in a string", src,=
 pos)
+            pos +=3D 1
+        pos =3D skip_chars(src, pos, TOML_WS_AND_NEWLINE)
+        return pos, ""
+    if escape_id =3D=3D "\\x":
+        return parse_hex_char(src, pos, 2)
+    if escape_id =3D=3D "\\u":
+        return parse_hex_char(src, pos, 4)
+    if escape_id =3D=3D "\\U":
+        return parse_hex_char(src, pos, 8)
+    try:
+        return pos, BASIC_STR_ESCAPE_REPLACEMENTS[escape_id]
+    except KeyError:
+        raise TOMLDecodeError("Unescaped '\\' in a string", src, pos) fr=
om None
+
+
+def parse_basic_str_escape_multiline(src: str, pos: Pos) -> tuple[Pos, s=
tr]:
+    return parse_basic_str_escape(src, pos, multiline=3DTrue)
+
+
+def parse_hex_char(src: str, pos: Pos, hex_len: int) -> tuple[Pos, str]:
+    hex_str =3D src[pos : pos + hex_len]
+    if len(hex_str) !=3D hex_len or not HEXDIGIT_CHARS.issuperset(hex_st=
r):
+        raise TOMLDecodeError("Invalid hex value", src, pos)
+    pos +=3D hex_len
+    hex_int =3D int(hex_str, 16)
+    if not is_unicode_scalar_value(hex_int):
+        raise TOMLDecodeError(
+            "Escaped character is not a Unicode scalar value", src, pos
+        )
+    return pos, chr(hex_int)
+
+
+def parse_literal_str(src: str, pos: Pos) -> tuple[Pos, str]:
+    pos +=3D 1  # Skip starting apostrophe
+    start_pos =3D pos
+    pos =3D skip_until(
+        src, pos, "'", error_on=3DILLEGAL_LITERAL_STR_CHARS, error_on_eo=
f=3DTrue
+    )
+    return pos + 1, src[start_pos:pos]  # Skip ending apostrophe
+
+
+def parse_multiline_str(src: str, pos: Pos, *, literal: bool) -> tuple[P=
os, str]:
+    pos +=3D 3
+    if src.startswith("\n", pos):
+        pos +=3D 1
+
+    if literal:
+        delim =3D "'"
+        end_pos =3D skip_until(
+            src,
+            pos,
+            "'''",
+            error_on=3DILLEGAL_MULTILINE_LITERAL_STR_CHARS,
+            error_on_eof=3DTrue,
+        )
+        result =3D src[pos:end_pos]
+        pos =3D end_pos + 3
+    else:
+        delim =3D '"'
+        pos, result =3D parse_basic_str(src, pos, multiline=3DTrue)
+
+    # Add at maximum two extra apostrophes/quotes if the end sequence
+    # is 4 or 5 chars long instead of just 3.
+    if not src.startswith(delim, pos):
+        return pos, result
+    pos +=3D 1
+    if not src.startswith(delim, pos):
+        return pos, result + delim
+    pos +=3D 1
+    return pos, result + (delim * 2)
+
+
+def parse_basic_str(src: str, pos: Pos, *, multiline: bool) -> tuple[Pos=
, str]:
+    if multiline:
+        error_on =3D ILLEGAL_MULTILINE_BASIC_STR_CHARS
+        parse_escapes =3D parse_basic_str_escape_multiline
+    else:
+        error_on =3D ILLEGAL_BASIC_STR_CHARS
+        parse_escapes =3D parse_basic_str_escape
+    result =3D ""
+    start_pos =3D pos
+    while True:
+        try:
+            char =3D src[pos]
+        except IndexError:
+            raise TOMLDecodeError("Unterminated string", src, pos) from =
None
+        if char =3D=3D '"':
+            if not multiline:
+                return pos + 1, result + src[start_pos:pos]
+            if src.startswith('"""', pos):
+                return pos + 3, result + src[start_pos:pos]
+            pos +=3D 1
+            continue
+        if char =3D=3D "\\":
+            result +=3D src[start_pos:pos]
+            pos, parsed_escape =3D parse_escapes(src, pos)
+            result +=3D parsed_escape
+            start_pos =3D pos
+            continue
+        if char in error_on:
+            raise TOMLDecodeError(f"Illegal character {char!r}", src, po=
s)
+        pos +=3D 1
+
+
+def parse_value(
+    src: str, pos: Pos, parse_float: ParseFloat, nest_lvl: int
+) -> tuple[Pos, Any]:
+    if nest_lvl > MAX_INLINE_NESTING:
+        # Pure Python should have raised RecursionError already.
+        # This ensures mypyc binaries eventually do the same.
+        raise RecursionError(  # pragma: no cover
+            "TOML inline arrays/tables are nested more than the allowed"
+            f" {MAX_INLINE_NESTING} levels"
+        )
+
+    try:
+        char: str | None =3D src[pos]
+    except IndexError:
+        char =3D None
+
+    # IMPORTANT: order conditions based on speed of checking and likelih=
ood
+
+    # Basic strings
+    if char =3D=3D '"':
+        if src.startswith('"""', pos):
+            return parse_multiline_str(src, pos, literal=3DFalse)
+        return parse_one_line_basic_str(src, pos)
+
+    # Literal strings
+    if char =3D=3D "'":
+        if src.startswith("'''", pos):
+            return parse_multiline_str(src, pos, literal=3DTrue)
+        return parse_literal_str(src, pos)
+
+    # Booleans
+    if char =3D=3D "t":
+        if src.startswith("true", pos):
+            return pos + 4, True
+    if char =3D=3D "f":
+        if src.startswith("false", pos):
+            return pos + 5, False
+
+    # Arrays
+    if char =3D=3D "[":
+        return parse_array(src, pos, parse_float, nest_lvl + 1)
+
+    # Inline tables
+    if char =3D=3D "{":
+        return parse_inline_table(src, pos, parse_float, nest_lvl + 1)
+
+    # Dates and times
+    datetime_match =3D RE_DATETIME.match(src, pos)
+    if datetime_match:
+        try:
+            datetime_obj =3D match_to_datetime(datetime_match)
+        except ValueError as e:
+            raise TOMLDecodeError("Invalid date or datetime", src, pos) =
from e
+        return datetime_match.end(), datetime_obj
+    localtime_match =3D RE_LOCALTIME.match(src, pos)
+    if localtime_match:
+        return localtime_match.end(), match_to_localtime(localtime_match=
)
+
+    # Integers and "normal" floats.
+    # The regex will greedily match any type starting with a decimal
+    # char, so needs to be located after handling of dates and times.
+    number_match =3D RE_NUMBER.match(src, pos)
+    if number_match:
+        return number_match.end(), match_to_number(number_match, parse_f=
loat)
+
+    # Special floats
+    first_three =3D src[pos : pos + 3]
+    if first_three in {"inf", "nan"}:
+        return pos + 3, parse_float(first_three)
+    first_four =3D src[pos : pos + 4]
+    if first_four in {"-inf", "+inf", "-nan", "+nan"}:
+        return pos + 4, parse_float(first_four)
+
+    raise TOMLDecodeError("Invalid value", src, pos)
+
+
+def is_unicode_scalar_value(codepoint: int) -> bool:
+    return (0 <=3D codepoint <=3D 55295) or (57344 <=3D codepoint <=3D 1=
114111)
+
+
+def make_safe_parse_float(parse_float: ParseFloat) -> ParseFloat:
+    """A decorator to make `parse_float` safe.
+
+    `parse_float` must not return dicts or lists, because these types
+    would be mixed with parsed TOML tables and arrays, thus confusing
+    the parser. The returned decorated callable raises `ValueError`
+    instead of returning illegal types.
+    """
+    # The default `float` callable never returns illegal types. Optimize=
 it.
+    if parse_float is float:
+        return float
+
+    def safe_parse_float(float_str: str) -> Any:
+        float_value =3D parse_float(float_str)
+        if isinstance(float_value, (dict, list)):
+            raise ValueError("parse_float must not return dicts or lists=
")
+        return float_value
+
+    return safe_parse_float
diff --git a/lib/bb/_vendor/tomli/_re.py b/lib/bb/_vendor/tomli/_re.py
new file mode 100644
index 0000000000..fc374ed63d
--- /dev/null
+++ b/lib/bb/_vendor/tomli/_re.py
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: MIT
+# SPDX-FileCopyrightText: 2021 Taneli Hukkinen
+# Licensed to PSF under a Contributor Agreement.
+
+from __future__ import annotations
+
+from datetime import date, datetime, time, timedelta, timezone, tzinfo
+from functools import lru_cache
+import re
+
+TYPE_CHECKING =3D False
+if TYPE_CHECKING:
+    from typing import Any, Final
+
+    from ._types import ParseFloat
+
+_TIME_RE_STR: Final =3D r"""
+([01][0-9]|2[0-3])             # hours
+:([0-5][0-9])                  # minutes
+(?:
+    :([0-5][0-9])              # optional seconds
+    (?:\.([0-9]{1,6})[0-9]*)?  # optional fractions of a second
+)?
+"""
+
+RE_NUMBER: Final =3D re.compile(
+    r"""
+0
+(?:
+    x[0-9A-Fa-f](?:_?[0-9A-Fa-f])*   # hex
+    |
+    b[01](?:_?[01])*                 # bin
+    |
+    o[0-7](?:_?[0-7])*               # oct
+)
+|
+[+-]?(?:0|[1-9](?:_?[0-9])*)         # dec, integer part
+(?P<floatpart>
+    (?:\.[0-9](?:_?[0-9])*)?         # optional fractional part
+    (?:[eE][+-]?[0-9](?:_?[0-9])*)?  # optional exponent part
+)
+""",
+    flags=3Dre.VERBOSE,
+)
+RE_LOCALTIME: Final =3D re.compile(_TIME_RE_STR, flags=3Dre.VERBOSE)
+RE_DATETIME: Final =3D re.compile(
+    rf"""
+([0-9]{{4}})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])  # date, e.g. 1988=
-10-27
+(?:
+    [Tt ]
+    {_TIME_RE_STR}
+    (?:([Zz])|([+-])([01][0-9]|2[0-3]):([0-5][0-9]))?  # optional time o=
ffset
+)?
+""",
+    flags=3Dre.VERBOSE,
+)
+
+
+def match_to_datetime(match: re.Match[str]) -> datetime | date:
+    """Convert a `RE_DATETIME` match to `datetime.datetime` or `datetime=
.date`.
+
+    Raises ValueError if the match does not correspond to a valid date
+    or datetime.
+    """
+    (
+        year_str,
+        month_str,
+        day_str,
+        hour_str,
+        minute_str,
+        sec_str,
+        micros_str,
+        zulu_time,
+        offset_sign_str,
+        offset_hour_str,
+        offset_minute_str,
+    ) =3D match.groups()
+    year, month, day =3D int(year_str), int(month_str), int(day_str)
+    if hour_str is None:
+        return date(year, month, day)
+    hour, minute =3D int(hour_str), int(minute_str)
+    sec =3D int(sec_str) if sec_str else 0
+    micros =3D int(micros_str.ljust(6, "0")) if micros_str else 0
+    if offset_sign_str:
+        tz: tzinfo | None =3D cached_tz(
+            offset_hour_str, offset_minute_str, offset_sign_str
+        )
+    elif zulu_time:
+        tz =3D timezone.utc
+    else:  # local date-time
+        tz =3D None
+    return datetime(year, month, day, hour, minute, sec, micros, tzinfo=3D=
tz)
+
+
+# No need to limit cache size. This is only ever called on input
+# that matched RE_DATETIME, so there is an implicit bound of
+# 24 (hours) * 60 (minutes) * 2 (offset direction) =3D 2880.
+@lru_cache(maxsize=3DNone)
+def cached_tz(hour_str: str, minute_str: str, sign_str: str) -> timezone=
:
+    sign =3D 1 if sign_str =3D=3D "+" else -1
+    return timezone(
+        timedelta(
+            hours=3Dsign * int(hour_str),
+            minutes=3Dsign * int(minute_str),
+        )
+    )
+
+
+def match_to_localtime(match: re.Match[str]) -> time:
+    hour_str, minute_str, sec_str, micros_str =3D match.groups()
+    sec =3D int(sec_str) if sec_str else 0
+    micros =3D int(micros_str.ljust(6, "0")) if micros_str else 0
+    return time(int(hour_str), int(minute_str), sec, micros)
+
+
+def match_to_number(match: re.Match[str], parse_float: ParseFloat) -> An=
y:
+    if match.group("floatpart"):
+        return parse_float(match.group())
+    return int(match.group(), 0)
diff --git a/lib/bb/_vendor/tomli/_types.py b/lib/bb/_vendor/tomli/_types=
.py
new file mode 100644
index 0000000000..d949412e03
--- /dev/null
+++ b/lib/bb/_vendor/tomli/_types.py
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: MIT
+# SPDX-FileCopyrightText: 2021 Taneli Hukkinen
+# Licensed to PSF under a Contributor Agreement.
+
+from typing import Any, Callable, Tuple
+
+# Type annotations
+ParseFloat =3D Callable[[str], Any]
+Key =3D Tuple[str, ...]
+Pos =3D int
diff --git a/lib/bb/_vendor/tomli/py.typed b/lib/bb/_vendor/tomli/py.type=
d
new file mode 100644
index 0000000000..7632ecf775
--- /dev/null
+++ b/lib/bb/_vendor/tomli/py.typed
@@ -0,0 +1 @@
+# Marker file for PEP 561
--=20
2.43.0


