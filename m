Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 7310977CFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:53:05 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565900"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:53:04 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:08 +1200
Message-Id: <17683602646dedb754aa381fc522d4daced93881.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 08/11] bitbake-diffsigs: add an option to find and compare specific signatures
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
X-List-Received-Date: Thu, 06 Apr 2017 21:53:05 -0000

With the -t option which recurses to find the ultimate cause of a
signature change, it was hardcoded to take the last two executions of
the specified task. On the other hand, if you have two specific task
hashes (say from bitbake output, or some other tool) then you'll want to
pick those, so provide an option to specify those as well. (Note, the
new -s option needs to be specified alongside -t rather than instead of
it.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs | 95 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 36 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index e3f848d..e9fdb48 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -34,7 +34,7 @@ import bb.msg
 
 logger = bb.msg.logger_create('bitbake-diffsigs')
 
-def find_compare_task(bbhandler, pn, taskname):
+def find_compare_task(bbhandler, pn, taskname, sig1=None, sig2=None):
     """ Find the most recent signature files for the specified PN/task and compare them """
 
     if not hasattr(bb.siggen, 'find_siginfo'):
@@ -44,41 +44,54 @@ def find_compare_task(bbhandler, pn, taskname):
     if not taskname.startswith('do_'):
         taskname = 'do_%s' % taskname
 
-    filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
-    latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-3:]
-    if not latestfiles:
-        logger.error('No sigdata files found matching %s %s' % (pn, taskname))
-        sys.exit(1)
-    elif len(latestfiles) < 2:
-        logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (pn, taskname))
-        sys.exit(1)
+    if sig1 and sig2:
+        sigfiles = bb.siggen.find_siginfo(pn, taskname, [sig1, sig2], bbhandler.config_data)
+        if len(sigfiles) == 0:
+            logger.error('No sigdata files found matching %s %s matching either %s or %s' % (pn, taskname, sig1, sig2))
+            sys.exit(1)
+        elif not sig1 in sigfiles:
+            logger.error('No sigdata files found matching %s %s with signature %s' % (pn, taskname, sig1))
+            sys.exit(1)
+        elif not sig2 in sigfiles:
+            logger.error('No sigdata files found matching %s %s with signature %s' % (pn, taskname, sig2))
+            sys.exit(1)
+        latestfiles = [sigfiles[sig1], sigfiles[sig2]]
     else:
-        # Define recursion callback
-        def recursecb(key, hash1, hash2):
-            hashes = [hash1, hash2]
-            hashfiles = bb.siggen.find_siginfo(key, None, hashes, bbhandler.config_data)
-
-            recout = []
-            if len(hashfiles) == 0:
-                recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
-            elif not hash1 in hashfiles:
-                recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash1))
-            elif not hash2 in hashfiles:
-                recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
-            else:
-                out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb)
-                for change in out2:
-                    for line in change.splitlines():
-                        recout.append('  ' + line)
-
-            return recout
-
-        # Recurse into signature comparison
-        logger.debug("Signature file (previous): %s" % latestfiles[-2])
-        logger.debug("Signature file (latest): %s" % latestfiles[-1])
-        output = bb.siggen.compare_sigfiles(latestfiles[-2], latestfiles[-1], recursecb)
-        if output:
-            print('\n'.join(output))
+        filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
+        latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-3:]
+        if not latestfiles:
+            logger.error('No sigdata files found matching %s %s' % (pn, taskname))
+            sys.exit(1)
+        elif len(latestfiles) < 2:
+            logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (pn, taskname))
+            sys.exit(1)
+
+    # Define recursion callback
+    def recursecb(key, hash1, hash2):
+        hashes = [hash1, hash2]
+        hashfiles = bb.siggen.find_siginfo(key, None, hashes, bbhandler.config_data)
+
+        recout = []
+        if len(hashfiles) == 0:
+            recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
+        elif not hash1 in hashfiles:
+            recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash1))
+        elif not hash2 in hashfiles:
+            recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
+        else:
+            out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb)
+            for change in out2:
+                for line in change.splitlines():
+                    recout.append('  ' + line)
+
+        return recout
+
+    # Recurse into signature comparison
+    logger.debug("Signature file (previous): %s" % latestfiles[-2])
+    logger.debug("Signature file (latest): %s" % latestfiles[-1])
+    output = bb.siggen.compare_sigfiles(latestfiles[-2], latestfiles[-1], recursecb)
+    if output:
+        print('\n'.join(output))
     sys.exit(0)
 
 
@@ -94,6 +107,10 @@ parser.add_argument("-t", "--task",
         help="find the signature data files for last two runs of the specified task and compare them",
         action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
 
+parser.add_argument("-s", "--signature",
+        help="With -t/--task, specify the signatures to look for instead of taking the last two",
+        action="store", dest="sigargs", nargs=2, metavar=('fromsig', 'tosig'))
+
 parser.add_argument("sigdatafile1",
         help="First signature file to compare (or signature file to dump, if second not specified). Not used when using -t/--task.",
         action="store", nargs='?')
@@ -111,8 +128,14 @@ if options.debug:
 if options.taskargs:
     with bb.tinfoil.Tinfoil() as tinfoil:
         tinfoil.prepare(config_only=True)
-        find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1])
+        if options.sigargs:
+            find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1], options.sigargs[0], options.sigargs[1])
+        else:
+            find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1])
 else:
+    if options.sigargs:
+        logger.error('-s/--signature can only be used together with -t/--task')
+        sys.exit(1)
     try:
         if options.sigdatafile1 and options.sigdatafile2:
             output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2)
-- 
2.9.3


