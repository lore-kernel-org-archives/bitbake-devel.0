Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id DF2B26D77B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 11:25:40 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 29 Nov 2013 03:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,797,1378882800"; d="scan'208";a="436056038"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2013 03:25:29 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 29 Nov 2013 13:31:22 +0200
Message-Id: <1385724682-2289-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: btibake server must reparse the conf between builds
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
X-List-Received-Date: Fri, 29 Nov 2013 11:25:41 -0000

When the UI event handlers are registered, the cooker reset is
triggered. In this way it doesn't affect the cooker state.

[YOCTO #5535]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/server/xmlrpc.py |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 82c0e8d..fb7a8b4 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -103,8 +103,9 @@ class BitBakeServerCommands():
         for f in featureset:
             self.cooker.featureset.setFeature(f)
 
-        if (original_featureset != list(self.cooker.featureset)):
-            self.cooker.reset()
+        #always reset the cooker when a remote UI Event Handler is registered,
+        #in order to reparse the configuration files
+        self.cooker.reset()
 
         self.event_handle = bb.event.register_UIHhandler(s)
         return self.event_handle
-- 
1.7.9.5


