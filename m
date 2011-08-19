Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeF-0005Bu-6q
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:23 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058935"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:39 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:20 -0700
Message-Id: <73c48a9f07e44fc8b00599af82cbe9341586d2a2.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 06/11] hob: don't try and build if user selects Bake with no selections made
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
X-List-Received-Date: Fri, 19 Aug 2011 01:13:23 -0000

If the user hasn't made any selections inform them that they need to do so
before clicking Bake.

Fixes [YOCTO #1384]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index b0a98cb..0230dda 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -405,7 +405,19 @@ class MainWindow (gtk.Window):
         build_image = True
 
         rep = self.model.get_build_rep()
-        if not rep.base_image:
+
+        # If no base image and no user selected packages don't build anything
+        if not self.selected_image and not len(rep.userpkgs):
+            lbl = "<b>No selections made</b>\nYou have not made any selections"
+            lbl = lbl + " so there isn't anything to bake at this time."
+            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            dialog.run()
+            dialog.destroy()
+            return
+        # Else if no base image, ask whether to just build packages or whether
+        # to build a rootfs with the selected packages in
+        elif not self.selected_image:
             lbl = "<b>Build empty image or only packages?</b>\nA base image"
             lbl = lbl + " has not been selected.\n\'Empty image' will build"
             lbl = lbl + " an image with only the selected packages as its"
-- 
1.7.6



