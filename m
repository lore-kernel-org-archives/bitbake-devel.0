Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 56D9C73FF8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 15:08:48 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 18 May 2015 08:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,453,1427785200"; d="scan'208";a="696616679"
Received: from jmcmill1-mobl3.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.0.158])
	by orsmga001.jf.intel.com with ESMTP; 18 May 2015 08:08:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2015 16:08:36 +0100
Message-Id: <8d3977b4c852b9db3ea410e0958edb721483d33e.1431961693.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1431961693.git.paul.eggleton@linux.intel.com>
References: <cover.1431961693.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1431961693.git.paul.eggleton@linux.intel.com>
References: <cover.1431961693.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] lib/bb/utils: fix and extend edit_metadata_file()
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
X-List-Received-Date: Mon, 18 May 2015 15:08:49 -0000

Fix several bugs and add some useful enhancements to make this into a
more generic metadata editing function:
* Support modifying function values (name must be specified ending with
  "()")
* Support dropping values by returning None as the new value
* Split out edit_metadata() function to provide same functionality
  on a list/iterable
* Pass operation to callback and allow function to return them
* Pass current output lines to callback so they can be modified
* Fix handling of single-quoted values
* Handle :=, =+, .=, and =. operators
* Support arbitrary indent string
* Support indenting by length of assignment (by specifying -1)
* Fix typo in variablename - intentspc -> indentspc
* Expand function docstring to cover arguments / usage
* Add a parameter to enable matching names with overrides applied
* Add some bitbake-selftest tests

Note that this does change the expected signature of the callback
function. The only known caller is in lib/bb/utils.py itself; I doubt
anyone else has made extensive use of this function yet.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/utils.py | 271 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       | 238 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 451 insertions(+), 58 deletions(-)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 6e09858..9171509 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -22,6 +22,7 @@
 import unittest
 import bb
 import os
+import tempfile
 
 class VerCmpString(unittest.TestCase):
 
@@ -105,3 +106,273 @@ class Path(unittest.TestCase):
         for arg1, correctresult in checkitems:
             result = bb.utils._check_unsafe_delete_path(arg1)
             self.assertEqual(result, correctresult, '_check_unsafe_delete_path("%s") != %s' % (arg1, correctresult))
