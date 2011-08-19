Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeG-0005CB-Rz
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:27 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058948"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:24 -0700
Message-Id: <4447349cee757c23ad0bba761c0e5c1a6ae36ebe.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 10/11] bb/ui/crumbs/hobprefs: fix setting IMAGE_FSYTPES
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
X-List-Received-Date: Fri, 19 Aug 2011 01:13:29 -0000

We were setting the value as a list when a string is expected

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 014087b..ee42e58 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -38,7 +38,7 @@ class HobPrefs(gtk.Dialog):
         else:
             self.selected_image_types = handler.remove_image_output_type(ot)
 
-        self.configurator.setLocalConfVar('IMAGE_FSTYPES', "%s" % self.selected_image_types)
+        self.configurator.setLocalConfVar('IMAGE_FSTYPES', "%s" % " ".join(self.selected_image_types).lstrip(" "))
 
     def sdk_machine_combo_changed_cb(self, combo, handler):
         sdk_mach = combo.get_active_text()
-- 
1.7.6



