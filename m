Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kQp-0005q7-Da
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:23:03 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 29 Feb 2012 06:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130973493"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 29 Feb 2012 06:14:35 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:26 +0800
Message-Id: <d676659c5d1004ab527f343bc0d757ed61bd6c3f.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 29/32] Hob(crumbs/builder.py): adjust the main window's position and ignore the case lower than 1024x768.
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
X-List-Received-Date: Wed, 29 Feb 2012 14:23:03 -0000

* don't set the position of the main window to the center always
* don't show the message to users if their screen dimensions are lower than 1024x768

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index e9853f2..f41b6a4 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -229,20 +229,12 @@ class Builder(gtk.Window):
     def create_visual_elements(self):
         self.set_title("Hob - Image Creator")
         self.set_icon_name("applications-development")
-        self.set_position(gtk.WIN_POS_CENTER_ALWAYS)
         self.set_resizable(True)
         window_width = self.get_screen().get_width()
         window_height = self.get_screen().get_height()
         if window_width >= hwc.MAIN_WIN_WIDTH:
             window_width = hwc.MAIN_WIN_WIDTH
             window_height = hwc.MAIN_WIN_HEIGHT
-        else:
-            lbl = "<b>Screen dimension mismatched</b>\nfor better usability and visual effects,"
-            lbl = lbl + " the screen dimension should be 1024x768 or above."
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
-            dialog.run()
-            dialog.destroy()
         self.set_size_request(window_width, window_height)
 
         self.vbox = gtk.VBox(False, 0)
-- 
1.7.6