+
+
+class EditMetadataFile(unittest.TestCase):
+    _origfile = """
+# A comment
+HELLO = "oldvalue"
+
+THIS = "that"
+
+# Another comment
+NOCHANGE = "samevalue"
+OTHER = 'anothervalue'
+
+MULTILINE = "a1 \\
+             a2 \\
+             a3"
+
+MULTILINE2 := " \\
+               b1 \\
+               b2 \\
+               b3 \\
+               "
+
+
+MULTILINE3 = " \\
+              c1 \\
+              c2 \\
+              c3 \\
+"
+
+do_functionname() {
+    command1 ${VAL1} ${VAL2}
+    command2 ${VAL3} ${VAL4}
+}
+"""
+    def _testeditfile(self, varvalues, compareto, dummyvars=None):
+        if dummyvars is None:
+            dummyvars = []
+        with tempfile.NamedTemporaryFile('w', delete=False) as tf:
+            tf.write(self._origfile)
+            tf.close()
+            try:
+                varcalls = []
+                def handle_file(varname, origvalue, op, newlines):
+                    self.assertIn(varname, varvalues, 'Callback called for variable %s not in the list!' % varname)
+                    self.assertNotIn(varname, dummyvars, 'Callback called for variable %s in dummy list!' % varname)
+                    varcalls.append(varname)
+                    return varvalues[varname]
+
+                bb.utils.edit_metadata_file(tf.name, varvalues.keys(), handle_file)
+                with open(tf.name) as f:
+                    modfile = f.readlines()
+                # Ensure the output matches the expected output
+                self.assertEqual(compareto.splitlines(True), modfile)
+                # Ensure the callback function was called for every variable we asked for
+                # (plus allow testing behaviour when a requested variable is not present)
+                self.assertEqual(sorted(varvalues.keys()), sorted(varcalls + dummyvars))
+            finally:
+                os.remove(tf.name)
+
+
+    def test_edit_metadata_file_nochange(self):
+        # Test file doesn't get modified with nothing to do
+        self._testeditfile({}, self._origfile)
+        # Test file doesn't get modified with only dummy variables
+        self._testeditfile({'DUMMY1': ('should_not_set', None, 0, True),
+                        'DUMMY2': ('should_not_set_again', None, 0, True)}, self._origfile, dummyvars=['DUMMY1', 'DUMMY2'])
+        # Test file doesn't get modified with some the same values
+        self._testeditfile({'THIS': ('that', None, 0, True),
+                        'OTHER': ('anothervalue', None, 0, True),
+                        'MULTILINE3': ('               c1               c2               c3', None, 4, False)}, self._origfile)
+
+    def test_edit_metadata_file_1(self):
+
+        newfile1 = """
+# A comment
+HELLO = "newvalue"
+
+THIS = "that"
+
+# Another comment
+NOCHANGE = "samevalue"
+OTHER = 'anothervalue'
+
+MULTILINE = "a1 \\
+             a2 \\
+             a3"
+
+MULTILINE2 := " \\
+               b1 \\
+               b2 \\
+               b3 \\
+               "
+
+
+MULTILINE3 = " \\
+              c1 \\
+              c2 \\
+              c3 \\
+"
+
+do_functionname() {
+    command1 ${VAL1} ${VAL2}
+    command2 ${VAL3} ${VAL4}
+}
+"""
+        self._testeditfile({'HELLO': ('newvalue', None, 4, True)}, newfile1)
+
+
+    def test_edit_metadata_file_2(self):
+
+        newfile2 = """
+# A comment
+HELLO = "oldvalue"
+
+THIS = "that"
+
+# Another comment
+NOCHANGE = "samevalue"
+OTHER = 'anothervalue'
+
+MULTILINE = " \\
+    d1 \\
+    d2 \\
+    d3 \\
+    "
+
+MULTILINE2 := " \\
+               b1 \\
+               b2 \\
+               b3 \\
+               "
+
+
+MULTILINE3 = "nowsingle"
+
+do_functionname() {
+    command1 ${VAL1} ${VAL2}
+    command2 ${VAL3} ${VAL4}
+}
+"""
+        self._testeditfile({'MULTILINE': (['d1','d2','d3'], None, 4, False),
+                        'MULTILINE3': ('nowsingle', None, 4, True),
+                        'NOTPRESENT': (['a', 'b'], None, 4, False)}, newfile2, dummyvars=['NOTPRESENT'])
+
+
+    def test_edit_metadata_file_3(self):
+
+        newfile3 = """
+# A comment
+HELLO = "oldvalue"
+
+# Another comment
+NOCHANGE = "samevalue"
+OTHER = "yetanothervalue"
+
+MULTILINE = "e1 \\
+             e2 \\
+             e3 \\
+             "
+
+MULTILINE2 := "f1 \\
+\tf2 \\
+\t"
+
+
+MULTILINE3 = " \\
+              c1 \\
+              c2 \\
+              c3 \\
+"
+
+do_functionname() {
+    othercommand_one a b c
+    othercommand_two d e f
+}
+"""
+
+        self._testeditfile({'do_functionname()': (['othercommand_one a b c', 'othercommand_two d e f'], None, 4, False),
+                        'MULTILINE2': (['f1', 'f2'], None, '\t', True),
+                        'MULTILINE': (['e1', 'e2', 'e3'], None, -1, True),
+                        'THIS': (None, None, 0, False),
+                        'OTHER': ('yetanothervalue', None, 0, True)}, newfile3)
+
+
+    def test_edit_metadata_file_4(self):
+
+        newfile4 = """
+# A comment
+HELLO = "oldvalue"
+
+THIS = "that"
+
+# Another comment
+OTHER = 'anothervalue'
+
+MULTILINE = "a1 \\
+             a2 \\
+             a3"
+
+MULTILINE2 := " \\
+               b1 \\
+               b2 \\
+               b3 \\
+               "
+
+
+"""
+
+        self._testeditfile({'NOCHANGE': (None, None, 0, False),
+                        'MULTILINE3': (None, None, 0, False),
+                        'THIS': ('that', None, 0, False),
+                        'do_functionname()': (None, None, 0, False)}, newfile4)
+
+
+    def test_edit_metadata(self):
+        newfile5 = """
+# A comment
+HELLO = "hithere"
+
+# A new comment
+THIS += "that"
+
+# Another comment
+NOCHANGE = "samevalue"
+OTHER = 'anothervalue'
+
+MULTILINE = "a1 \\
+             a2 \\
+             a3"
+
+MULTILINE2 := " \\
+               b1 \\
+               b2 \\
+               b3 \\
+               "
+
+
+MULTILINE3 = " \\
+              c1 \\
+              c2 \\
+              c3 \\
+"
+
+NEWVAR = "value"
+
+do_functionname() {
+    command1 ${VAL1} ${VAL2}
+    command2 ${VAL3} ${VAL4}
+}
+"""
+
+
+        def handle_var(varname, origvalue, op, newlines):
+            if varname == 'THIS':
+                newlines.append('# A new comment\n')
+            elif varname == 'do_functionname()':
+                newlines.append('NEWVAR = "value"\n')
+                newlines.append('\n')
+            valueitem = varvalues.get(varname, None)
+            if valueitem:
+                return valueitem
+            else:
+                return (origvalue, op, 0, True)
+
+        varvalues = {'HELLO': ('hithere', None, 0, True), 'THIS': ('that', '+=', 0, True)}
+        varlist = ['HELLO', 'THIS', 'do_functionname()']
+        (updated, newlines) = bb.utils.edit_metadata(self._origfile.splitlines(True), varlist, handle_var)
+        self.assertTrue(updated, 'List should be updated but isn\'t')
+        self.assertEqual(newlines, newfile5.splitlines(True))
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0db7e56..988b845 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -963,14 +963,62 @@ def exec_flat_python_func(func, *args, **kwargs):
     bb.utils.better_exec(comp, context, code, '<string>')
     return context['retval']
 
