Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1THCho-0000s1-6f
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 13:56:36 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 27 Sep 2012 04:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,495,1344236400"; d="scan'208";a="227236796"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2012 04:43:42 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Sep 2012 13:49:12 +0300
Message-Id: <1348742952-9110-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/runningbuild: Add missing logging level argument
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
X-List-Received-Date: Thu, 27 Sep 2012 11:56:36 -0000

[YOCTO #3170]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/runningbuild.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 700fd65..b4d19b6 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -374,7 +374,7 @@ class RunningBuild (gobject.GObject):
                 for reason in event._reasons:
                     msg += ("%s\n" % reason)
             self.emit("no-provider", msg)
-            self.emit("log", msg)
+            self.emit("log", "error", msg)
         elif isinstance(event, bb.event.LogExecTTY):
             icon = "dialog-warning"
             color = HobColors.WARNING
-- 
1.7.9.5



