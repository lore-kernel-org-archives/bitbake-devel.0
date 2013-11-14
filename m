Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id ADBFC6D732
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2013 14:58:24 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 14 Nov 2013 06:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="408803449"
Received: from pmcgurk-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.121.79])
	by orsmga001.jf.intel.com with ESMTP; 14 Nov 2013 06:58:25 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Nov 2013 14:57:54 +0000
Message-Id: <1384441074-31284-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] cooker: warn if user specifies a target listed in ASSUME_PROVIDED
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
X-List-Received-Date: Thu, 14 Nov 2013 14:58:25 -0000

If the user explicitly asks to build a target that is listed in the
value of ASSUME_PROVIDED, show a warning mentioning that it will be
ignored.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0580cd5..267d19e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1268,6 +1268,11 @@ class BBCooker:
         if len(pkgs_to_build) == 0:
             raise NothingToBuild
 
+        ignore = (self.data.getVar("ASSUME_PROVIDED", True) or "").split()
+        for pkg in pkgs_to_build:
+            if pkg in ignore:
+                parselog.warn("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
+
         if 'world' in pkgs_to_build:
             self.buildWorldTargetList()
             pkgs_to_build.remove('world')
-- 
1.8.1.2


