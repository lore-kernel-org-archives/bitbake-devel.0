Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1THatT-0005t5-Cd
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 15:46:15 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 28 Sep 2012 06:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,502,1344236400"; d="scan'208";a="199355094"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.60])
	by orsmga001.jf.intel.com with ESMTP; 28 Sep 2012 06:32:16 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Sep 2012 15:37:48 +0300
Message-Id: <1348835868-17717-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/builddetailspage: fix failure_primary_action_button_clicked_cb
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
X-List-Received-Date: Fri, 28 Sep 2012 13:46:15 -0000

[YOCTO #3194]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 50073c1..72fd7e9 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -392,7 +392,7 @@ class BuildDetailsPage (HobPage):
             self.builder.show_recipes()
         elif "Edit packages" in action:
             self.builder.show_packages()
-        elif "Edit image configuration" in action:
+        elif "Edit image" in action:
             self.builder.show_configuration()
 
     def stop_primary_action_button_clicked_cb(self, button, action):
-- 
1.7.9.5



