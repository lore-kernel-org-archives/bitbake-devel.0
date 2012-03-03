Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3d8j-00064W-KA
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 01:48:01 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 16:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113997896"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.107])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 16:39:26 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:39:20 -0800
Message-Id: <4994d44f42e195fe92f75e9f562eb9de0d974371.1330734444.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
Subject: [PATCH 4/6] ui/crumbs/imageconfigurationpage: make use of the HobInfoButton
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
X-List-Received-Date: Sat, 03 Mar 2012 00:48:01 -0000

Use the new HobInfoButton widget in place of the existing gtk.Image with
tooltip.

Modify the markup of the tooltip so that the link to the reference manual
is a clickable hyperlink.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/imageconfigurationpage.py |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index db54d79..f029bf8 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -24,7 +24,7 @@ import gtk
 import glib
 from bb.ui.crumbs.progressbar import HobProgressBar
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hic, HobXpmLabelButtonBox
+from bb.ui.crumbs.hobwidget import hic, HobXpmLabelButtonBox, HobInfoButton
 from bb.ui.crumbs.hoblistmodel import RecipeListModel
 from bb.ui.crumbs.hobpages import HobPage
 
@@ -137,16 +137,12 @@ class ImageConfigurationPage (HobPage):
             "Layers", "Add support for machines, software, etc")
         self.layer_button.connect("button-release-event", self.layer_button_clicked_cb)
 
-        icon_file = hic.ICON_INFO_DISPLAY_FILE
-        self.layer_info_icon = gtk.Image()
-        pix_buffer = gtk.gdk.pixbuf_new_from_file(icon_file)
-        self.layer_info_icon.set_from_pixbuf(pix_buffer)
         markup = "Layers are a powerful mechanism to extend the Yocto Project "
         markup += "with your own functionality.\n"
-        markup += "For more on layers, check:\n"
+        markup += "For more on layers, check the <a href=\""
         markup += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
-        markup += "poky-ref-manual.html#usingpoky-changes-layers."
-        self.layer_info_icon.set_tooltip_markup(markup)
+        markup += "poky-ref-manual.html#usingpoky-changes-layers\">reference manual</a>."
+        self.layer_info_icon = HobInfoButton(markup, self.get_parent())
 
         self.progress_bar = HobProgressBar()
         self.machine_separator = gtk.HSeparator()
-- 
1.7.7.6



