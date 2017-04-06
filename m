Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id E0A9D77D44
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:53:14 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565931"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:53:13 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:11 +1200
Message-Id: <767944922959b57cfcdce7c4f107dc3ce6786fd8.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 11/11] bitbake-diffsigs: colourise output
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
X-List-Received-Date: Thu, 06 Apr 2017 21:53:15 -0000

If the output is a TTY, add colour to the output in order to make it
easier to read. At the moment this is fairly basic, just add colour to
the "titles" of each change and to the diff output.

I tried to introduce this without changing the code too much - rather
than moving everything over to the new python formatting style, I've
introduced a color_format() function which takes care of the colour
formatting, either accepting additional format arguments or
alternatively leaving the caller to use the old-style formatting (%) to
insert values.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs |  18 ++++++---
 lib/bb/siggen.py     | 101 +++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index e9fdb48..884be1e 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -34,7 +34,7 @@ import bb.msg
 
 logger = bb.msg.logger_create('bitbake-diffsigs')
 
-def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None):
+def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None, color=False):
     """ Find the most recent signature files for the specified PN/task and compare them """
 
     if not hasattr(bb.siggen, 'find_siginfo'):
@@ -79,7 +79,7 @@ def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None):
         elif not hash2 in hashfiles:
             recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
         else:
-            out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb)
+            out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb, color=color)
             for change in out2:
                 for line in change.splitlines():
                     recout.append('  ' + line)
@@ -89,7 +89,7 @@ def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None):
     # Recurse into signature comparison
     logger.debug("Signature file (previous): %s" % latestfiles[-2])
     logger.debug("Signature file (latest): %s" % latestfiles[-1])
-    output = bb.siggen.compare_sigfiles(latestfiles[-2], latestfiles[-1], recursecb)
+    output = bb.siggen.compare_sigfiles(latestfiles[-2], latestfiles[-1], recursecb, color=color)
     if output:
         print('\n'.join(output))
     sys.exit(0)
@@ -103,6 +103,10 @@ parser.add_argument('-d', '--debug',
                     help='Enable debug output',
                     action='store_true')
 
+parser.add_argument('--color',
+        help='Colorize output (where %(metavar)s is %(choices)s)',
+        choices=['auto', 'always', 'never'], default='auto', metavar='color')
+
 parser.add_argument("-t", "--task",
         help="find the signature data files for last two runs of the specified task and compare them",
         action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
@@ -125,20 +129,22 @@ options = parser.parse_args()
 if options.debug:
     logger.setLevel(logging.DEBUG)
 
+color = (options.color == 'always' or (options.color == 'auto' and sys.stdout.isatty()))
+
 if options.taskargs:
     with bb.tinfoil.Tinfoil() as tinfoil:
         tinfoil.prepare(config_only=True)
         if options.sigargs:
-            find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1], options.sigargs[0], options.sigargs[1])
+            find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1], options.sigargs[0], options.sigargs[1], color=color)
         else:
-            find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1])
+            find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1], color=color)
 else:
     if options.sigargs:
         logger.error('-s/--signature can only be used together with -t/--task')
         sys.exit(1)
     try:
         if options.sigdatafile1 and options.sigdatafile2:
-            output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2)
+            output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2, color=color)
         elif options.sigdatafile1:
             output = bb.siggen.dump_sigfile(options.sigdatafile1)
     except IOError as e:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index d40c721..25ad3e9 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -353,7 +353,23 @@ def dump_this_task(outfile, d):
     referencestamp = bb.build.stamp_internal(task, d, None, True)
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile:" + referencestamp)
 
-def worddiff_str(oldstr, newstr):
+def init_colors(enable_color):
+    """Initialise colour dict for passing to compare_sigfiles()"""
+    # First set up the colours
+    colors = {'color_title':   '\033[1;37;40m',
+              'color_default': '\033[0;37;40m',
+              'color_add':     '\033[1;32;40m',
+              'color_remove':  '\033[1;31;40m',
+             }
+    # Leave all keys present but clear the values
+    if not enable_color:
+        for k in colors.keys():
+            colors[k] = ''
+    return colors
+
+def worddiff_str(oldstr, newstr, colors=None):
+    if not colors:
+        colors = init_colors(False)
     diff = simplediff.diff(oldstr.split(' '), newstr.split(' '))
     ret = []
     for change, value in diff:
@@ -361,17 +377,19 @@ def worddiff_str(oldstr, newstr):
         if change == '=':
             ret.append(value)
         elif change == '+':
-            item = '{+%s+}' % value
+            item = '{color_add}{{+{value}+}}{color_default}'.format(value=value, **colors)
             ret.append(item)
         elif change == '-':
