Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SIUEw-0005LH-M4
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 02:19:51 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 12 Apr 2012 17:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="131859611"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 12 Apr 2012 17:10:27 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 17:10:23 -0700
Message-Id: <8903fb425331994da79a70618c1cc590b533ec91.1334275549.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1334275549.git.josh@linux.intel.com>
References: <cover.1334275549.git.josh@linux.intel.com>
In-Reply-To: <cover.1334275549.git.josh@linux.intel.com>
References: <cover.1334275549.git.josh@linux.intel.com>
Subject: [PATCH 3/3] lib/bb/ui/crumbs/imageconfiguration: fix combo boxes drop-down width
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
X-List-Received-Date: Fri, 13 Apr 2012 00:19:51 -0000

The width of the combo boxes drop down should match the combo box
itself.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/imageconfigurationpage.py |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 64c512d..3e38ff4 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -147,7 +147,6 @@ class ImageConfigurationPage (HobPage):
         self.machine_title_desc.set_markup(mark)
 
         self.machine_combo = gtk.combo_box_new_text()
-        self.machine_combo.set_wrap_width(1)
         self.machine_combo.connect("changed", self.machine_combo_changed_cb)
 
         icon_file = hic.ICON_LAYERS_DISPLAY_FILE
@@ -196,7 +195,6 @@ class ImageConfigurationPage (HobPage):
         self.image_title_desc.set_markup(mark)
 
         self.image_combo = gtk.combo_box_new_text()
-        self.image_combo.set_wrap_width(1)
         self.image_combo_id = self.image_combo.connect("changed", self.image_combo_changed_cb)
 
         self.image_desc = gtk.Label()
-- 
1.7.7.6



