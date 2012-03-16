Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S8T02-0005q2-Oz
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 09:59:02 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 16 Mar 2012 01:50:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="129677028"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2012 01:50:13 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2012 16:48:12 +0800
Message-Id: <817e7641f1d1df38a4233addbb454a3280576da6.1331887394.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331887394.git.dongxiao.xu@intel.com>
References: <cover.1331887394.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331887394.git.dongxiao.xu@intel.com>
References: <cover.1331887394.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/3] Hob: Fix advanced setting reparse mechanism
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
X-List-Received-Date: Fri, 16 Mar 2012 08:59:03 -0000

When judging if reparse is needed when change values in advanced
setting, we need also include user's own defined variable pairs.

[YOCTO #2121]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 67cc94e..8d73d5f 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -453,6 +453,8 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.variables["PACKAGE_FORMAT"] = self.configuration.curr_package_format
         self.variables["INCOMPATIBLE_LICENSE"] = self.configuration.incompat_license
         self.variables["IMAGE_FSTYPES"] = self.configuration.image_fstypes
+        for key in self.configuration.extra_setting.keys():
+            self.variables[key] = self.configuration.extra_setting[key]
         self.md5 = hashlib.md5(str(sorted(self.variables.items()))).hexdigest()
         self.settings_changed = False
 
-- 
1.7.4.1



