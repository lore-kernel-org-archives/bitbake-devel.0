Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 5B83577CFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:53:11 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565925"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:53:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:10 +1200
Message-Id: <c8a90f77840faf124571f3b7b52004b70b1c2426.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 10/11] lib/bb/siggen: show word-diff for single-line values containing spaces
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 06 Apr 2017 21:53:11 -0000

If a variable value has changed and either the new or old value contains
spaces, a word diff should be appropriate and may be a bit more readable.
Import the "simplediff" module and use it to show a word diff (in the
style of GNU wdiff and git diff --word-diff).

Also use a similar style diff to show changes in the runtaskhashes list.
I didn't use an actual word-diff here since it's a little different - we
can be sure that the list is a list and not simply a free-format string.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 LICENSE                    |   2 +
 lib/bb/siggen.py           |  38 ++++++++-
 lib/simplediff/LICENSE     |  22 +++++
 lib/simplediff/__init__.py | 198 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 259 insertions(+), 1 deletion(-)
 create mode 100644 lib/simplediff/LICENSE
 create mode 100644 lib/simplediff/__init__.py

diff --git a/LICENSE b/LICENSE
index 5d4a4c2..7d4e5f4 100644
--- a/LICENSE
+++ b/LICENSE
@@ -15,3 +15,5 @@ Foundation and individual contributors.
 * QUnit is redistributed under the MIT license.
 
 * Font Awesome fonts redistributed under the SIL Open Font License 1.1
+
+* simplediff is distributed under the zlib license.
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 3c5d862..d40c721 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -6,6 +6,7 @@ import tempfile
 import pickle
 import bb.data
 import difflib
+import simplediff
 from bb.checksum import FileChecksumCache
 
 logger = logging.getLogger('BitBake.SigGen')
@@ -352,6 +353,39 @@ def dump_this_task(outfile, d):
     referencestamp = bb.build.stamp_internal(task, d, None, True)
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile:" + referencestamp)
 
+def worddiff_str(oldstr, newstr):
+    diff = simplediff.diff(oldstr.split(' '), newstr.split(' '))
+    ret = []
+    for change, value in diff:
+        value = ' '.join(value)
+        if change == '=':
+            ret.append(value)
+        elif change == '+':
+            item = '{+%s+}' % value
+            ret.append(item)
+        elif change == '-':
+            item = '[-%s-]' % value
+            ret.append(item)
+    whitespace_note = ''
+    if oldstr != newstr and ' '.join(oldstr.split()) == ' '.join(newstr.split()):
+        whitespace_note = ' (whitespace changed)'
+    return '"%s"%s' % (' '.join(ret), whitespace_note)
+
+def list_inline_diff(oldlist, newlist):
+    diff = simplediff.diff(oldlist, newlist)
+    ret = []
+    for change, value in diff:
+        value = ' '.join(value)
+        if change == '=':
+            ret.append("'%s'" % value)
+        elif change == '+':
+            item = "+'%s'" % value
+            ret.append(item)
+        elif change == '-':
+            item = "-'%s'" % value
+            ret.append(item)
+    return '[%s]' % (', '.join(ret))
+
 def clean_basepath(a):
     mc = None
     if a.startswith("multiconfig:"):
@@ -471,6 +505,8 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
                 # the old/new filename (they are blank anyway in this case)
                 difflines = list(diff)[2:]
                 output.append("Variable %s value changed:\n%s" % (dep, '\n'.join(difflines)))
+            elif newval and oldval and (' ' in oldval or ' ' in newval):
+                output.append("Variable %s value changed:\n%s" % (dep, worddiff_str(oldval, newval)))
             else:
                 output.append("Variable %s value changed from '%s' to '%s'" % (dep, oldval, newval))
 
@@ -510,7 +546,7 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
             clean_a = clean_basepaths_list(a_data['runtaskdeps'])
             clean_b = clean_basepaths_list(b_data['runtaskdeps'])
             if clean_a != clean_b:
-                output.append("runtaskdeps changed from %s to %s" % (clean_a, clean_b))
+                output.append("runtaskdeps changed:\n%s" % list_inline_diff(clean_a, clean_b))
             else:
                 output.append("runtaskdeps changed:")
             output.append("\n".join(changed))
