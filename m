Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEcRu-0007iK-Oz
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 10:17:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Apr 2012 01:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="127701032"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 02 Apr 2012 01:08:05 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 16:29:18 +0800
Message-Id: <af8af3250b7810c611b1b41bbe128221d95ac7a1.1333355236.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
References: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
In-Reply-To: <cover.1333355236.git.shane.wang@intel.com>
References: <cover.1333355236.git.shane.wang@intel.com>
Subject: [PATCH 4/6] Hob: avoid the empty white space appearing on top of the gtk.ComboBox
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
X-List-Received-Date: Mon, 02 Apr 2012 08:17:15 -0000

Avoid the empty white space appearing on top of the machine selection combo
box and the image selection combo box in the "Image configuration" screen

[Yocto #2166]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 30f8979..8e9452e 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -143,6 +143,7 @@ class ImageConfigurationPage (HobPage):
         self.machine_title_desc.set_markup(mark)
 
         self.machine_combo = gtk.combo_box_new_text()
+        self.machine_combo.set_wrap_width(1)
         self.machine_combo.connect("changed", self.machine_combo_changed_cb)
 
         icon_file = hic.ICON_LAYERS_DISPLAY_FILE
@@ -191,6 +192,7 @@ class ImageConfigurationPage (HobPage):
         self.image_title_desc.set_markup(mark)
 
         self.image_combo = gtk.combo_box_new_text()
+        self.image_combo.set_wrap_width(1)
         self.image_combo_id = self.image_combo.connect("changed", self.image_combo_changed_cb)
 
         self.image_desc = gtk.Label()
-- 
1.7.6



