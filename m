Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SC7UR-00006o-Ne
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 12:49:31 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 26 Mar 2012 03:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121679598"
Received: from hp.sh.intel.com ([10.239.47.1])
	by orsmga001.jf.intel.com with ESMTP; 26 Mar 2012 03:39:06 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 18:41:09 +0800
Message-Id: <086a7c803e1ab429b0833f132d1a01328138ae10.1332752084.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <5812479c5fea3d18618e09521a804a6acd2cefdf.1332752084.git.limingx.l.an@intel.com>
References: <5812479c5fea3d18618e09521a804a6acd2cefdf.1332752084.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1332752084.git.limingx.l.an@intel.com>
References: <cover.1332752084.git.limingx.l.an@intel.com>
Subject: [PATCH 3/5] Hob: change the recipe pasing error dialog icon from 'dialog-info' to 'dialog-error'
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
X-List-Received-Date: Mon, 26 Mar 2012 10:49:31 -0000

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



