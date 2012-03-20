Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mvn-000821-BL
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:28:07 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141535442"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.181])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Mar 2012 17:18:03 -0700
Message-Id: <99b9fe836c07c12a36a9944331f89bbba4d46280.1332202341.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
Subject: [PATCH 3/6] ui/crumbs/hobpage: no need to force a Toolbar button type
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

This uses a more concise API that will be more flexible whent he Toolbar
style is updated to match the visual design.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobpages.py |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobpages.py b/lib/bb/ui/crumbs/hobpages.py
index 8137c0d..baf250b 100755
--- a/lib/bb/ui/crumbs/hobpages.py
+++ b/lib/bb/ui/crumbs/hobpages.py
@@ -81,7 +81,5 @@ class HobPage (gtk.VBox):
         pix_buffer = gtk.gdk.pixbuf_new_from_file(icon_display)
         icon.set_from_pixbuf(pix_buffer)
         tip_text = tip
-        button = toolbar.append_element(gtk.TOOLBAR_CHILD_RADIOBUTTON, None,
-                     buttonname, tip_text, "Private text", icon,
-                     cb, None)
+        button = toolbar.append_item(buttonname, tip, None, icon, cb)
         return button
-- 
1.7.7.6



