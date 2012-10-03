Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TJLvZ-00047D-A2
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Oct 2012 12:11:41 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 03 Oct 2012 02:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,527,1344236400"; d="scan'208";a="199985626"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by azsmga001.ch.intel.com with ESMTP; 03 Oct 2012 02:58:39 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Oct 2012 12:04:17 +0300
Message-Id: <1349255057-29737-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/imagedetailspage: disable the deploy tool for qemu machines
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
X-List-Received-Date: Wed, 03 Oct 2012 10:11:41 -0000

- qemu images cannot be deployed to hardware, even if live
images (hddimg and iso) files are created

[YOCTO #3196]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index a843ad4..79bca2e 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -426,6 +426,8 @@ class ImageDetailsPage (HobPage):
         return mach_runnable
 
     def test_deployable(self, image_name):
+        if self.builder.configuration.curr_mach.startswith("qemu"):
+            return False
         deployable = False
         for t in self.builder.parameters.deployable_image_types:
             if image_name.endswith(t):
-- 
1.7.9.5



