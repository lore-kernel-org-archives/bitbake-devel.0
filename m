Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9BF3A6DD6E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 15:10:56 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 02 Dec 2013 07:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,811,1378882800"; d="scan'208";a="443207854"
Received: from pmcgurk-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.121.184])
	by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2013 07:10:42 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Dec 2013 15:10:34 +0000
Message-Id: <1385997034-8237-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] hob: fix rotating progress icon animation
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 02 Dec 2013 15:10:57 -0000

I've always found it somewhat annoying that this icon's rotation
animation wasn't quite correct; this was because it was looping around
to the second position instead of the first, which made it appear to
stutter.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 3707d61..2b969c1 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -734,7 +734,7 @@ class HobCellRendererController(gobject.GObject):
         self.current_angle_pos += self.step_angle
         if self.running_mode == self.MODE_CYCLE_RUNNING:
             if (self.current_angle_pos >= 1):
-                self.current_angle_pos = self.step_angle
+                self.current_angle_pos = 0
         else:
             if self.current_angle_pos > 1:
                 self.force_stop()
-- 
1.8.1.2


