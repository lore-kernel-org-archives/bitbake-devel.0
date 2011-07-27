Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlvJe-0007hu-Er
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:01:50 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Jul 2011 20:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="34904869"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2011 20:57:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 20:57:25 -0700
Message-Id: <58036a79cb79d1dff307e2cfed0e684493178507.1311738866.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
Subject: [PATCH 2/4] hob: fix loading customised image recipe
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
X-List-Received-Date: Wed, 27 Jul 2011 04:01:50 -0000

The signal handler of the 'Base image' combo was still connected during load
such that updating the UI to reflect the loaded base image triggered a change
of the model. Fix this by disconnecting the signal handler when updating the
displayed 'Base image'.

Fixes [YOCTO #1282]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/tasklistmodel.py |    2 +-
 lib/bb/ui/hob.py                  |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index d7dff3c..e190f96 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -281,7 +281,7 @@ class TaskListModel(gtk.ListStore):
             path = self.get_path(it)
             name = self[path][self.COL_NAME]
             if name in packages:
-                self.include_item(path)
+                self.include_item(path, binb="User Selected")
                 packages.remove(name)
             it = self.iter_next(it)
 
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index d3442c5..90d5c5a 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -122,6 +122,10 @@ class MainWindow (gtk.Window):
         self.build_succeeded = False
 
     def image_changed_string_cb(self, model, new_image):
+        # disconnect the image combo's signal handler
+        if self.image_combo_id:
+            self.image_combo.disconnect(self.image_combo_id)
+            self.image_combo_id = None
         cnt = 0
         it = self.model.images.get_iter_first()
         while it:
@@ -131,6 +135,8 @@ class MainWindow (gtk.Window):
                 break
             it = self.model.images.iter_next(it)
             cnt = cnt + 1
+        # Reconnect the signal handler
+        self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
 
     def image_changed_cb(self, combo):
         model = self.image_combo.get_model()
-- 
1.7.6



