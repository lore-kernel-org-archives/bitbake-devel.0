Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7D0577727C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:49:48 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2016 16:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; d="scan'208";a="751272727"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:49:47 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 18:51:52 -0600
Message-Id: <1456188718-13755-3-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
Subject: [[RFC][PATCH] 2/8] toaster/tests: Add __init__.py and base.py.
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
X-List-Received-Date: Tue, 23 Feb 2016 00:49:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add empty __init__.py for set folder as module.

Add base.py module that contains a base class for toaster test
cases now have an object with options and a logger.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/toaster/tests/__init__.py |  0
 lib/toaster/tests/base.py     | 11 +++++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 lib/toaster/tests/__init__.py
 create mode 100644 lib/toaster/tests/base.py

diff --git a/lib/toaster/tests/__init__.py b/lib/toaster/tests/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/tests/base.py b/lib/toaster/tests/base.py
new file mode 100644
index 0000000..8b303ac
--- /dev/null
+++ b/lib/toaster/tests/base.py
@@ -0,0 +1,11 @@
+import unittest
+
+class ToasterOptions(object): 
+    pass
+
+class ToasterTestCase(unittest.TestCase):
+    def __init__(self, testname, opts, logger):
+        super(ToasterTestCase, self).__init__(testname)
+
+        self.opts = opts
+        self.logger = logger
-- 
2.1.4