-def edit_metadata_file(meta_file, variables, func):
-    """Edit a recipe or config file and modify one or more specified
-    variable values set in the file using a specified callback function.
-    The file is only written to if the value(s) actually change.
+def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
+    """Edit lines from a recipe or config file and modify one or more
+    specified variable values set in the file using a specified callback
+    function. Lines are expected to have trailing newlines.
+    Parameters:
+        meta_lines: lines from the file; can be a list or an iterable
+            (e.g. file pointer)
+        variables: a list of variable names to look for. Functions
+            may also be specified, but must be specified with '()' at
+            the end of the name. Note that the function doesn't have
+            any intrinsic understanding of _append, _prepend, _remove,
+            or overrides, so these are considered as part of the name.
+            These values go into a regular expression, so regular
+            expression syntax is allowed.
+        varfunc: callback function called for every variable matching
+            one of the entries in the variables parameter. The function
+            should take four arguments:
+                varname: name of variable matched
+                origvalue: current value in file
+                op: the operator (e.g. '+=')
+                newlines: list of lines up to this point. You can use
+                    this to prepend lines before this variable setting
+                    if you wish.
+            and should return a three-element tuple:
+                newvalue: new value to substitute in, or None to drop
+                    the variable setting entirely. (If the removal
+                    results in two consecutive blank lines, one of the
+                    blank lines will also be dropped).
+                newop: the operator to use - if you specify None here,
+                    the original operation will be used.
+                indent: number of spaces to indent multi-line entries,
+                    or -1 to indent up to the level of the assignment
+                    and opening quote, or a string to use as the indent.
+                minbreak: True to allow the first element of a
+                    multi-line value to continue on the same line as
+                    the assignment, False to indent before the first
+                    element.
+        match_overrides: True to match items with _overrides on the end,
+            False otherwise
+    Returns a tuple:
+        updated:
+            True if changes were made, False otherwise.
+        newlines:
+            Lines after processing
     """
+
     var_res = {}
+    if match_overrides:
+        override_re = '(_[a-zA-Z0-9-_$(){}]+)?'
+    else:
+        override_re = ''
     for var in variables:
-        var_res[var] = re.compile(r'^%s[ \t]*[?+]*=' % var)
+        if var.endswith('()'):
+            var_res[var] = re.compile('^(%s%s)[ \\t]*\([ \\t]*\)[ \\t]*{' % (var[:-2].rstrip(), override_re))
+        else:
+            var_res[var] = re.compile('^(%s%s)[ \\t]*[?+:.]*=[+.]*[ \\t]*(["\'])' % (var, override_re))
 
     updated = False
     varset_start = ''
@@ -978,70 +1026,144 @@ def edit_metadata_file(meta_file, variables, func):
     newlines = []
     in_var = None
     full_value = ''
+    var_end = ''
 
     def handle_var_end():
-        (newvalue, indent, minbreak) = func(in_var, full_value)
-        if newvalue != full_value:
-            if isinstance(newvalue, list):
-                intentspc = ' ' * indent
-                if minbreak:
-                    # First item on first line
-                    if len(newvalue) == 1:
-                        newlines.append('%s "%s"\n' % (varset_start, newvalue[0]))
+        prerun_newlines = newlines[:]
+        op = varset_start[len(in_var):].strip()
+        (newvalue, newop, indent, minbreak) = varfunc(in_var, full_value, op, newlines)
+        changed = (prerun_newlines != newlines)
+
+        if newvalue is None:
+            # Drop the value
+            return True
+        elif newvalue != full_value or (newop not in [None, op]):
+            if newop not in [None, op]:
+                # Callback changed the operator
+                varset_new = "%s %s" % (in_var, newop)
+            else:
+                varset_new = varset_start
+
+            if isinstance(indent, (int, long)):
+                if indent == -1:
+                    indentspc = ' ' * (len(varset_new) + 2)
+                else:
+                    indentspc = ' ' * indent
+            else:
+                indentspc = indent
+            if in_var.endswith('()'):
+                # A function definition
+                if isinstance(newvalue, list):
+                    newlines.append('%s {\n%s%s\n}\n' % (varset_new, indentspc, ('\n%s' % indentspc).join(newvalue)))
+                else:
+                    if not newvalue.startswith('\n'):
+                        newvalue = '\n' + newvalue
+                    if not newvalue.endswith('\n'):
+                        newvalue = newvalue + '\n'
+                    newlines.append('%s {%s}\n' % (varset_new, newvalue))
+            else:
+                # Normal variable
+                if isinstance(newvalue, list):
+                    if not newvalue:
+                        # Empty list -> empty string
+                        newlines.append('%s ""\n' % varset_new)
+                    elif minbreak:
+                        # First item on first line
+                        if len(newvalue) == 1:
+                            newlines.append('%s "%s"\n' % (varset_new, newvalue[0]))
+                        else:
+                            newlines.append('%s "%s \\\n' % (varset_new, newvalue[0]))
+                            for item in newvalue[1:]:
+                                newlines.append('%s%s \\\n' % (indentspc, item))
+                            newlines.append('%s"\n' % indentspc)
                     else:
-                        newlines.append('%s "%s\\\n' % (varset_start, newvalue[0]))
-                        for item in newvalue[1:]:
-                            newlines.append('%s%s \\\n' % (intentspc, item))
+                        # No item on first line
+                        newlines.append('%s " \\\n' % varset_new)
+                        for item in newvalue:
+                            newlines.append('%s%s \\\n' % (indentspc, item))
                         newlines.append('%s"\n' % indentspc)
                 else:
-                    # No item on first line
-                    newlines.append('%s " \\\n' % varset_start)
-                    for item in newvalue:
-                        newlines.append('%s%s \\\n' % (intentspc, item))
-                    newlines.append('%s"\n' % intentspc)
-            else:
-                newlines.append('%s "%s"\n' % (varset_start, newvalue))
+                    newlines.append('%s "%s"\n' % (varset_new, newvalue))
             return True
         else:
             # Put the old lines back where they were
             newlines.extend(varlines)
-            return False
+            # If newlines was touched by the function, we'll need to return True
+            return changed
 
-    with open(meta_file, 'r') as f:
-        for line in f:
-            if in_var:
-                value = line.rstrip()
-                varlines.append(line)
-                full_value += value[:-1]
-                if value.endswith('"') or value.endswith("'"):
-                    full_value = full_value[:-1]
-                    if handle_var_end():
-                        updated = True
-                    in_var = None
+    checkspc = False
+
+    for line in meta_lines:
+        if in_var:
+            value = line.rstrip()
+            varlines.append(line)
+            if in_var.endswith('()'):
+                full_value += '\n' + value
             else:
-                matched = False
-                for (varname, var_re) in var_res.iteritems():
-                    if var_re.match(line):
-                        splitvalue = line.split('"', 1)
-                        varset_start = splitvalue[0].rstrip()
-                        value = splitvalue[1].rstrip()
-                        if value.endswith('\\'):
-                            value = value[:-1]
-                        full_value = value
-                        varlines = [line]
-                        in_var = varname
-                        if value.endswith('"') or value.endswith("'"):
-                            full_value = full_value[:-1]
-                            if handle_var_end():
-                                updated = True
-                            in_var = None
-                        matched = True
-                        break
-                if not matched:
-                    newlines.append(line)
+                full_value += value[:-1]
+            if value.endswith(var_end):
+                if in_var.endswith('()'):
+                    if full_value.count('{') - full_value.count('}') >= 0:
+                        continue
+                full_value = full_value[:-1]
+                if handle_var_end():
+                    updated = True
+                    checkspc = True
+                in_var = None
+        else:
+            skip = False
+            for (varname, var_re) in var_res.iteritems():
+                res = var_re.match(line)
+                if res:
+                    isfunc = varname.endswith('()')
+                    if isfunc:
+                        splitvalue = line.split('{', 1)
+                        var_end = '}'
+                    else:
+                        var_end = res.groups()[-1]
+                        splitvalue = line.split(var_end, 1)
+                    varset_start = splitvalue[0].rstrip()
+                    value = splitvalue[1].rstrip()
+                    if not isfunc and value.endswith('\\'):
+                        value = value[:-1]
+                    full_value = value
+                    varlines = [line]
+                    in_var = res.group(1)
+                    if isfunc:
+                        in_var += '()'
+                    if value.endswith(var_end):
+                        full_value = full_value[:-1]
+                        if handle_var_end():
+                            updated = True
+                            checkspc = True
+                        in_var = None
+                    skip = True
+                    break
+            if not skip:
+                if checkspc:
+                    checkspc = False
+                    if newlines[-1] == '\n' and line == '\n':
+                        # Squash blank line if there are two consecutive blanks after a removal
+                        continue
+                newlines.append(line)
+    return (updated, newlines)
+
+
+def edit_metadata_file(meta_file, variables, varfunc):
+    """Edit a recipe or config file and modify one or more specified
+    variable values set in the file using a specified callback function.
+    The file is only written to if the value(s) actually change.
+    This is basically the file version of edit_metadata(), see that
+    function's description for parameter/usage information.
+    Returns True if the file was written to, False otherwise.
+    """
+    with open(meta_file, 'r') as f:
+        (updated, newlines) = edit_metadata(f, variables, varfunc)
     if updated:
         with open(meta_file, 'w') as f:
             f.writelines(newlines)
+    return updated
+
 
 def edit_bblayers_conf(bblayers_conf, add, remove):
     """Edit bblayers.conf, adding and/or removing layers"""
@@ -1070,7 +1192,7 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
     # Need to use a list here because we can't set non-local variables from a callback in python 2.x
     bblayercalls = []
 
-    def handle_bblayers(varname, origvalue):
+    def handle_bblayers(varname, origvalue, op, newlines):
         bblayercalls.append(varname)
         updated = False
         bblayers = [remove_trailing_sep(x) for x in origvalue.split()]
@@ -1094,9 +1216,9 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
                     notadded.append(addlayer)
 
         if updated:
-            return (bblayers, 2, False)
+            return (bblayers, None, 2, False)
         else:
-            return (origvalue, 2, False)
+            return (origvalue, None, 2, False)
 
     edit_metadata_file(bblayers_conf, ['BBLAYERS'], handle_bblayers)
 
-- 
2.1.0


