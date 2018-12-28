Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id B891A6C4DE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Dec 2018 17:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 2C578183C0;
	Fri, 28 Dec 2018 18:31:21 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id NrD7r56Be2jh; Fri, 28 Dec 2018 18:31:18 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id E03BA183A9;
	Fri, 28 Dec 2018 18:31:18 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0ABB1A072;
	Fri, 28 Dec 2018 18:31:18 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B50651A070;
	Fri, 28 Dec 2018 18:31:18 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Fri, 28 Dec 2018 18:31:18 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id A8CAC2310;
	Fri, 28 Dec 2018 18:31:18 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id wBSHVI9l026118;
	Fri, 28 Dec 2018 18:31:18 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id wBSHVIq3026117;
	Fri, 28 Dec 2018 18:31:18 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Dec 2018 18:30:39 +0100
Message-Id: <20181228173040.26029-1-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake-diffsigs: Merge with bitbake-dumpsig
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
X-List-Received-Date: Fri, 28 Dec 2018 17:31:21 -0000

The functionalities of bitbake-diffsigs and bitbake-dumpsig are so
similar that they can be merged into one. Add an option --dump to make
bitbake-diffsigs dump the last signature data instead of comparing it.
Keep bitbake-dumpsig as a symbolic link to bitbake-diffsigs. When it is
called as bitbake-dumpsig, it behaves as if --dump was specified.

Also make -D the short option for --debug again (the way it used to be,
and still was for bitbake-dumpsig), so that -d can be used as the short
option for --dump.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/bin/bitbake-diffsigs | 139 +++++++++++++++++++++++++------------------
 bitbake/bin/bitbake-dumpsig  |  95 +----------------------------
 2 files changed, 82 insertions(+), 152 deletions(-)
 mode change 100755 => 120000 bitbake/bin/bitbake-dumpsig

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 4e6bbddcd8..b0869e1143 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
-# bitbake-diffsigs
-# BitBake task signature data comparison utility
+# bitbake-diffsigs / bitbake-dumpsig
+# BitBake task signature data dump and comparison utility
 #
 # Copyright (C) 2012-2013, 2017 Intel Corporation
 #
@@ -21,7 +21,6 @@
 import os
 import sys
 import warnings
-import fnmatch
 import argparse
 import logging
 import pickle
@@ -32,7 +31,10 @@ import bb.tinfoil
 import bb.siggen
 import bb.msg
 
-logger = bb.msg.logger_create('bitbake-diffsigs')
+myname = os.path.basename(sys.argv[0])
+logger = bb.msg.logger_create(myname)
+
+is_dump = myname == 'bitbake-dumpsig'
 
 def find_siginfo(tinfoil, pn, taskname, sigs=None):
     result = None
@@ -59,8 +61,8 @@ def find_siginfo(tinfoil, pn, taskname, sigs=None):
         sys.exit(2)
     return result
 
-def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None, color=False):
-    """ Find the most recent signature files for the specified PN/task and compare them """
+def find_siginfo_task(bbhandler, pn, taskname, sig1=None, sig2=None):
+    """ Find the most recent signature files for the specified PN/task """
 
     if not taskname.startswith('do_'):
         taskname = 'do_%s' % taskname
@@ -79,73 +81,81 @@ def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None, color=False
         latestfiles = [sigfiles[sig1], sigfiles[sig2]]
     else:
         filedates = find_siginfo(bbhandler, pn, taskname)
-        latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-3:]
+        latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-2:]
         if not latestfiles:
             logger.error('No sigdata files found matching %s %s' % (pn, taskname))
             sys.exit(1)
-        elif len(latestfiles) < 2:
-            logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (pn, taskname))
-            sys.exit(1)
 
-    # Define recursion callback
-    def recursecb(key, hash1, hash2):
-        hashes = [hash1, hash2]
-        hashfiles = find_siginfo(bbhandler, key, None, hashes)
-
-        recout = []
-        if len(hashfiles) == 0:
-            recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
-        elif not hash1 in hashfiles:
-            recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash1))
-        elif not hash2 in hashfiles:
-            recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
-        else:
-            out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb, color=color)
-            for change in out2:
-                for line in change.splitlines():
-                    recout.append('  ' + line)
+    return latestfiles
 
