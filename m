Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 54BF6731A0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Dec 2015 18:39:10 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 31 Dec 2015 10:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,504,1444719600"; d="scan'208";a="626313094"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Dec 2015 10:39:12 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id A10326A4087;
	Thu, 31 Dec 2015 11:27:09 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Dec 2015 18:42:13 +0200
Message-Id: <1451580136-29714-2-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1451580136-29714-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1451580136-29714-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 1/4] cooker: add state.get_name method
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
X-List-Received-Date: Thu, 31 Dec 2015 18:39:10 -0000

Added method to convert state code into the human readable name.
It will be used in logging and error reporting.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4df8881..1d83226 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -67,6 +67,14 @@ class CollectionError(bb.BBHandledException):
 class state:
     initial, parsing, running, shutdown, forceshutdown, stopped, error = range(7)
 
+    @classmethod
+    def get_name(cls, code):
+        for name in dir(cls):
+            value = getattr(cls, name)
+            if type(value) == type(cls.initial) and value == code:
+                return name
+        raise ValueError("Invalid status code: %s" % code)
+
 
 class SkippedPackage:
     def __init__(self, info = None, reason = None):
-- 
2.1.4


