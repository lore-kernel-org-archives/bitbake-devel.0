Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 18FA877174
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 19:33:17 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 04 Feb 2016 11:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,396,1449561600"; d="scan'208";a="908693203"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2016 11:33:18 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 31F5A6A4002;
	Thu,  4 Feb 2016 12:21:09 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  4 Feb 2016 19:23:39 +0200
Message-Id: <1454606619-23406-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] cooker: shutdown cooker parser on shutdown
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
X-List-Received-Date: Thu, 04 Feb 2016 19:33:18 -0000

Currently any not catched exception in cooker causes bitbake
to hang because of not terminated children of CookerParser.

Long term solution would be to reimplement Cooker as a context
manager and terminate parser children in its __exit__ method.

Partial fix is to call CookerParser.shutdown in Cooker.shutdown in
hope that all Cooker exceptions are caught and shutdown method is
called.

[YOCTO #8900]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index edd682b..df730f6 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1635,6 +1635,9 @@ class BBCooker:
         else:
             self.state = state.shutdown
 
+        if self.parser:
+            self.parser.shutdown(clean=not force, force=force)
+
     def finishcommand(self):
         self.state = state.initial
 
-- 
2.1.4