diff --git a/lib/simplediff/LICENSE b/lib/simplediff/LICENSE
new file mode 100644
index 0000000..8242dde
--- /dev/null
+++ b/lib/simplediff/LICENSE
@@ -0,0 +1,22 @@
+Copyright (c) 2008 - 2013 Paul Butler and contributors
+
+This sofware may be used under a zlib/libpng-style license:
+
+This software is provided 'as-is', without any express or implied warranty. In
+no event will the authors be held liable for any damages arising from the use
+of this software.
+
+Permission is granted to anyone to use this software for any purpose, including
+commercial applications, and to alter it and redistribute it freely, subject to
+the following restrictions:
+
+1. The origin of this software must not be misrepresented; you must not claim
+that you wrote the original software. If you use this software in a product, an
+acknowledgment in the product documentation would be appreciated but is not
+required.
+
+2. Altered source versions must be plainly marked as such, and must not be
+misrepresented as being the original software.
+
+3. This notice may not be removed or altered from any source distribution.
+
diff --git a/lib/simplediff/__init__.py b/lib/simplediff/__init__.py
new file mode 100644
index 0000000..57ee3c5
--- /dev/null
+++ b/lib/simplediff/__init__.py
@@ -0,0 +1,198 @@
+'''
+Simple Diff for Python version 1.0
+
+Annotate two versions of a list with the values that have been
+changed between the versions, similar to unix's `diff` but with
+a dead-simple Python interface.
+
+(C) Paul Butler 2008-2012 <http://www.paulbutler.org/>
+May be used and distributed under the zlib/libpng license
+<http://www.opensource.org/licenses/zlib-license.php>
+'''
+
+__all__ = ['diff', 'string_diff', 'html_diff']
+__version__ = '1.0'
+
+
+def diff(old, new):
+    '''
+    Find the differences between two lists. Returns a list of pairs, where the
+    first value is in ['+','-','='] and represents an insertion, deletion, or
+    no change for that list. The second value of the pair is the list
+    of elements.
+
+    Params:
+        old     the old list of immutable, comparable values (ie. a list
+                of strings)
+        new     the new list of immutable, comparable values
+   
+    Returns:
+        A list of pairs, with the first part of the pair being one of three
+        strings ('-', '+', '=') and the second part being a list of values from
+        the original old and/or new lists. The first part of the pair
+        corresponds to whether the list of values is a deletion, insertion, or
+        unchanged, respectively.
+
+    Examples:
+        >>> diff([1,2,3,4],[1,3,4])
+        [('=', [1]), ('-', [2]), ('=', [3, 4])]
+
+        >>> diff([1,2,3,4],[2,3,4,1])
+        [('-', [1]), ('=', [2, 3, 4]), ('+', [1])]
+
+        >>> diff('The quick brown fox jumps over the lazy dog'.split(),
+        ...      'The slow blue cheese drips over the lazy carrot'.split())
+        ... # doctest: +NORMALIZE_WHITESPACE
+        [('=', ['The']),
+         ('-', ['quick', 'brown', 'fox', 'jumps']),
+         ('+', ['slow', 'blue', 'cheese', 'drips']),
+         ('=', ['over', 'the', 'lazy']),
+         ('-', ['dog']),
+         ('+', ['carrot'])]
+
+    '''
+
+    # Create a map from old values to their indices
+    old_index_map = dict()
+    for i, val in enumerate(old):
+        old_index_map.setdefault(val,list()).append(i)
+
+    # Find the largest substring common to old and new.
+    # We use a dynamic programming approach here.
+    # 
+    # We iterate over each value in the `new` list, calling the
+    # index `inew`. At each iteration, `overlap[i]` is the
+    # length of the largest suffix of `old[:i]` equal to a suffix
+    # of `new[:inew]` (or unset when `old[i]` != `new[inew]`).
+    #
+    # At each stage of iteration, the new `overlap` (called
+    # `_overlap` until the original `overlap` is no longer needed)
+    # is built from the old one.
+    #
+    # If the length of overlap exceeds the largest substring
+    # seen so far (`sub_length`), we update the largest substring
+    # to the overlapping strings.
+
+    overlap = dict()
+    # `sub_start_old` is the index of the beginning of the largest overlapping
+    # substring in the old list. `sub_start_new` is the index of the beginning
+    # of the same substring in the new list. `sub_length` is the length that
+    # overlaps in both.
+    # These track the largest overlapping substring seen so far, so naturally
+    # we start with a 0-length substring.
+    sub_start_old = 0
+    sub_start_new = 0
+    sub_length = 0
+
+    for inew, val in enumerate(new):
+        _overlap = dict()
+        for iold in old_index_map.get(val,list()):
+            # now we are considering all values of iold such that
+            # `old[iold] == new[inew]`.
+            _overlap[iold] = (iold and overlap.get(iold - 1, 0)) + 1
+            if(_overlap[iold] > sub_length):
+                # this is the largest substring seen so far, so store its
+                # indices
+                sub_length = _overlap[iold]
+                sub_start_old = iold - sub_length + 1
+                sub_start_new = inew - sub_length + 1
+        overlap = _overlap
+
+    if sub_length == 0:
+        # If no common substring is found, we return an insert and delete...
+        return (old and [('-', old)] or []) + (new and [('+', new)] or [])
+    else:
+        # ...otherwise, the common substring is unchanged and we recursively
+        # diff the text before and after that substring
+        return diff(old[ : sub_start_old], new[ : sub_start_new]) + \
+               [('=', new[sub_start_new : sub_start_new + sub_length])] + \
+               diff(old[sub_start_old + sub_length : ],
+                       new[sub_start_new + sub_length : ])
+
+
+def string_diff(old, new):
+    '''
+    Returns the difference between the old and new strings when split on
+    whitespace. Considers punctuation a part of the word
+
+    This function is intended as an example; you'll probably want
+    a more sophisticated wrapper in practice.
+
+    Params:
+        old     the old string
+        new     the new string
+
+    Returns:
+        the output of `diff` on the two strings after splitting them
+        on whitespace (a list of change instructions; see the docstring
+        of `diff`)
+
+    Examples:
+        >>> string_diff('The quick brown fox', 'The fast blue fox')
+        ... # doctest: +NORMALIZE_WHITESPACE
+        [('=', ['The']),
+         ('-', ['quick', 'brown']),
+         ('+', ['fast', 'blue']),
+         ('=', ['fox'])]
+
+    '''
+    return diff(old.split(), new.split())
+
+
+def html_diff(old, new):
+    '''
+    Returns the difference between two strings (as in stringDiff) in
+    HTML format. HTML code in the strings is NOT escaped, so you
+    will get weird results if the strings contain HTML.
+
+    This function is intended as an example; you'll probably want
+    a more sophisticated wrapper in practice.
+
+    Params:
+        old     the old string
+        new     the new string
+
+    Returns:
+        the output of the diff expressed with HTML <ins> and <del>
+        tags.
+
+    Examples:
+        >>> html_diff('The quick brown fox', 'The fast blue fox')
+        'The <del>quick brown</del> <ins>fast blue</ins> fox'
+    '''
+    con = {'=': (lambda x: x),
+           '+': (lambda x: "<ins>" + x + "</ins>"),
+           '-': (lambda x: "<del>" + x + "</del>")}
+    return " ".join([(con[a])(" ".join(b)) for a, b in string_diff(old, new)])
+
+
+def check_diff(old, new):
+    '''
+    This tests that diffs returned by `diff` are valid. You probably won't
+    want to use this function, but it's provided for documentation and
+    testing.
+
+    A diff should satisfy the property that the old input is equal to the
+    elements of the result annotated with '-' or '=' concatenated together.
+    Likewise, the new input is equal to the elements of the result annotated
+    with '+' or '=' concatenated together. This function compares `old`,
+    `new`, and the results of `diff(old, new)` to ensure this is true.
+
+    Tests:
+        >>> check_diff('ABCBA', 'CBABA')
+        >>> check_diff('Foobarbaz', 'Foobarbaz')
+        >>> check_diff('Foobarbaz', 'Boobazbam')
+        >>> check_diff('The quick brown fox', 'Some quick brown car')
+        >>> check_diff('A thick red book', 'A quick blue book')
+        >>> check_diff('dafhjkdashfkhasfjsdafdasfsda', 'asdfaskjfhksahkfjsdha')
+        >>> check_diff('88288822828828288282828', '88288882882828282882828')
+        >>> check_diff('1234567890', '24689')
+    '''
+    old = list(old)
+    new = list(new)
+    result = diff(old, new)
+    _old = [val for (a, vals) in result if (a in '=-') for val in vals]
+    assert old == _old, 'Expected %s, got %s' % (old, _old)
+    _new = [val for (a, vals) in result if (a in '=+') for val in vals]
+    assert new == _new, 'Expected %s, got %s' % (new, _new)
+
-- 
2.9.3


