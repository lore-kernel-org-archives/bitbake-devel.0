Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJr8-00043H-Hp
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:26:02 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 01 Apr 2012 05:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="125778670"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 01 Apr 2012 05:16:54 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:13 +0800
Message-Id: <efbed89e4099ee53e3eae749e501d38a84f6fee4.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
Subject: [PATCH 05/10] Hob: Set stop button sensitive after task started
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
X-List-Received-Date: Sun, 01 Apr 2012 12:26:02 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builddetailspage.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/builddetailspage.py b/lib/bb/ui/crumbs/builddetailspage.py
index aee258a..982166a 100755
--- a/lib/bb/ui/crumbs/builddetailspage.py
+++ b/lib/bb/ui/crumbs/builddetailspage.py
@@ -133,6 +133,7 @@ class BuildDetailsPage (HobPage):
         self.progress_hbox.pack_start(self.progress_bar, expand=True, fill=True)
         self.stop_button = HobAltButton("Stop")
         self.stop_button.connect("clicked", self.stop_button_clicked_cb)
+        self.stop_button.set_sensitive(False)
         self.progress_hbox.pack_end(self.stop_button, expand=False, fill=False)
 
         self.notebook = HobNotebook()
@@ -169,6 +170,7 @@ class BuildDetailsPage (HobPage):
         recipe = os.path.basename(recipe_path).rstrip(".bb")
         tsk_msg = "<b>Running task %s of %s:</b> %s\n<b>Recipe:</b> %s" % (current, total, recipe_task, recipe)
         self.task_status.set_markup(tsk_msg)
+        self.stop_button.set_sensitive(True)
 
     def reset_build_status(self):
         self.task_status.set_markup("\n") # to ensure layout is correct
-- 
1.7.4.1



