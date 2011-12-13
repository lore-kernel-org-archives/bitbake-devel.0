Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RabEO-00045I-Dg
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Dec 2011 23:53:52 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 13 Dec 2011 14:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="86232577"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.215])
	by orsmga001.jf.intel.com with ESMTP; 13 Dec 2011 14:45:43 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2011 14:45:42 -0800
Message-Id: <850d6f9ba3bd4407a6349a5c7a3cccfd0ef1b95d.1323815814.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.4
In-Reply-To: <cover.1323815814.git.josh@linux.intel.com>
References: <cover.1323815814.git.josh@linux.intel.com>
In-Reply-To: <cover.1323815814.git.josh@linux.intel.com>
References: <cover.1323815814.git.josh@linux.intel.com>
Subject: [PATCH 2/2] ui/crumbs/hobprefs: trigger a reparse after changing IMAGE_FSTYPES
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
X-List-Received-Date: Tue, 13 Dec 2011 22:53:52 -0000

As reported on the mailing list[1] when changing IMAGE_FSTYPES through the
hob preferences a reparse is required before the changes will be picked up
by the system. This patch sets the reload_required property of the class to
true when the image types have been modified to ensure the reparse is
triggered.

1. https://lists.yoctoproject.org/pipermail/yocto/2011-December/006002.html

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 5dfb0e6..3f6f128 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -39,6 +39,7 @@ class HobPrefs(gtk.Dialog):
             self.selected_image_types = handler.remove_image_output_type(ot)
 
         self.configurator.setConfVar('IMAGE_FSTYPES', "%s" % " ".join(self.selected_image_types).lstrip(" "))
+        self.reload_required = True
 
     def sdk_machine_combo_changed_cb(self, combo, handler):
         sdk_mach = combo.get_active_text()
-- 
1.7.7.4



