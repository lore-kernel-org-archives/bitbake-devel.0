Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 55E9071B38
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:39 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961430"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:37 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:05 +1300
Message-Id: <fdc1626a83d04276ec6eae42abc3806605602ca4.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 06/15] command: provide a means to shut down from the client in memres mode
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:39 -0000

In memory resident mode we don't really want to actually shut down since
it's only the client going away.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py    | 8 ++++++++
 lib/bb/cooker.py     | 7 +++++++
 lib/bb/cookerdata.py | 1 +
 3 files changed, 16 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index caa3e4d..012b35f 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -472,3 +472,11 @@ class CommandsAsync:
         command.finishAsyncCommand()
     resetCooker.needcache = False
 
+    def clientComplete(self, command, params):
+        """
+        Do the right thing when the controlling client exits
+        """
+        command.cooker.clientComplete()
+        command.finishAsyncCommand()
+    clientComplete.needcache = False
+
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5e5708e..2614c44 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1725,6 +1725,13 @@ class BBCooker:
     def reset(self):
         self.initConfigurationData()
 
+    def clientComplete(self):
+        """Called when the client is done using the server"""
+        if self.configuration.server_only:
+            self.finishcommand()
+        else:
+            self.shutdown(True)
+
     def lockBitbake(self):
         if not hasattr(self, 'lock'):
             self.lock = None
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 320bb59..c6e958b 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -146,6 +146,7 @@ class CookerConfiguration(object):
         self.tracking = False
         self.interface = []
         self.writeeventlog = False
+        self.server_only = False
 
         self.env = {}
 
-- 
2.5.5


