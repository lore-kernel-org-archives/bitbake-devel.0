Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TF4iG-0004KT-FM
	for bitbake-devel@lists.openembedded.org;
	Fri, 21 Sep 2012 17:00:16 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Sep 2012 07:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,463,1344236400"; d="scan'208";a="209600015"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.241])
	by orsmga002.jf.intel.com with ESMTP; 21 Sep 2012 07:47:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2012 15:47:26 +0100
Message-Id: <9691daaed08d95177a2c8c7db1d53815faab4ecf.1348238757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 4/4] hob: fix Gtk-WARNINGs due to invalid markup on Back button
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
X-List-Received-Date: Fri, 21 Sep 2012 15:00:16 -0000

You can't use markup characters (e.g '<' or '>') in the labels for many
widgets - you must use the appropriate entities instead.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 85f65b7..a927c21 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -165,7 +165,7 @@ class BuildDetailsPage (HobPage):
         self.builder.handler.build.model.connect_after("row-changed", self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(), self.build_tv)
 
         self.button_box = gtk.HBox(False, 6)
-        self.back_button = HobAltButton('<< Back')
+        self.back_button = HobAltButton('&lt;&lt; Back')
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
-- 
1.7.9.5