-            item = '[-%s-]' % value
+            item = '{color_remove}[-{value}-]{color_default}'.format(value=value, **colors)
             ret.append(item)
     whitespace_note = ''
     if oldstr != newstr and ' '.join(oldstr.split()) == ' '.join(newstr.split()):
         whitespace_note = ' (whitespace changed)'
     return '"%s"%s' % (' '.join(ret), whitespace_note)
 
-def list_inline_diff(oldlist, newlist):
+def list_inline_diff(oldlist, newlist, colors=None):
+    if not colors:
+        colors = init_colors(False)
     diff = simplediff.diff(oldlist, newlist)
     ret = []
     for change, value in diff:
@@ -379,10 +397,10 @@ def list_inline_diff(oldlist, newlist):
         if change == '=':
             ret.append("'%s'" % value)
         elif change == '+':
-            item = "+'%s'" % value
+            item = '{color_add}+{value}{color_default}'.format(value=value, **colors)
             ret.append(item)
         elif change == '-':
-            item = "-'%s'" % value
+            item = '{color_remove}-{value}{color_default}'.format(value=value, **colors)
             ret.append(item)
     return '[%s]' % (', '.join(ret))
 
@@ -409,9 +427,26 @@ def clean_basepaths_list(a):
         b.append(clean_basepath(x))
     return b
 
-def compare_sigfiles(a, b, recursecb=None, collapsed=False):
+def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
     output = []
 
+    colors = init_colors(color)
+    def color_format(formatstr, **values):
+        """
+        Return colour formatted string.
+        NOTE: call with the format string, not an already formatted string
+        containing values (otherwise you could have trouble with { and }
+        characters)
+        """
+        if not formatstr.endswith('{color_default}'):
+            formatstr += '{color_default}'
+        # In newer python 3 versions you can pass both of these directly,
+        # but we only require 3.4 at the moment
+        formatparams = {}
+        formatparams.update(colors)
+        formatparams.update(values)
+        return formatstr.format(**formatparams)
+
     with open(a, 'rb') as f:
         p1 = pickle.Unpickler(f)
         a_data = p1.load()
