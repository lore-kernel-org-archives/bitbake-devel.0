Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SHAMO-00076Y-LD
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 10:54:04 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Apr 2012 01:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="126815254"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2012 01:44:47 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 16:41:59 +0800
Message-Id: <f01e8ecd2ba0e2fc69e168a6936145d54e44651a.1333960654.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
Subject: [PATCH 3/6] Hob: Fix the pattern patch for image name
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
X-List-Received-Date: Mon, 09 Apr 2012 08:54:04 -0000

Sometimes, users may open an image that is not built by Hob, therefore
its image name is not started with "hob-image-". This commit sets a
looser rule for runnable image matching.

This fixes [YOCTO #2240]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/imagedetailspage.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index b685d11..277f9d4 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -272,8 +272,7 @@ class ImageDetailsPage (HobPage):
     def test_mach_runnable(self, image_name):
         mach_runnable = False
         for t in self.builder.parameters.runnable_machine_patterns:
-            mach_string = image_name.strip(self.builder.hob_image + '-')
-            if mach_string.startswith(t):
+            if t in image_name:
                 mach_runnable = True
                 break
         return mach_runnable
-- 
1.7.4.1



