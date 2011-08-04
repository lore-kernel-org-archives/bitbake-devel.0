Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qomj7-0000xL-2B
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 03:27:57 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Aug 2011 18:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,313,1309762800"; d="scan'208";a="34155898"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.173])
	by orsmga002.jf.intel.com with ESMTP; 03 Aug 2011 18:23:29 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Aug 2011 18:23:21 -0700
Message-Id: <bb2609ba00db11b445e0af1921744b725fe96065.1312420894.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
Subject: [PATCH 5/6] bb/ui/hob: only connect to the changed signal of image_combo once
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 04 Aug 2011 01:27:57 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index b8842a9..5a4ac78 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -158,7 +158,8 @@ class MainWindow (gtk.Window):
             it = self.model.images.iter_next(it)
             cnt = cnt + 1
         # Reconnect the signal handler
-        self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
+        if not self.image_combo_id:
+            self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
 
     def image_changed_cb(self, combo):
         model = self.image_combo.get_model()
@@ -321,11 +322,13 @@ class MainWindow (gtk.Window):
         return
 
     def reset_build(self):
-        self.image_combo.disconnect(self.image_combo_id)
-        self.image_combo_id = None
+        if self.image_combo_id:
+            self.image_combo.disconnect(self.image_combo_id)
+            self.image_combo_id = None
         self.image_combo.set_active(-1)
-        self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
         self.model.reset()
+        if not self.image_combo_id:
+            self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
 
     def layers_cb(self, action):
         resp = self.layers.run()
-- 
1.7.6



