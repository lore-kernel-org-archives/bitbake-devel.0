Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 872E76CC31
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 16:44:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Oct 2013 09:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1034,1371106800"; d="scan'208";a="414098048"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.164])
	by orsmga002.jf.intel.com with ESMTP; 04 Oct 2013 09:44:38 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Oct 2013 17:44:28 +0100
Message-Id: <174d71307b53062ec286033130bf3069f0eb2106.1380904913.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] bitbake-dumpsig: introduce command line and error handling
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

This utility doesn't take any special arguments, but it's nice if it at
least knows how to deal with no arguments, --help and errors properly.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-dumpsig | 60 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
index ccbc412..656d93a 100755
--- a/bitbake/bin/bitbake-dumpsig
+++ b/bitbake/bin/bitbake-dumpsig
@@ -1,11 +1,65 @@
 #!/usr/bin/env python
+
+# bitbake-dumpsig
+# BitBake task signature dump utility
+#
+# Copyright (C) 2013 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
 import os
 import sys
 import warnings
+import optparse
+import logging
+
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
 import bb.siggen
 
-output = bb.siggen.dump_sigfile(sys.argv[1])
-if output:
-    print '\n'.join(output)
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
+logger = logger_create('bitbake-dumpsig')
+
+parser = optparse.OptionParser(
+    description = "Dumps siginfo/sigdata files written out by BitBake",
+    usage = """
+  %prog sigdatafile""")
+
+options, args = parser.parse_args(sys.argv)
+
+if len(args) == 1:
+    parser.print_help()
+else:
+    import cPickle
+    try:
+        output = bb.siggen.dump_sigfile(args[1])
+    except IOError as e:
+        logger.error(str(e))
+        sys.exit(1)
+    except cPickle.UnpicklingError, EOFError:
+        logger.error('Invalid signature data - ensure you are specifying a sigdata/siginfo file')
+        sys.exit(1)
+
+    if output:
+        print '\n'.join(output)
-- 
1.8.1.2


