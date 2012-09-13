Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TC8k6-00045D-GU
	for bitbake-devel@lists.openembedded.org;
	Thu, 13 Sep 2012 14:42:02 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 13 Sep 2012 05:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,416,1344236400"; d="scan'208";a="144640972"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by AZSMGA002.ch.intel.com with ESMTP; 13 Sep 2012 05:28:19 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Sep 2012 14:33:34 +0300
Message-Id: <1347536014-13740-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/builddetailspage: Add tooltips to the build failed notification
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
X-List-Received-Date: Thu, 13 Sep 2012 12:42:02 -0000

[YOCTO #3046]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 4d2d947..8d76ade 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -230,18 +230,21 @@ class BuildDetailsPage (HobPage):
         # create button 'Edit packages'
         action_button = HobButton(primary_action)
         action_button.set_size_request(-1, 40)
+        action_button.set_tooltip_text("Edit the %s parameters" % actions)
         action_button.connect('clicked', self.failure_primary_action_button_clicked_cb, primary_action)
         build_fail_tab.attach(action_button, 4, 13, 9, 12)
 
         if log_file:
             open_log_button = HobAltButton("Open log")
             open_log_button.set_relief(gtk.RELIEF_HALF)
+            open_log_button.set_tooltip_text("Open the build's log file")
             open_log_button.connect('clicked', self.failure_open_log_button_clicked_cb, log_file)
             build_fail_tab.attach(open_log_button, 14, 23, 9, 12)
 
         attach_pos = (24 if log_file else 14)
         file_bug_button = HobAltButton('File a bug')
         file_bug_button.set_relief(gtk.RELIEF_HALF)
+        file_bug_button.set_tooltip_text("Open the Yocto Project bug tracking website")
         file_bug_button.connect('clicked', self.failure_activate_file_bug_link_cb)
         build_fail_tab.attach(file_bug_button, attach_pos, attach_pos + 9, 9, 12)
 
-- 
1.7.9.5



