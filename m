Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SA03C-0000qs-Rt
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:28:39 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 20 Mar 2012 07:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121097506"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 20 Mar 2012 07:19:38 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 22:41:07 +0800
Message-Id: <a8f5a72d36e9a55ec7a2296e1c9623e177a95a74.1332254194.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
References: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
In-Reply-To: <cover.1332254194.git.shane.wang@intel.com>
References: <cover.1332254194.git.shane.wang@intel.com>
Subject: [PATCH 06/11] Hob: remove the invalid code in hobwidget.py
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
X-List-Received-Date: Tue, 20 Mar 2012 14:28:39 -0000

From: Liming An <limingx.l.an@intel.com>

To delete some code which is not used

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index f0d9cbc..71f0629 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -516,7 +516,6 @@ class HobTabBar(gtk.DrawingArea):
         cr.fill()
 
     def draw_indicator(self, cr, i):
-        style = self.get_style()
         tab_x = self.children[i]["x"]
         tab_y = self.children[i]["y"]
         number = self.children[i]["indicator_number"]
@@ -528,7 +527,6 @@ class HobTabBar(gtk.DrawingArea):
         # x position is offset(tab_width*3/4 - icon_width/2) + start_pos(tab_x)
         x = tab_x + self.tab_width * 3/4 - dest_w/2
         y = tab_y + self.tab_height/2 - dest_h/2
-        cr.move_to(tab_x, tab_y)
         r = min(dest_w, dest_h)/2
         color = cr.set_source_color(gtk.gdk.color_parse(HobColors.ORANGE))
         cr.arc(x + r, y + r, r, 0, 2*math.pi)
-- 
1.7.6



