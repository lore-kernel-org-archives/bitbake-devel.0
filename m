Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1TRPjt-00059z-2J
	for bitbake-devel@lists.openembedded.org;
	Thu, 25 Oct 2012 17:52:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 25 Oct 2012 08:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,648,1344236400"; d="scan'208";a="238331167"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.37])
	by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2012 08:38:14 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Oct 2012 18:37:30 +0300
Message-Id: <1351179450-17508-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake: hob/builder: Hob crashes because of bad init
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
X-List-Received-Date: Thu, 25 Oct 2012 15:52:57 -0000

Image selection is not properly initialized to none,
and it used before having a chance to have a value.
Due to dynamic nature of Python, variable is used before
it exists, in this case. This causes a crash.
Bug introduced during the fix of [YOCTO #3228]

Fixes [YOCTO #3334]

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 2fc4a29..3c3d303 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -89,6 +89,7 @@ class Configuration:
 
     def __init__(self):
         self.curr_mach = ""
+        self.selected_image = None
         # settings
         self.curr_distro = ""
         self.dldir = self.sstatedir = self.sstatemirror = ""
-- 
1.7.10.4



