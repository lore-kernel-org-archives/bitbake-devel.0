Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ioanax.grigoropol@intel.com>) id 1UPWJC-0004Jt-VC
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Apr 2013 13:01:53 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 09 Apr 2013 03:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,438,1363158000"; d="scan'208";a="292271701"
Received: from ideapad.rb.intel.com ([10.237.105.146])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2013 03:43:24 -0700
From: Ioana Grigoropol <ioanax.grigoropol@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  9 Apr 2013 13:25:48 +0300
Message-Id: <1365503148-26605-1-git-send-email-ioanax.grigoropol@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob:Only display scrolled list of images if needed
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
X-List-Received-Date: Tue, 09 Apr 2013 11:01:53 -0000

- do not set the Images window to always display a scroll bar if it is not needed

[Yocto #4171]
Signed-off-by: Ioana Grigoropol <ioanax.grigoropol@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 1d1ae1a..f482a26 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -142,7 +142,7 @@ class HobViewTable (gtk.VBox):
                     col.add_attribute(cell, 'font', column['col_t_id'])
 
         self.scroll = gtk.ScrolledWindow()
-        self.scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
+        self.scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
         self.scroll.add(self.table_tree)
 
         self.pack_end(self.scroll, True, True, 0)
-- 
1.7.9.5



