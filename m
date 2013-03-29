Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1ULZjw-0008RU-8r
	for bitbake-devel@lists.openembedded.org;
	Fri, 29 Mar 2013 14:53:08 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 29 Mar 2013 06:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,373,1363158000"; d="scan'208";a="313653546"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2013 06:34:58 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 29 Mar 2013 15:40:18 +0200
Message-Id: <1364564418-17385-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: add tooltip on "clear search" button
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
X-List-Received-Date: Fri, 29 Mar 2013 13:53:08 -0000

[YOCTO #4116]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 51ae782..9b4261a 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -165,6 +165,7 @@ class HobViewTable (gtk.VBox):
         no_result_tab.attach(label, 1, 14, 1, 4)
 
         clear_button = HobButton("Clear search")
+        clear_button.set_tooltip_text("Clear search query")
         clear_button.connect('clicked', self.set_search_entry_clear_cb, entry)
         no_result_tab.attach(clear_button, 16, 19, 1, 4)
 
-- 
1.7.9.5



