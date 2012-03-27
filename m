Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SCbDR-0005ig-PK
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 20:33:58 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 27 Mar 2012 11:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146411120"
Received: from hp.sh.intel.com ([10.239.47.1])
	by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2012 11:23:50 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 02:25:47 +0800
Message-Id: <ea8253a3aba7922d28fc1379a6a758e8906c07e5.1332871932.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
References: <cef75d16489fa6c057085c1db733f97b70340428.1332871932.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1332871932.git.limingx.l.an@intel.com>
References: <cover.1332871932.git.limingx.l.an@intel.com>
Subject: [PATCH 3/6] Hob: change the recipe pasing error dialog icon from 'dialog-info' to 'dialog-error'
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
X-List-Received-Date: Tue, 27 Mar 2012 18:33:58 -0000

[YOCTO #2109]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index f32a066..7bf12e2 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -834,7 +834,7 @@ class Builder(gtk.Window):
                 lbl = lbl + "kernel path:" + kernel_path + "\n"
                 lbl = lbl + "source environment path:" + source_env_path + "\n"
                 lbl = lbl + "tmp path: " + tmp_path + "."
-                dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
                 dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
                 dialog.run()
                 dialog.destroy()
-- 
1.7.5.4



