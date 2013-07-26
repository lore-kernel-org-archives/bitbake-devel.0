Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 8A60D6A960
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 08:26:37 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 26 Jul 2013 01:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,749,1367996400"; d="scan'208";a="337221141"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by azsmga001.ch.intel.com with ESMTP; 26 Jul 2013 01:26:36 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Jul 2013 11:29:05 +0300
Message-Id: <1374827345-15234-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/settings: remove extra variable declarations
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 26 Jul 2013 08:26:37 -0000

When the settings were split in two: simple and advanced,
it seems that some declarations were added in addition on advanced
settings page, and some of them were forgotten on simple
settings page.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |    5 -----
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |    5 -----
 2 files changed, 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
index bbcaba8..8702a52 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
@@ -123,11 +123,6 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         # class members for internal use
         self.distro_combo = None
-        self.dldir_text = None
-        self.sstatedir_text = None
-        self.sstatemirror_text = None
-        self.bb_spinner = None
-        self.pmake_spinner = None
         self.rootfs_size_spinner = None
         self.extra_size_spinner = None
         self.gplv3_checkbox = None
diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index c1bd45f..2672ed8 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -78,12 +78,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.sstatemirrors_changed = 0
         self.bb_spinner = None
         self.pmake_spinner = None
-        self.rootfs_size_spinner = None
-        self.extra_size_spinner = None
-        self.gplv3_checkbox = None
-        self.toolchain_checkbox = None
         self.setting_store = None
-        self.image_types_checkbuttons = {}
 
         self.md5 = self.config_md5()
         self.proxy_md5 = self.config_proxy_md5()
-- 
1.7.9.5


