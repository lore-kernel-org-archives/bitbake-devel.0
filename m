Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id CE49A77CFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:53:02 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565887"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:53:02 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:07 +1200
Message-Id: <e84f63c691c8dba6b0bb31a072f02507fe2111a7.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 07/11] bitbake-diffsigs: change to use argparse
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
X-List-Received-Date: Thu, 06 Apr 2017 21:53:03 -0000

Argparse is a bit easier to deal with than optparse, and since we're
about to add some options, migrate this script over.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs | 64 +++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 4ca085f..e3f848d 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -3,7 +3,7 @@
 # bitbake-diffsigs
 # BitBake task signature data comparison utility
 #
-# Copyright (C) 2012-2013 Intel Corporation
+# Copyright (C) 2012-2013, 2017 Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -22,7 +22,7 @@ import os
 import sys
 import warnings
 import fnmatch
-import optparse
+import argparse
 import logging
 import pickle
 
@@ -83,22 +83,27 @@ def find_compare_task(bbhandler, pn, taskname):
 
 
 
-parser = optparse.OptionParser(
-    description = "Compares siginfo/sigdata files written out by BitBake",
-    usage = """
-  %prog -t recipename taskname
-  %prog sigdatafile1 sigdatafile2
-  %prog sigdatafile1""")
+parser = argparse.ArgumentParser(
+    description="Compares siginfo/sigdata files written out by BitBake")
 
-parser.add_option("-D", "--debug",
-        help = "enable debug",
-        action = "store_true", dest="debug", default = False)
+parser.add_argument('-d', '--debug',
+                    help='Enable debug output',
+                    action='store_true')
 
-parser.add_option("-t", "--task",
-        help = "find the signature data files for last two runs of the specified task and compare them",
-        action="store", dest="taskargs", nargs=2, metavar='recipename taskname')
+parser.add_argument("-t", "--task",
+        help="find the signature data files for last two runs of the specified task and compare them",
+        action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
 
-options, args = parser.parse_args(sys.argv)
+parser.add_argument("sigdatafile1",
+        help="First signature file to compare (or signature file to dump, if second not specified). Not used when using -t/--task.",
+        action="store", nargs='?')
+
+parser.add_argument("sigdatafile2",
+        help="Second signature file to compare",
+        action="store", nargs='?')
+
+
+options = parser.parse_args()
 
 if options.debug:
     logger.setLevel(logging.DEBUG)
@@ -108,20 +113,17 @@ if options.taskargs:
         tinfoil.prepare(config_only=True)
         find_compare_task(tinfoil, options.taskargs[0], options.taskargs[1])
 else:
-    if len(args) == 1:
-        parser.print_help()
-    else:
-        try:
-            if len(args) == 2:
-                output = bb.siggen.dump_sigfile(sys.argv[1])
-            else:
-                output = bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
-        except IOError as e:
-            logger.error(str(e))
-            sys.exit(1)
-        except (pickle.UnpicklingError, EOFError):
-            logger.error('Invalid signature data - ensure you are specifying sigdata/siginfo files')
-            sys.exit(1)
+    try:
+        if options.sigdatafile1 and options.sigdatafile2:
+            output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2)
+        elif options.sigdatafile1:
+            output = bb.siggen.dump_sigfile(options.sigdatafile1)
+    except IOError as e:
+        logger.error(str(e))
+        sys.exit(1)
+    except (pickle.UnpicklingError, EOFError):
+        logger.error('Invalid signature data - ensure you are specifying sigdata/siginfo files')
+        sys.exit(1)
 
-        if output:
-            print('\n'.join(output))
+    if output:
+        print('\n'.join(output))
-- 
2.9.3


