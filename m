Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SIpzn-0000YB-Ot
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 01:33:39 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 13 Apr 2012 16:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130756362"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.191])
	by azsmga001.ch.intel.com with ESMTP; 13 Apr 2012 16:24:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:24:08 -0700
Message-Id: <ec26c73279f25e3f5cc54c51b3de93c7aef09242.1334359239.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1334359238.git.josh@linux.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
In-Reply-To: <cover.1334359238.git.josh@linux.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
Subject: [PATCH 2/4] lib/bb/ui/crumbs/hobwidget: use light text in HobIndicator
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
X-List-Received-Date: Fri, 13 Apr 2012 23:33:40 -0000

Dark text on a dark background is difficult to read. Further the design
document uses white text.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index f878263..7b6e7ae 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -429,7 +429,7 @@ class HobIndicator(gtk.DrawingArea):
             x = (w/2)-(textw/2) + 1
             y = (h/2) - (texth/2) + 1
             ctx.move_to(x, y)
-            self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
+            self.window.draw_layout(self.style.light_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
 
     def set_count(self, count):
         self.count = count
-- 
1.7.7.6



