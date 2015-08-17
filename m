Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 90A81767EA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:39 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564786"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:39 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:20 +0100
Message-Id: <51bd12738020e06471201d73267a3f618aa29e84.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 05/13] cooker: ensure prefile/postfile can work in memory resident mode
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:39 -0000

The prefile/postfile options weren't working in memory resident mode
because they weren't being passed through to the server, so ensure that
they do get passed through and that the server is reset when the values
come through.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py     | 4 +++-
 lib/bb/cookerdata.py | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fb38289..a2b0bb5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -527,9 +527,11 @@ class BBCooker:
         self.handleCollections( self.data.getVar("BBFILE_COLLECTIONS", True) )
 
     def updateConfigOpts(self, options, environment):
+        clean = True
         for o in options:
+            if o in ['prefile', 'postfile']:
+                clean = False
             setattr(self.configuration, o, options[o])
-        clean = True
         for k in bb.utils.approved_variables():
             if k in environment and k not in self.configuration.env:
                 logger.debug(1, "Updating environment variable %s to %s" % (k, environment[k]))
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 57fc6bb..b20040c 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -73,7 +73,8 @@ class ConfigParameters(object):
         options = {}
         for o in ["abort", "tryaltconfigs", "force", "invalidate_stamp", 
                   "verbose", "debug", "dry_run", "dump_signatures", 
-                  "debug_domains", "extra_assume_provided", "profile"]:
+                  "debug_domains", "extra_assume_provided", "profile",
+                  "prefile", "postfile"]:
             options[o] = getattr(self.options, o)
 
         ret, error = server.runCommand(["updateConfig", options, environment])
-- 
2.1.0


