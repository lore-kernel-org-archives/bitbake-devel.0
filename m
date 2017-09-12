Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 03063783FF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Sep 2017 10:11:26 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga104.jf.intel.com with ESMTP; 12 Sep 2017 03:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,382,1500966000"; d="scan'208";a="127916113"
Received: from nrahulx-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.73.25])
	by orsmga004.jf.intel.com with ESMTP; 12 Sep 2017 03:11:14 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Sep 2017 22:10:34 +1200
Message-Id: <2d7f1ec85c8242b1348597e7963b962efe562070.1505210965.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1505210965.git.paul.eggleton@linux.intel.com>
References: <cover.1505210965.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] command: Add command to invalidate parse cache
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
X-List-Received-Date: Tue, 12 Sep 2017 10:11:27 -0000

If we make a change to the metadata within a tinfoil-using script
and then attempt to run tasks using build_targets(), the change won't
get noticed. Add an explicit command that will set the internal flag to
force reloading the cache and thus pick up the changes. This will be
used in OE by the devtool source extraction rework.

Part of the fix for [YOCTO #11198].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 6c966e3..c3717ab 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -574,6 +574,9 @@ class CommandsSync:
         return DataStoreConnectionHandle(idx)
     parseRecipeFile.readonly = True
 
+    def invalidateParseCache(self, command, params):
+        command.cooker.parsecache_valid = False
+
 class CommandsAsync:
     """
     A class of asynchronous commands
-- 
2.9.5


