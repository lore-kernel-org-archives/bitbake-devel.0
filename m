Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SIUEv-0005LH-Qv
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 02:19:50 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 12 Apr 2012 17:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="131859609"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 12 Apr 2012 17:10:27 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 17:10:22 -0700
Message-Id: <39d93067a6ff177add8dfe0b837556920474c0f6.1334275549.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1334275549.git.josh@linux.intel.com>
References: <cover.1334275549.git.josh@linux.intel.com>
In-Reply-To: <cover.1334275549.git.josh@linux.intel.com>
References: <cover.1334275549.git.josh@linux.intel.com>
Subject: [PATCH 2/3] lib/bb/ui/crumbs/hobwidget: use light text in HobIndicator
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
X-List-Received-Date: Fri, 13 Apr 2012 00:19:50 -0000

Dark text on a dark background is difficult to read. Further the design
document uses white text.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index a3994c0..9beb4e6 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -406,7 +406,7 @@ class HobIndicator(gtk.DrawingArea):
             x = (w/2)-(textw/2) + 1
             y = (h/2) - (texth/2) + 1
             ctx.move_to(x, y)
-            self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
+            self.window.draw_layout(self.style.light_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
 
     def set_count(self, count):
         self.count = count
-- 
1.7.7.6



