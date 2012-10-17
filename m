Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1TOUlM-0003jW-AR
	for bitbake-devel@lists.openembedded.org;
	Wed, 17 Oct 2012 16:38:24 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 17 Oct 2012 07:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,600,1344236400"; d="scan'208";a="235065484"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.37])
	by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2012 07:24:46 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Oct 2012 17:24:06 +0300
Message-Id: <1350483846-1271-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: hob/builder: Image selection is remembered while changing adv settings
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
X-List-Received-Date: Wed, 17 Oct 2012 14:38:24 -0000

Image selection is remembered correctly even after
advanced settings have been changed.
Selected image was reset even when it was not the case.

Fixes [YOCTO #3228]

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6ddc5b6..5810b93 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -123,7 +123,6 @@ class Configuration:
         }
 
     def clear_selection(self):
-        self.selected_image = None
         self.selected_recipes = []
         self.selected_packages = []
         self.initial_selected_packages = []
-- 
1.7.9.5