-        return recout
 
-    # Recurse into signature comparison
-    logger.debug("Signature file (previous): %s" % latestfiles[-2])
-    logger.debug("Signature file (latest): %s" % latestfiles[-1])
-    output = bb.siggen.compare_sigfiles(latestfiles[-2], latestfiles[-1], recursecb, color=color)
-    if output:
-        print('\n'.join(output))
-    sys.exit(0)
+# Define recursion callback
+def recursecb(key, hash1, hash2):
+    hashes = [hash1, hash2]
+    hashfiles = find_siginfo(tinfoil, key, None, hashes)
+
+    recout = []
+    if len(hashfiles) == 0:
+        recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
+    elif not hash1 in hashfiles:
+        recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash1))
+    elif not hash2 in hashfiles:
+        recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
+    else:
+        out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb, color=color)
+        for change in out2:
+            for line in change.splitlines():
+                recout.append('  ' + line)
 
+    return recout
 
 
 parser = argparse.ArgumentParser(
-    description="Compares siginfo/sigdata files written out by BitBake")
+    description=("Dumps" if is_dump else "Compares") + " siginfo/sigdata files written out by BitBake")
 
-parser.add_argument('-d', '--debug',
+parser.add_argument('-D', '--debug',
                     help='Enable debug output',
                     action='store_true')
 
-parser.add_argument('--color',
-        help='Colorize output (where %(metavar)s is %(choices)s)',
-        choices=['auto', 'always', 'never'], default='auto', metavar='color')
+if is_dump:
+    parser.add_argument("-t", "--task",
+            help="find the signature data file for the last run of the specified task",
+            action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
 
-parser.add_argument("-t", "--task",
-        help="find the signature data files for last two runs of the specified task and compare them",
-        action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
+    parser.add_argument("sigdatafile1",
+            help="Signature file to dump. Not used when using -t/--task.",
+            action="store", nargs='?', metavar="sigdatafile")
+else:
+    parser.add_argument('-c', '--color',
+            help='Colorize the output (where %(metavar)s is %(choices)s)',
+            choices=['auto', 'always', 'never'], default='auto', metavar='color')
+
+    parser.add_argument('-d', '--dump',
+            help='Dump the last signature data instead of comparing (equivalent to using bitbake-dumpsig)',
+            action='store_true')
 
-parser.add_argument("-s", "--signature",
-        help="With -t/--task, specify the signatures to look for instead of taking the last two",
-        action="store", dest="sigargs", nargs=2, metavar=('fromsig', 'tosig'))
+    parser.add_argument("-t", "--task",
+            help="find the signature data files for the last two runs of the specified task and compare them",
+            action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
 
-parser.add_argument("sigdatafile1",
-        help="First signature file to compare (or signature file to dump, if second not specified). Not used when using -t/--task.",
-        action="store", nargs='?')
+    parser.add_argument("-s", "--signature",
+            help="With -t/--task, specify the signatures to look for instead of taking the last two",
+            action="store", dest="sigargs", nargs=2, metavar=('fromsig', 'tosig'))
 
-parser.add_argument("sigdatafile2",
-        help="Second signature file to compare",
-        action="store", nargs='?')
+    parser.add_argument("sigdatafile1",
+            help="First signature file to compare (or signature file to dump, if second not specified). Not used when using -t/--task.",
+            action="store", nargs='?')
 
+    parser.add_argument("sigdatafile2",
+            help="Second signature file to compare",
+            action="store", nargs='?')
 
 options = parser.parse_args()
+if is_dump:
+    options.color = 'never'
+    options.dump = True
+    options.sigdatafile2 = None
+    options.sigargs = None
 
 if options.debug:
     logger.setLevel(logging.DEBUG)
@@ -155,16 +165,29 @@ color = (options.color == 'always' or (options.color == 'auto' and sys.stdout.is
 if options.taskargs:
     with bb.tinfoil.Tinfoil() as tinfoil:
         tinfoil.prepare(config_only=True)
-        if options.sigargs:
-            find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1], options.sigargs[0], options.sigargs[1], color=color)
+        if not options.dump and options.sigargs:
+            files = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1], options.sigargs[0], options.sigargs[1])
+        else:
+            files = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1])
+
+        if options.dump:
+            logger.debug("Signature file: %s" % files[-1])
+            output = bb.siggen.dump_sigfile(files[-1])
         else:
