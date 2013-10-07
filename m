Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 7792660F77
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Oct 2013 15:17:19 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 07 Oct 2013 08:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1050,1371106800"; d="scan'208";a="304243608"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by AZSMGA002.ch.intel.com with ESMTP; 07 Oct 2013 08:17:15 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Oct 2013 18:21:46 +0300
Message-Id: <1381159306-23577-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: change tooltip for live images
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 07 Oct 2013 15:17:19 -0000

This change is needed to inform the user that selecting
live type means that the system will build a hddimg and iso
image.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
index 86a65ae..5542471 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
@@ -234,7 +234,10 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
             article = ""
             if image_type.startswith(("a", "e", "i", "o", "u")):
                 article = "n"
-            self.image_types_checkbuttons[image_type].set_tooltip_text("Build a%s %s image" % (article, image_type))
+            if image_type == "live":
+                self.image_types_checkbuttons[image_type].set_tooltip_text("Build iso and hddimg images")
+            else:
+                self.image_types_checkbuttons[image_type].set_tooltip_text("Build a%s %s image" % (article, image_type))
             table.attach(self.image_types_checkbuttons[image_type], j - 1, j + 3, i, i + 1)
             if image_type in self.configuration.image_fstypes.split():
                 self.image_types_checkbuttons[image_type].set_active(True)
-- 
1.7.9.5


