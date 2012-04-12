Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SIMPv-0000nA-Tf
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 17:58:40 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Apr 2012 08:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130137428"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 12 Apr 2012 08:49:18 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 23:46:27 +0800
Message-Id: <d64dca4f0fcdcea2641e4751bbd300b7d2aa49e1.1334245432.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334245432.git.dongxiao.xu@intel.com>
References: <cover.1334245432.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334245432.git.dongxiao.xu@intel.com>
References: <cover.1334245432.git.dongxiao.xu@intel.com>
Subject: [PATCH 3/3] Hob: A minor fix on tooltip
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
X-List-Received-Date: Thu, 12 Apr 2012 15:58:40 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 5cc8a59..b0cfcaf 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -392,7 +392,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         j = 1
         for image_type in self.image_types:
             self.image_types_checkbuttons[image_type] = gtk.CheckButton(image_type)
-            self.image_types_checkbuttons[image_type].set_tooltip_text("Build an %s image" % image_type)
+            self.image_types_checkbuttons[image_type].set_tooltip_text("Build a(n) %s image" % image_type)
             table.attach(self.image_types_checkbuttons[image_type], j, j + 4, i, i + 1)
             if image_type in self.configuration.image_fstypes.split():
                 self.image_types_checkbuttons[image_type].set_active(True)
-- 
1.7.4.1