-            find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1], color=color)
+            if len(files) < 2:
+                logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (options.taskargs[0], options.taskargs[1]))
+                sys.exit(1)
+
+            # Recurse into signature comparison
+            logger.debug("Signature file (previous): %s" % files[-2])
+            logger.debug("Signature file (latest): %s" % files[-1])
+            output = bb.siggen.compare_sigfiles(files[-2], files[-1], recursecb, color=color)
 else:
     if options.sigargs:
         logger.error('-s/--signature can only be used together with -t/--task')
         sys.exit(1)
     try:
-        if options.sigdatafile1 and options.sigdatafile2:
+        if not options.dump and options.sigdatafile1 and options.sigdatafile2:
             output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2, color=color)
         elif options.sigdatafile1:
             output = bb.siggen.dump_sigfile(options.sigdatafile1)
@@ -179,5 +202,5 @@ else:
         logger.error('Invalid signature data - ensure you are specifying sigdata/siginfo files')
         sys.exit(1)
 
-    if output:
-        print('\n'.join(output))
+if output:
+    print('\n'.join(output))
diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
deleted file mode 100755
index 95ebd93546..0000000000
--- a/bitbake/bin/bitbake-dumpsig
+++ /dev/null
@@ -1,94 +0,0 @@
-#!/usr/bin/env python3
-
-# bitbake-dumpsig
-# BitBake task signature dump utility
-#
-# Copyright (C) 2013 Intel Corporation
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-import os
-import sys
-import warnings
-import optparse
-import logging
-import pickle
-
-sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
-
-import bb.tinfoil
-import bb.siggen
-import bb.msg
-
-logger = bb.msg.logger_create('bitbake-dumpsig')
-
-def find_siginfo_task(bbhandler, pn, taskname):
-    """ Find the most recent signature file for the specified PN/task """
-
-    if not hasattr(bb.siggen, 'find_siginfo'):
-        logger.error('Metadata does not support finding signature data files')
-        sys.exit(1)
-
-    if not taskname.startswith('do_'):
-        taskname = 'do_%s' % taskname
-
-    filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
-    latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-1:]
-    if not latestfiles:
-        logger.error('No sigdata files found matching %s %s' % (pn, taskname))
-        sys.exit(1)
-
-    return latestfiles[0]
-
-parser = optparse.OptionParser(
-    description = "Dumps siginfo/sigdata files written out by BitBake",
-    usage = """
-  %prog -t recipename taskname
-  %prog sigdatafile""")
-
-parser.add_option("-D", "--debug",
-        help = "enable debug",
-        action = "store_true", dest="debug", default = False)
-
-parser.add_option("-t", "--task",
-        help = "find the signature data file for the specified task",
-        action="store", dest="taskargs", nargs=2, metavar='recipename taskname')
-
-options, args = parser.parse_args(sys.argv)
-
-if options.debug:
-    logger.setLevel(logging.DEBUG)
-
-if options.taskargs:
-    tinfoil = bb.tinfoil.Tinfoil()
-    tinfoil.prepare(config_only = True)
-    file = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1])
-    logger.debug("Signature file: %s" % file)
-elif len(args) == 1:
-    parser.print_help()
-    sys.exit(0)
-else:
-    file = args[1]
-
-try:
-    output = bb.siggen.dump_sigfile(file)
-except IOError as e:
-    logger.error(str(e))
-    sys.exit(1)
-except (pickle.UnpicklingError, EOFError):
-    logger.error('Invalid signature data - ensure you are specifying a sigdata/siginfo file')
-    sys.exit(1)
-
-if output:
-    print('\n'.join(output))
diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
new file mode 120000
index 0000000000..b1e8489b45
--- /dev/null
+++ b/bitbake/bin/bitbake-dumpsig
@@ -0,0 +1 @@
+bitbake-diffsigs
\ No newline at end of file
-- 
2.12.0