@@ -465,33 +500,33 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
         return changed, added, removed
 
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
-        output.append("basewhitelist changed from '%s' to '%s'" % (a_data['basewhitelist'], b_data['basewhitelist']))
+        output.append(color_format("{color_title}basewhitelist changed{color_default} from '%s' to '%s'") % (a_data['basewhitelist'], b_data['basewhitelist']))
         if a_data['basewhitelist'] and b_data['basewhitelist']:
             output.append("changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist']))
 
     if 'taskwhitelist' in a_data and a_data['taskwhitelist'] != b_data['taskwhitelist']:
-        output.append("taskwhitelist changed from '%s' to '%s'" % (a_data['taskwhitelist'], b_data['taskwhitelist']))
+        output.append(color_format("{color_title}taskwhitelist changed{color_default} from '%s' to '%s'") % (a_data['taskwhitelist'], b_data['taskwhitelist']))
         if a_data['taskwhitelist'] and b_data['taskwhitelist']:
             output.append("changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist']))
 
     if a_data['taskdeps'] != b_data['taskdeps']:
-        output.append("Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps'])))
+        output.append(color_format("{color_title}Task dependencies changed{color_default} from:\n%s\nto:\n%s") % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps'])))
 
     if a_data['basehash'] != b_data['basehash'] and not collapsed:
-        output.append("basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash']))
+        output.append(color_format("{color_title}basehash changed{color_default} from %s to %s") % (a_data['basehash'], b_data['basehash']))
 
     changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
     if changed:
         for dep in changed:
-            output.append("List of dependencies for variable %s changed from '%s' to '%s'" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
+            output.append(color_format("{color_title}List of dependencies for variable %s changed from '{color_default}%s{color_title}' to '{color_default}%s{color_title}'") % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
             if a_data['gendeps'][dep] and b_data['gendeps'][dep]:
                 output.append("changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep]))
     if added:
         for dep in added:
-            output.append("Dependency on variable %s was added" % (dep))
+            output.append(color_format("{color_title}Dependency on variable %s was added") % (dep))
     if removed:
         for dep in removed:
-            output.append("Dependency on Variable %s was removed" % (dep))
+            output.append(color_format("{color_title}Dependency on Variable %s was removed") % (dep))
 
 
     changed, added, removed = dict_diff(a_data['varvals'], b_data['varvals'])
@@ -504,11 +539,20 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
                 # Cut off the first two lines, since we aren't interested in
                 # the old/new filename (they are blank anyway in this case)
                 difflines = list(diff)[2:]
-                output.append("Variable %s value changed:\n%s" % (dep, '\n'.join(difflines)))
+                if color:
+                    # Add colour to diff output
+                    for i, line in enumerate(difflines):
+                        if line.startswith('+'):
+                            line = color_format('{color_add}{line}', line=line)
+                            difflines[i] = line
+                        elif line.startswith('-'):
+                            line = color_format('{color_remove}{line}', line=line)
+                            difflines[i] = line
+                output.append(color_format("{color_title}Variable {var} value changed:{color_default}\n{diff}", var=dep, diff='\n'.join(difflines)))
             elif newval and oldval and (' ' in oldval or ' ' in newval):
-                output.append("Variable %s value changed:\n%s" % (dep, worddiff_str(oldval, newval)))
+                output.append(color_format("{color_title}Variable {var} value changed:{color_default}\n{diff}", var=dep, diff=worddiff_str(oldval, newval, colors)))
             else:
-                output.append("Variable %s value changed from '%s' to '%s'" % (dep, oldval, newval))
+                output.append(color_format("{color_title}Variable {var} value changed from '{color_default}{oldval}{color_title}' to '{color_default}{newval}{color_title}'{color_default}", var=dep, oldval=oldval, newval=newval))
 
     if not 'file_checksum_values' in a_data:
          a_data['file_checksum_values'] = {}
@@ -518,13 +562,13 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
     changed, added, removed = file_checksums_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
     if changed:
         for f, old, new in changed:
-            output.append("Checksum for file %s changed from %s to %s" % (f, old, new))
+            output.append(color_format("{color_title}Checksum for file %s changed{color_default} from %s to %s") % (f, old, new))
     if added:
         for f in added:
-            output.append("Dependency on checksum of file %s was added" % (f))
+            output.append(color_format("{color_title}Dependency on checksum of file %s was added") % (f))
     if removed:
         for f in removed:
-            output.append("Dependency on checksum of file %s was removed" % (f))
+            output.append(color_format("{color_title}Dependency on checksum of file %s was removed") % (f))
 
     if not 'runtaskdeps' in a_data:
          a_data['runtaskdeps'] = {}
@@ -539,18 +583,19 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
             for idx, task in enumerate(a_data['runtaskdeps']):
                 a = a_data['runtaskdeps'][idx]
                 b = b_data['runtaskdeps'][idx]
-                if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b]:
-                    changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
+                if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b] and not collapsed:
+                    changed.append("%s with hash %s\n changed to\n%s with hash %s" % (clean_basepath(a), a_data['runtaskhashes'][a], clean_basepath(b), b_data['runtaskhashes'][b]))
 
         if changed:
             clean_a = clean_basepaths_list(a_data['runtaskdeps'])
             clean_b = clean_basepaths_list(b_data['runtaskdeps'])
             if clean_a != clean_b:
-                output.append("runtaskdeps changed:\n%s" % list_inline_diff(clean_a, clean_b))
+                output.append(color_format("{color_title}runtaskdeps changed:{color_default}\n%s") % list_inline_diff(clean_a, clean_b, colors))
             else:
-                output.append("runtaskdeps changed:")
+                output.append(color_format("{color_title}runtaskdeps changed:"))
             output.append("\n".join(changed))
 
+
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
         a = a_data['runtaskhashes']
         b = b_data['runtaskhashes']
@@ -564,7 +609,7 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
                             #output.append("Dependency on task %s was replaced by %s with same hash" % (dep, bdep))
                             bdep_found = True
                 if not bdep_found:
-                    output.append("Dependency on task %s was added with hash %s" % (clean_basepath(dep), b[dep]))
+                    output.append(color_format("{color_title}Dependency on task %s was added{color_default} with hash %s") % (clean_basepath(dep), b[dep]))
         if removed:
             for dep in removed:
                 adep_found = False
@@ -574,11 +619,11 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
                             #output.append("Dependency on task %s was replaced by %s with same hash" % (adep, dep))
                             adep_found = True
                 if not adep_found:
-                    output.append("Dependency on task %s was removed with hash %s" % (clean_basepath(dep), a[dep]))
+                    output.append(color_format("{color_title}Dependency on task %s was removed{color_default} with hash %s") % (clean_basepath(dep), a[dep]))
         if changed:
             for dep in changed:
                 if not collapsed:
-                    output.append("Hash for dependent task %s changed from %s to %s" % (clean_basepath(dep), a[dep], b[dep]))
+                    output.append(color_format("{color_title}Hash for dependent task %s changed{color_default} from %s to %s") % (clean_basepath(dep), a[dep], b[dep]))
                 if callable(recursecb):
                     recout = recursecb(dep, a[dep], b[dep])
                     if recout:
@@ -592,7 +637,7 @@ def compare_sigfiles(a, b, recursecb=None, collapsed=False):
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)
     if a_taint != b_taint:
-        output.append("Taint (by forced/invalidated task) changed from %s to %s" % (a_taint, b_taint))
+        output.append(color_format("{color_title}Taint (by forced/invalidated task) changed{color_default} from %s to %s") % (a_taint, b_taint))
 
     return output
 
-- 
2.9.3


