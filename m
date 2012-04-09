Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SHAMS-00078d-NQ
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 10:54:08 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 09 Apr 2012 01:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="86842932"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 09 Apr 2012 01:44:50 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 16:42:02 +0800
Message-Id: <de15a0370324838a6009154215dca55b4e6126db.1333960654.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
Subject: [PATCH 6/6] Hob: Add an extra 50M space if zypper is selected
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
X-List-Received-Date: Mon, 09 Apr 2012 08:54:09 -0000

If zypper is selected, RPM packaging will add extra 50M free space to
the final image. We need to reflect it in package selection page.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/packageselectionpage.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index dd0df25..91d3e57 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -171,6 +171,8 @@ class PackageSelectionPage (HobPage):
         image_extra_size = self.builder.configuration.image_extra_size * 1024 # image_extra_size is KB
         base_size = image_overhead_factor * selected_packages_size
         image_total_size = max(base_size, image_rootfs_size) + image_extra_size
+        if "zypper" in self.builder.configuration.selected_packages:
+            image_total_size += (51200 * 1024)
         image_total_size_str = HobPage._size_to_string(image_total_size)
 
         self.label.set_text("Packages included: %s\nSelected packages size: %s\nTotal image size: %s" %
-- 
1.7.4.1



