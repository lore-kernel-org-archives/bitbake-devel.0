Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SRj1E-0005t4-6L
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 May 2012 13:55:52 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 08 May 2012 04:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="150484313"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 08 May 2012 04:45:59 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 May 2012 19:48:05 +0800
Message-Id: <97b813663dd741e20295a0c19a2d4b46086e5afe.1336477313.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1336477313.git.limingx.l.an@intel.com>
References: <cover.1336477313.git.limingx.l.an@intel.com>
Subject: [PATCH 1/4] Hob: change the refresh icon speed to make it view clear
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
X-List-Received-Date: Tue, 08 May 2012 11:55:55 -0000

Because the arrow icon refresh so fast as the go backward by illusion, so adjust it slow.

[YOCTO #2335]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 751b3e0..6cf73b0 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -1057,7 +1057,7 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
             if self.control.is_active():
                 self.control.on_draw_pixbuf_cb(pix, window.cairo_create(), x, y, w, h, True)
             else:
-                self.control.start_run(200, 0, 0, 1000, 200, tree)
+                self.control.start_run(200, 0, 0, 1000, 150, tree)
         else:
             self.control.remove_running_cell_area(cell_area)
             self.control.on_draw_pixbuf_cb(pix, window.cairo_create(), x, y, w, h, False)
-- 
1.7.5.4



