Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 83E7E78686
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Mar 2018 06:27:20 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Mar 2018 23:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000"; d="scan'208";a="24988781"
Received: from peggleto-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.png.intel.com) ([172.30.199.135])
	by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2018 23:27:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2018 14:27:17 +0800
Message-Id: <feb16eeb613d795b8cceaa52e5a1b82c7c52578a.1521181617.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1521181617.git.paul.eggleton@linux.intel.com>
References: <cover.1521181617.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] cooker: remove old bitbake shell reference
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
X-List-Received-Date: Fri, 16 Mar 2018 06:27:20 -0000

The bitbake shell functionality was disabled and removed in 2010
(bitbake revision 24857e2ceb405916b0b0b3e75c6c2375a909b9ba) as it was
broken at that time, and things have moved on even further since then.
The bitbake server can remain memory resident now so some of the reason
for its existence has been removed. If we were to want to re-implement
it then I would imagine we would do so using the devpyshell rather than
building upon this, so remove the last reference to it here.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1fda40dd..062013a8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1051,17 +1051,6 @@ class BBCooker:
         tree = self.generatePkgDepTreeData(pkgs, 'build')
         bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.data)
 
-    def interactiveMode( self ):
-        """Drop off into a shell"""
-        try:
-            from bb import shell
-        except ImportError:
-            parselog.exception("Interactive mode not available")
-            sys.exit(1)
-        else:
-            shell.start( self )
-
-
     def handleCollections(self, collections):
         """Handle collections"""
         errors = False
-- 
2.14.3


