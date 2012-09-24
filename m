Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TG7nQ-0001LQ-Tm
	for bitbake-devel@lists.openembedded.org;
	Mon, 24 Sep 2012 14:29:57 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2012 05:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,474,1344236400"; d="scan'208";a="148374682"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2012 05:17:06 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Sep 2012 15:17:58 +0300
Message-Id: <1348489078-17881-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/builddetailspage: change tooltips and remove a dialog from "Build stopped" message
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
X-List-Received-Date: Mon, 24 Sep 2012 12:29:57 -0000

When you stop a build, a "Build stopped" message appears. I have changed 2 tooltips and
also eliminate the alert that comes up when you click 'Edit packages'.

[YOCTO #3160]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 85f65b7..42cc50d 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -289,7 +289,12 @@ class BuildDetailsPage (HobPage):
 
         action_button = HobButton("Edit %s" % action)
         action_button.set_size_request(-1, 40)
-        action_button.set_tooltip_text("Edit the %s parameters" % action)
+        if action == "image":
+            action_button.set_tooltip_text("Edit the image parameters")
+        elif action == "recipes":
+            action_button.set_tooltip_text("Edit the included recipes")
+        elif action == "packages":
+            action_button.set_tooltip_text("Edit the included packages")
         action_button.connect('clicked', self.stop_primary_action_button_clicked_cb, action)
         build_stop_tab.attach(action_button, 4, 13, 6, 9)
 
@@ -392,7 +397,7 @@ class BuildDetailsPage (HobPage):
         if "recipes" in action:
             self.builder.show_recipes()
         elif "packages" in action:
-            self.builder.show_packages()
+            self.builder.show_packages(ask=False)
         elif "image" in action:
             self.builder.show_configuration()
 
-- 
1.7.9.5



