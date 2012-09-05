Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1T9Cki-0002tY-Pt
	for bitbake-devel@lists.openembedded.org;
	Wed, 05 Sep 2012 12:22:33 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Sep 2012 03:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,372,1344236400"; d="scan'208";a="141693811"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Sep 2012 03:09:02 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Sep 2012 13:11:25 +0300
Message-Id: <1346839885-29038-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] [HOB] Save toolchain in settings
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
X-List-Received-Date: Wed, 05 Sep 2012 10:22:33 -0000

Toolchain was not saved in the settings dialog ("Output" tab).

[YOCTO #2695]

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 2001ff4..4bebd5a 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -741,6 +741,7 @@ class AdvancedSettingDialog (CrumbsDialog):
             self.configuration.split_proxy("git", self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
             self.configuration.split_proxy("cvs", self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())
 
+        self.configuration.curr_sdk_machine = self.sdk_machine_combo.get_active_text()
         md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
 
-- 
1.7.9.5



