Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 46DD87814B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 09:03:53 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Sep 2017 02:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,474,1498546800"; d="scan'208";a="1191290670"
Received: from nabmajid-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.129.136])
	by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2017 02:03:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Sep 2017 21:03:11 +1200
Message-Id: <0a90099ead0da210757f2a585f626a0a144c6fe1.1504515728.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1504515728.git.paul.eggleton@linux.intel.com>
References: <cover.1504515728.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] cooker: clear extra config settings and remote datastores on client disconnect
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
X-List-Received-Date: Mon, 04 Sep 2017 09:03:53 -0000

When the UI disconnects, we can throw away any server-side remote
datastores we created in response to calls from the UI, and we *must*
drop everything in extraconfigdata or it will taint any future
operations.

Dropping extraconfigdata upon disconnect fixes taskhash mismatch errors
when running devtool.DevtoolTests.test_devtool_update_recipe_local_files
within oe-selftest with BB_SERVER_TIMEOUT=100 in OpenEmbedded.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py | 3 +++
 lib/bb/cooker.py  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 0d0354c..67cc5ce 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -145,6 +145,9 @@ class Command:
         self.currentAsyncCommand = None
         self.cooker.finishcommand()
 
+    def reset(self):
+        self.remotedatastores = bb.remotedata.RemoteDatastores(cooker)
+
 def split_mc_pn(pn):
     if pn.startswith("multiconfig:"):
         _, mc, pn = pn.split(":", 2)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f5ae831..10cb8be 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1616,6 +1616,8 @@ class BBCooker:
     def clientComplete(self):
         """Called when the client is done using the server"""
         self.finishcommand()
+        self.extraconfigdata = {}
+        self.command.reset()
         self.databuilder.reset()
         self.data = self.databuilder.data
 
-- 
2.9.5


