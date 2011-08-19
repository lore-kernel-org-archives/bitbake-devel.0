Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeH-0005Bu-0w
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:28 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058953"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:25 -0700
Message-Id: <5ef78e4b67c32305dab6acd0597f1fd2582d92b7.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 11/11] bb/ui/hob: warn and prevent image build if no IMAGE_FSTYPE is set
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
X-List-Received-Date: Fri, 19 Aug 2011 01:13:29 -0000

If IMAGE_FSTYPE is empty and the user has opted to build an image warn
them and prevent the build.

Fixes [YOCTO #1267]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index e02f48c..105b0ef 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -437,7 +437,22 @@ class MainWindow (gtk.Window):
             elif response == gtk.RESPONSE_OK:
                 rep.base_image = "empty"
 
-        if build_image:
+        # Ensure at least one value is set in IMAGE_FSTYPES.
+        have_selected_fstype = False
+        if (len(self.prefs.selected_image_types) and
+            len(self.prefs.selected_image_types[0])):
+            have_selected_fstype = True
+
+        if build_image and not have_selected_fstype:
+            lbl = "<b>No image output type selected</b>\nThere is no image output"
+            lbl = lbl + " selected for the build. Please set an output image type"
+            lbl = lbl + " in the preferences (Edit -> Preferences)."
+            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            dialog.run()
+            dialog.destroy()
+            return
+        elif build_image:
             self.handler.make_temp_dir()
             recipepath =  self.handler.get_temp_recipe_path(rep.base_image)
             image_name = recipepath.rstrip(".bb")
-- 
1.7.6



