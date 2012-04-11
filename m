Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <sgw@linux.intel.com>) id 1SHm2B-0002Uj-5g
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 03:07:43 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 10 Apr 2012 17:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="87608457"
Received: from unknown (HELO swold-mobl.bigsur.com) ([10.255.12.159])
	by AZSMGA002.ch.intel.com with ESMTP; 10 Apr 2012 17:57:08 -0700
From: Saul Wold <sgw@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Apr 2012 17:57:08 -0700
Message-Id: <1334105828-386-1-git-send-email-sgw@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 1/2] ui/crumbs/utils.py: new file for choosing terminals
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 11 Apr 2012 01:07:43 -0000

Adding this simple version of a terminal selector for use
hob since it's needed. Moving forward in the 1.3 release
the existing code in meta/lib/oe/termnial.py will be migrated
to core bitbake code and this will use that code.

Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 lib/bb/ui/crumbs/utils.py |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/utils.py

diff --git a/lib/bb/ui/crumbs/utils.py b/lib/bb/ui/crumbs/utils.py
new file mode 100644
index 0000000..cd01a04
--- /dev/null
+++ b/lib/bb/ui/crumbs/utils.py
@@ -0,0 +1,33 @@
+#
+# BitBake UI Utils 
+#
+# Copyright (C) 2012 Intel Corporation
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
+# This utility method looks for xterm or vte and return the 
+# frist to exist, currently we are keeping this simple, but 
+# we will likely move the oe.terminal implementation into 
+# bitbake which will allow more flexibility.
+
+import os
+
+def which_terminal():
+    term = bb.utils.which(os.environ["PATH"], "xterm")
+    if term:
+        return term + " -e "
+    term = bb.utils.which(os.environ["PATH"], "vte")
+    if term:
+        return term + " -c "
+    return None
-- 
1.7.5.4



