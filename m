Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7E72D6CC2D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 16:44:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Oct 2013 09:44:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1034,1371106800"; d="scan'208";a="414098043"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.164])
	by orsmga002.jf.intel.com with ESMTP; 04 Oct 2013 09:44:37 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Oct 2013 17:44:27 +0100
Message-Id: <4a967dd0e35a031a6cad58b1da10fe2cd35fcfa4.1380904913.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] bitbake-diffsigs: improve error handling
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
X-List-Received-Date: Fri, 04 Oct 2013 16:44:38 -0000

* Set up a logger independent of BitBake so we can log errors ourselves
* Handle common errors without printing a traceback

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-diffsigs | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 6f24981..53b47e0 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -3,7 +3,7 @@
 # bitbake-diffsigs
 # BitBake task signature data comparison utility
 #
-# Copyright (C) 2012 Intel Corporation
+# Copyright (C) 2013 Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -30,7 +30,18 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), '
 import bb.tinfoil
 import bb.siggen
 
-logger = logging.getLogger('BitBake')
+def logger_create(name, output=sys.stderr):
+    logger = logging.getLogger(name)
+    console = logging.StreamHandler(output)
+    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+    if output.isatty():
+        format.enable_color()
+    console.setFormatter(format)
+    logger.addHandler(console)
+    logger.setLevel(logging.INFO)
+    return logger
+
+logger = logger_create('bitbake-diffsigs')
 
 def find_compare_task(bbhandler, pn, taskname):
     """ Find the most recent signature files for the specified PN/task and compare them """
@@ -94,10 +105,19 @@ if options.taskargs:
 else:
     if len(args) == 1:
         parser.print_help()
-    elif len(args) == 2:
-        output = bb.siggen.dump_sigfile(sys.argv[1])
     else:
-        output = bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
+        import cPickle
+        try:
+            if len(args) == 2:
+                output = bb.siggen.dump_sigfile(sys.argv[1])
+            else:
+                output = bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
+        except IOError as e:
+            logger.error(str(e))
+            sys.exit(1)
+        except cPickle.UnpicklingError, EOFError:
+            logger.error('Invalid signature data - ensure you are specifying sigdata/siginfo files')
+            sys.exit(1)
 
     if output:
         print '\n'.join(output)
-- 
1.8.1.2


