Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mvm-000820-Qv
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:28:07 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141535439"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.181])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Mar 2012 17:18:02 -0700
Message-Id: <05b0157121c4038824a3e7c9794cbef1d9984445.1332202341.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
Subject: [PATCH 2/6] ui/crumbs: remove unused return value from append_toolbar_button
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
X-List-Received-Date: Tue, 20 Mar 2012 00:28:07 -0000

No caller of the method uses the returned toolbar variable

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobpages.py               |    2 +-
 lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +++---
 lib/bb/ui/crumbs/imagedetailspage.py       |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobpages.py b/lib/bb/ui/crumbs/hobpages.py
index bd4b292..8137c0d 100755
--- a/lib/bb/ui/crumbs/hobpages.py
+++ b/lib/bb/ui/crumbs/hobpages.py
@@ -84,4 +84,4 @@ class HobPage (gtk.VBox):
         button = toolbar.append_element(gtk.TOOLBAR_CHILD_RADIOBUTTON, None,
                      buttonname, tip_text, "Private text", icon,
                      cb, None)
-        return toolbar, button
+        return button
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index c8f7a56..b0c5daa 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -45,19 +45,19 @@ class ImageConfigurationPage (HobPage):
         self.toolbar.set_orientation(gtk.ORIENTATION_HORIZONTAL)
         self.toolbar.set_style(gtk.TOOLBAR_BOTH)
 
-        _, template_button = self.append_toolbar_button(self.toolbar,
+        template_button = self.append_toolbar_button(self.toolbar,
             "Template",
             hic.ICON_TEMPLATES_DISPLAY_FILE,
             hic.ICON_TEMPLATES_HOVER_FILE,
             "Load a hob building template saved before",
             self.template_button_clicked_cb)
-        _, my_images_button = self.append_toolbar_button(self.toolbar,
+        my_images_button = self.append_toolbar_button(self.toolbar,
             "My images",
             hic.ICON_IMAGES_DISPLAY_FILE,
             hic.ICON_IMAGES_HOVER_FILE,
             "Open images built out previously for running or deployment",
             self.my_images_button_clicked_cb)
-        _, settings_button = self.append_toolbar_button(self.toolbar,
+        settings_button = self.append_toolbar_button(self.toolbar,
             "Settings",
             hic.ICON_SETTINGS_DISPLAY_FILE,
             hic.ICON_SETTINGS_HOVER_FILE,
diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index c063d74..0159d15 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -122,7 +122,7 @@ class ImageDetailsPage (HobPage):
         self.toolbar.set_orientation(gtk.ORIENTATION_HORIZONTAL)
         self.toolbar.set_style(gtk.TOOLBAR_BOTH)
 
-        _, my_images_button = self.append_toolbar_button(self.toolbar,
+        my_images_button = self.append_toolbar_button(self.toolbar,
             "My images",
             hic.ICON_IMAGES_DISPLAY_FILE,
             hic.ICON_IMAGES_HOVER_FILE,
-- 
1.7.7.6



