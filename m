Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1TMbPJ-0003YE-8V
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Oct 2012 11:19:49 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 12 Oct 2012 02:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,576,1344236400"; d="scan'208";a="233101535"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.39])
	by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2012 02:05:32 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Oct 2012 12:06:23 +0300
Message-Id: <1350032783-18499-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: image size displayed wrong size in edit packages screen
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
X-List-Received-Date: Fri, 12 Oct 2012 09:19:49 -0000

    size_str = '%.1f' % (size*1.0/(1024*1024)) + ' MB'
    from /bitbake/lib/bb/ui/crumbs/hobpages.py file transformed
    the size in MB. In our file it was again multiplied by 1024
    instead of doing a division by 1024, which brought a faulty size on
    the edit packages screen.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 6792fe0..8eb388e 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -208,8 +208,8 @@ class PackageSelectionPage (HobPage):
         selected_packages_size_str = HobPage._size_to_string(selected_packages_size)
 
         image_overhead_factor = self.builder.configuration.image_overhead_factor
-        image_rootfs_size = self.builder.configuration.image_rootfs_size * 1024 # image_rootfs_size is KB
-        image_extra_size = self.builder.configuration.image_extra_size * 1024 # image_extra_size is KB
+        image_rootfs_size = self.builder.configuration.image_rootfs_size / 1024 # image_rootfs_size is KB
+        image_extra_size = self.builder.configuration.image_extra_size / 1024 # image_extra_size is KB
         base_size = image_overhead_factor * selected_packages_size
         image_total_size = max(base_size, image_rootfs_size) + image_extra_size
         if "zypper" in self.builder.configuration.selected_packages:
-- 
1.7.9.5



