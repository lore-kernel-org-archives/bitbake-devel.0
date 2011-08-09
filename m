Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qqb2T-0003xC-GW
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 03:23:25 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 08 Aug 2011 18:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,340,1309762800"; d="scan'208";a="36498555"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.247])
	by azsmga001.ch.intel.com with ESMTP; 08 Aug 2011 18:18:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Aug 2011 18:18:29 -0700
Message-Id: <46953d3b4595667935d43fe7b20264ae0efd1bdf.1312852599.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312852599.git.josh@linux.intel.com>
References: <cover.1312852599.git.josh@linux.intel.com>
In-Reply-To: <cover.1312852599.git.josh@linux.intel.com>
References: <cover.1312852599.git.josh@linux.intel.com>
Subject: [PATCH 2/4] bb/ui/hob: move some code around to avert a race
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
X-List-Received-Date: Tue, 09 Aug 2011 01:23:25 -0000

The data-generated and model-updated signals are different, the model
should only be accessed *after* the model-updated signal. Move code
setting the image combo's backing model to the model-updated callback to
ensure the combo is accurately set when changing the machine with an
image selected.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 5906251..e042765 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -183,13 +183,6 @@ class MainWindow (gtk.Window):
 
     def data_generated(self, handler):
         self.generating = False
-        self.image_combo.set_model(self.model.images_model())
-        # Without this the image combo is incorrectly sized on first load of the GUI
-        self.image_combo.set_active(0)
-        self.image_combo.set_active(-1)
-
-        if not self.image_combo_id:
-            self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
         self.enable_widgets()
 
     def machine_combo_changed_cb(self, combo, handler):
@@ -286,6 +279,14 @@ class MainWindow (gtk.Window):
         pkgsaz_model.set_default_sort_func(None)
         self.pkgsaz_tree.set_model(pkgsaz_model)
 
+        self.image_combo.set_model(self.model.images_model())
+        # Without this the image combo is incorrectly sized on first load of the GUI
+        self.image_combo.set_active(0)
+        self.image_combo.set_active(-1)
+
+        if not self.image_combo_id:
+            self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
+
         # We want the contents to be alphabetised so create a TreeModelSort to
         # use in the view
         contents_model = gtk.TreeModelSort(self.model.contents_model())
-- 
1.7.6



